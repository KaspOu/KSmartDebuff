# Architecture de KSmartDebuff (KDecurse)

> 📌 **L'architecture complète est désormais dans `docs/architecture.md`** (2026-11-02). Ce
> document ne conserve que le **journal de la refonte UI (§11)** et l'historique des anomalies ;
> ne pas l'utiliser comme référence architecture.

> ## ⚠️ AVERTISSEMENT — CE DOCUMENT EST TOTALEMENT INCOMPLÈT
>
> Cette architecture est **partielle, provisoire et non faite pour être une référence**. Elle résulte d'une **analyse statique du 2026-11-01** portant presque exclusivement sur **`Core/SmartDebuff.xml`** (~4 720 lignes après refonte UI — voir §11), le **TOC**, les blocs `SMARTDEBUFF_MENU_*` des `localization.*.lua` et l'inventaire des fichiers.
>
> **Ce qui manque notamment :** l'intérieur de `Core/SmartDebuff.lua` (6 505 lignes — flux d'événements, logique de dispel, macro sécurisées, mode test…), `SmartDebuff.sounds.lua`, tous les fichiers `SmartDebuff_spells_*.lua`, `SmartDebuff.polyfill.lua`, la mécanique des SavedVariables/par défaut, et tout le comportement runtime (combat lockdown, taint, performance).
>
> **Les numéros de ligne sont volatils** (fichier modifié, lignes qui dérivent à chaque édition) : ils décrivent l'état du dépôt après la refonte d'interface (`develop`, commit `34be62a` + étapes tracées en §11). **Toujours vérifier dans le code actuel** avant de s'y fier.
>
> Considérer ce document comme une **ébauche à compléter**, pas comme une spécification.

---

## 1. Périmètre et méthode de l'analyse

| Élément | Couvert ? |
|---|---|
| `SmartDebuff.toc` (ordre de chargement, SavedVariables, multi-flavor) | ✅ Oui |
| `Core/SmartDebuff.xml` — structure, sections, dépendances | ✅ Oui (objet principal) |
| Refonte UI en cours (cadres Home/Infos/MenuList, §11) | ✅ Journalisée (§11) |
| `Bindings.xml`, `.pkgmeta`, scripts de release | ✅ Oui (surface) |
| `Core/SmartDebuff.globals.lua` (constantes, drapeaux) | ⚠️ Partiel (en-tête uniquement) |
| `Core/SmartDebuff.lua` (moteur, 6 505 lignes) | ❌ Non (seule quelques points d'entrée repérés) |
| `SmartDebuff.sounds.lua`, `SmartDebuff_spells_*.lua`, polyfill, localisations | ❌ Non (inventaire seul) |
| Comportement runtime en jeu | ❌ Non |

**Sources** : lecture directe des fichiers, parsing XML (.NET) pour valider le bien formé, extraction regex des dépendances. Aucun test en jeu n'a été effectué pour cette documentation.

## 2. Vue d'ensemble

Addon WoW **KDecurse (SmartDebuff)** — fork de SmartDebuff par Kallye. Deux grands piliers :

```
        ┌────────────────────────────────────────────────────────┐
        │  Core/SmartDebuff.lua  (MOTEUR — 6 505 lignes)         │
        │  événements, scan d'unités, détection de debuffs,      │
        │  boutons d'action, options, sauvegardes, slash cmds    │
        └───────────────▲───────────────────────┬────────────────┘
                        │ handlers OnLoad/      │ lecture/écriture
                        │ OnClick/OnShow        │ SMARTDEBUFF_Options…
        ┌───────────────┴───────────────────────▼────────────────┐
        │  Core/SmartDebuff.xml  (UI — 4 720 lignes)             │
        │  déclaration des frames, templates, scripts inline     │
        │  chargé EN DERNIER par le TOC                          │
        └────────────────────────────────────────────────────────┘
```

- Le XML ne contient **pas** de logique métier : uniquement de l'agencement (Size/Anchors) et des handlers Lua inline qui **déléguent** aux fonctions `SMARTDEBUFF_*` définies dans le Lua chargé avant.
- Le Lua, lui, référence les frames **par leur nom global résolu** (`SmartDebuffOF_cbShowSpellIcon:Click()`…), ce qui crée une **couplage bidirectionnel fort XML ↔ Lua**.

## 3. Ordre de chargement (source : `SmartDebuff.toc`)

| # | Fichier | Rôle |
|---|---|---|
| 1 | `UTF8/utf8data.lua`, `UTF8/utf8.lua` | Tables/cas UTF-8 |
| 2 | `Core/SmartDebuff.globals.lua` | Constantes globales, backdrops, `KD_Settings`, drapeaux (`SMARTDEBUFF_AURACONTAINERS`, `SMARTDEBUFF_MACROTEXT`, `SMARTDEBUFF_HASSECRETS`, `SMARTDEBUFF_IS_DEV`) |
| 3 | `Core/SmartDebuff_spells_{Vanilla,TBC,Wrath,Cata,Mists,Forever,}.lua` | Tables de sorts **mutuellement exclusives** par `[AllowLoadGameType]` (Forever exclut standard) |
| 4 | `Core/localization.{en,fr,de,es,it,ko,pt,ru,tw}.lua` | Textes ; `en` inconditionnel, autres par `[AllowLoadTextLocale]` |
| 5 | `Core/SmartDebuff.polyfill.lua` | Compat inter-versions |
| 6 | `Core/SmartDebuff.sounds.lua` | Sons d'auras |
| 7 | **`Core/SmartDebuff.lua`** | Moteur — définit toutes les fonctions appelées par le XML |
| 8 | **`Core/SmartDebuff.xml`** | UI — **dernier** ; les `OnLoad` s'exécutent immédiatement |

Éléments transverses :
- `Bindings.xml` (racine) : binding `SMARTDEBUFF` → `SMARTDEBUFF_ToggleOF()`.
- Métadonnées : `## Interface: 120100, 120105, 16001, 50504, 38002, 20506, 11509` (retail Midnight 12.1, classiques, Forever), version `12.1.503`.

### SavedVariables

| Variable | Portée | Contenu connu |
|---|---|---|
| `SMARTDEBUFF_OptionsGlobal` | compte | `FirstStart`, préférences globales… |
| `KD_Settings` | compte | `ForceEnglish`, `AddonCompartment` — **partagée avec KCursorCooldown** |
| `SMARTDEBUFF_Options` | personnage | ~50 champs (voir §6) |

`## LoadSavedVariablesFirst: 1` → le Lua lit/initialise les sauvegardes tôt (`SMARTDEBUFF_Options_Init`, L1358 de `SmartDebuff.lua`).

## 4. Carte structurelle de `Core/SmartDebuff.xml` (état 2026-11-01 — post-refonte, voir §11)

Racine `<Ui>` (namespace Blizzard WoW UI). Enfants de premier niveau, dans l'ordre du fichier (**4 720 lignes**) :

| Lignes | Élément | Rôle |
|---|---|---|
| 3–24 | `Slider` **virtuel** `SmartDebuffOptionsSliderTemplate` | Template réutilisé par tous les sliders (~15) |
| 25–34 | `Frame` **SmartDebuffFrame** | **Boucle principale** : `OnLoad` → `SMARTDEBUFF_OnLoad(self)`, `OnUpdate` → `SMARTDEBUFF_OnUpdate(self, elapsed)` |
| 36–42 | `GameTooltip` **SmartDebuffTooltip** (1/2) | Tooltip interne, `SetOwner(SmartDebuffFrame, "ANCHOR_NONE")` |
| 44–75 | 6 × `Font` virtuels | `…NormalMini` (9px), `…HighlightMini`, `…NormalMicro` (8px), `…HighlightMicro`, `SmartDebuff_Font`, `SmartDebuff_FontHP` |
| 77–82 | `GameTooltip` **SmartDebuffTooltip** (2/2) | **Doublon exact** (anomalie §8.1) |
| 84–246 | `Frame` **SmartDebuffSF** | Panneau compact flottant : `_btnClose`, `_btnStyle` ("K" : clics Alt/Shift/Droit), `_btnOptions` ("O"), `_Title` |
| 248–333 | `Frame` **SmartDebuffIF** | Frame d'info (`_lblInfo`, `_lblOut`) — déplacée Shift+glisser |
| **335–≈2713** | `Frame` **SmartDebuffOF** | **Panneau d'options** — 13 enfants dont **Home / Infos / MenuList** (détail §5) |
| 2714–2818 | `Frame` **SmartDebuffClassOrder** | Ordre des classes (`FauxScrollFrameTemplate` + Reset) |
| 2820–2945 | `Frame` **SmartDebuffSounds** | Liste des sons (`_txtIn`, scroll, Reset) |
| 2947–3089 | `Frame` **SmartDebuffNRDebuffs** | Debuffs non retirables — saisie `SpellID` (`C_Spell.GetSpellInfo`) |
| 3091–3222 | `Frame` **SmartDebuffSpellGuard** | Sorts de HoT / Spell Guard (liste de suivi) |
| 3224–3278 | `Frame` **SmartDebuffAOFKeys** | Raccourcis/clés — contenu **généré en Lua** (`SmartDebuffAOFKeys_OnShow`) |
| 3280–3927 | `Frame` **SmartDebuffGridSetup** | 10 cases + 8 sliders de mise en page grille |
| 3929–4009 | `Frame` **SmartDebuffMisc** | AuraSpellIDs, ChatNotif, **AddonCompartment**, **Force English** (`KD_Settings`) |
| 4011–4555 | `Frame` **SmartDebuffColors** | Couleurs/opaçités : 6 boutons test + 5 `ColorSelect`, sliders `sldADebuff`/`sldNormal`/`sldNormalOOR` |
| 4557–4641 | `Frame` **SmartDebuffAuraSounds** | Sons d'auras (272 px, ancré sur `SmartDebuffSounds`) |
| 4643–4719 | `Frame` **SmartDebuffWNF** | « What's New » (`_lblText`, repositionnement dynamique) |
| 4720 | `</Ui>` | Fin |

> **Changements vs la version initiale du document** : `SmartDebuffOF_AdvancedMask` **supprimé** (§11.1) ; les options `cbGrp1 → TextureDropDown` sont désormais dans **`SmartDebuffOF_Home`** (§5.2) ; trois cadres neufs **Home / Infos / MenuList** (§5).

Tous les panneaux sauf `SmartDebuffSF/IF/WNF` sont `parent="SmartDebuffOF"`, `hidden="true"`, ancrés `TOPLEFT → SmartDebuffOF TOPRIGHT (+2, 0)`, et calent leur hauteur sur `SmartDebuffOF:GetHeight()` en OnLoad/OnShow.

## 5. Détail de `SmartDebuffOF` (L335–≈2713)

### 5.1 Enfants directs (13 — état actuel après refonte §11)

| Ligne | Enfant | Rôle |
|---|---|---|
| L348 | `_Title` | Titre éditable (KDecurse) |
| L369 | `_btnClose` | Fermeture (`UIPanelCloseButton`) |
| **L381–≈2141** | **`_Home`** | **Conteneur des options** (§5.2) |
| **L2148** | **`_Infos`** | **Cadre moitié gauche, `hidden`** (§5.3) |
| **L2156–≈2416** | **`_MenuList`** | **Menu principal** (§5.4) |
| L2418 | `_btnReload` | Dev — ancré **au-dessus du menu** (§5.5) |
| L2449 | `_btnTestMode` | ancré au-dessus du menu |
| L2476 | `_btnFakeMode` | à gauche de `btnTestMode` |
| L2505 | `_btnGlobalSave` | ancré au-dessus du menu |
| L2532 | `_btnGlobalLoad` | à gauche de `btnGlobalSave` (inchangé) |
| L2560 | `_cbShowNotRemov` | zone dev (`IS_DEV`), ancré sur `btnTestMode` |
| L2604 | `_btnNotRemov` | zone dev |
| L2638 | `_cbShowInfoFrame` | zone dev |

**Supprimés lors de la refonte** (remplacés par le menu) : `_btnGridSetup`, `_btnColorSetup`, `_btnMisc` ; dans Home : `_btnClassOrder`, `_btnSpellGuard`, `_btnSounds` (§11).

### 5.2 `SmartDebuffOF_Home` (L381–≈2141) — conteneur des options

- Enfant de l'OF, `enableMouse="false"`, **304×540**, ancré `TOPLEFT (0,0)` de l'OF → **origine identique à l'OF : coordonnées internes inchangées à l'écran**.
- **48 enfants directs** : les 50 anciens contrôles `cbGrp1` → `sldCheckInterval` + `SmartDebuffColTextureDropDown`, **−3 boutons supprimés** (`btnClassOrder`, `btnSpellGuard`, `btnSounds`). **`SmartDebuffOF_btnKeys` conservé (L1643)** — doublon volontaire avec l'item « Keys » du menu.
- **Renommages** : `name="$parent_X"` → `name="SmartDebuffOF_X"` (×50) et `relativeTo="$parent_X"` → absolu → **noms globaux résolus identiques, Lua non impacté** ; les 2 seuls `GetParent():GetName()` réécrits en `_G["SmartDebuffOF_cbRoleView"]` / `_G["SmartDebuffOF_cbClassView"]`.
- Ancrages internes inchangés ; seule racine « orpheline » : `cbGrp1` (`TOPLEFT 4/−20`, ré-ancré sur Home — identique car Home coïncide avec l'OF).

### 5.3 `SmartDebuffOF_Infos` (L2148)

- `hidden="true"`, **152×540** (= moitié de la largeur de l'OF), `TOPLEFT (0,0)`, `enableMouse="false"`, **après Home dans le DOM** (au-dessus en z).
- Aucun enfant pour l'instant. Bascule « afficher Infos masque Home » : **non implémentée (hors scope)**.

### 5.4 `SmartDebuffOF_MenuList` (L2156–≈2416) — menu principal de l'addon

- **148×136**, ancré `BOTTOMLEFT (8, 6)` de l'OF, `enableMouse="false"` (les clics sur le vide passent à l'OF).
- **Contour** : `BackdropTemplateMixin` + `SMARTDEBUFF_BACKDROP_OPTIONS` + `SetBackdropBorderColor(1, 0.82, 0, 1)` (or).
- **8 items** `Button` **sans template** (aucun look bouton WoW), **140×16**, empilés `TOPLEFT → BOTTOMLEFT` depuis `(4, −4)` → padding 4 px, alignement strict, **pas de scroll**.
- Visuel : texte `GameFontHighlight` blanc ; highlight `WHITE8X8` masqué au repos → **survol blanc α0.12** ; **état actif = texte or + fond or α0.10** ; clic sur **toute la ligne** ; `RegisterForClicks(SMARTDEBUFF_KEYFORCLICK)`.
- **État actif** : fonction globale `SmartDebuffOF_MenuList_Refresh()` définie dans le `OnLoad` du conteneur, pilotée par un `OnUpdate` throttlé (0,2 s) qui compare `self.panelName` → `_G[…]:IsShown()`, + appel immédiat en `OnClick`. **Aucun panneau existant modifié.**

| Item (`SmartDebuffOF_MenuList_…`) | Libellé (constante) | `OnClick` | `panelName` suivi |
|---|---|---|---|
| `_Home` | `SMARTDEBUFF_MENU_HOME` (« Accueil »…) | `SMARTDEBUFF_HomeToggle()` ⚠️ **Lua à venir** | `SmartDebuffOF_Home` |
| `_Keys` | `SMARTDEBUFF_OFT_SKILLS` (inchangé) | `SMARTDEBUFF_ToggleAOFKeys()` | `SmartDebuffAOFKeys` |
| `_Grid` | `SMARTDEBUFF_MENU_GRID` (« Grille ») | `SMARTDEBUFF_GridToggle()` | `SmartDebuffGridSetup` |
| `_Colors` | `SMARTDEBUFF_MENU_COLORS` (« Couleurs ») | `SMARTDEBUFF_ColorsToggle()` | `SmartDebuffColors` |
| `_Sounds` | `SMARTDEBUFF_OFT_SOUND` (inchangé) | `SMARTDEBUFF_SoundsToggle()` | `SmartDebuffSounds` |
| `_SpellGuard` | `SMARTDEBUFF_MENU_HOTS` (« Sorts de HoT ») | `SMARTDEBUFF_SpellGuardToggle()` | `SmartDebuffSpellGuard` |
| `_ClassOrder` | `SMARTDEBUFF_MENU_CLASSORDER` (« Ordre des classes ») | `SMARTDEBUFF_ClassOrderToggle()` | `SmartDebuffClassOrder` |
| `_Misc` | `MISCELLANEOUS` (inchangé) | `SMARTDEBUFF_MiscToggle()` | `SmartDebuffMisc` |

Libellés `SMARTDEBUFF_MENU_*` : **5 constantes traduites dans les 9 fichiers `localization.*.lua`** (en/fr/de/es/it/ko/pt/ru/tw), bloc `-- Main menu (SmartDebuffOF_MenuList)`. Tooltips des items = constantes `OFT_*/TT_*` d'origine (inchangées).

### 5.5 Boutons bas — ancrés **au-dessus du menu**

- `btnGlobalSave` : `BOTTOMRIGHT → TOPRIGHT de MenuList (0, 4)` · `btnTestMode` : `(0, 28)` · `btnReload` : `(0, 52)` — **mêmes écarts qu'auparavant** (24 px entre rangées).
- `btnGlobalLoad` : à gauche de `btnGlobalSave` (inchangé) ; **`btnFakeMode` : à gauche de `btnTestMode`** (`BOTTOMRIGHT → BOTTOMLEFT btnTestMode`, `-4/0`).
- Géométrie : haut du menu = y142 → rangées à y146 / 170 / 194 (haut du groupe ≈214, marge ≈50 px sous le contenu bas de Home).
- ⚠️ La chaîne dev (`cbShowNotRemov` `TOPLEFT btnTestMode +(0,-32)`, `btnNotRemov`, `cbShowInfoFrame`) **suit `btnTestMode`** → recouvrements partiels en mode `IS_DEV` (§8.2).

### 5.6 Ancrages à connaître (après refonte)

- **Dans Home** (chaînes inchangées) : `_cbGrp1→…→_cbGrp8` ; `_cbClassIcon1→…→16` ; `_cbHP→_cbMana→_cbHPText` (+ `_cbInvert`) ; `_cbClassView→_cbShowLR→_cbShowAggro→_cbShowHealRange→_cbTargetMode→_cbShowDebuffTooltip→_cbAutoHide→_cbAdvAnchors` (colonne gauche, doublons `x=+152` / `+87/+106/+108/+115/+130`).
- **SmartDebuffGridSetup** (panneau) : chaîne verticale `_cbVertical → … → _cbShowRoleDpsIcon`, puis sliders `sldFontsize → … → sldSpaceY` (inchangée).
- **Nouveauté** : les boutons bas sont ancrés **relativement au menu** (suivent s'il bouge) ; les items du menu forment leur propre chaîne (§5.4).
- **Insérer un contrôle au milieu d'une chaîne décale tout ce qui suit** (régression silencieuse).

## 6. Dépendances

### 6.1 Templates et API Blizzard utilisés par le XML

`UISliderTemplate` (via `SmartDebuffOptionsSliderTemplate`), `UIPanelCloseButton`, `UIPanelButtonTemplate`, `UIMenuButtonStretchTemplate`, `InterfaceOptionsCheckButtonTemplate`, `UIDropDownMenuTemplate` (+ `UIDropDownMenu_Initialize/CreateInfo/AddButton/SetSelectedValue/SetText/JustifyText`), `FauxScrollFrameTemplate` (+ `FauxScrollFrame_OnVerticalScroll`), `InputBoxTemplate`, `GameTooltipTemplate`, `SystemFont_Tiny`, `GameFontNormalSmall/HighlightSmall/Highlight`, `BackdropTemplateMixin` (+ `Mixin`, `CreateColor`, `SetGradient`), `C_Spell.GetSpellInfo`, `PlaySound`/`SOUNDKIT`, `InCombatLockdown`, `IsAltKeyDown/IsShiftKeyDown`, `AddonCompartmentFrame`.

### 6.2 Fonctions Lua attendues par le XML (~76, définies dans `SmartDebuff.lua` sauf mention)

**Cycle de vie** : `SMARTDEBUFF_OnLoad`, `SMARTDEBUFF_OnUpdate`.

**Toggles (clics)** : `ToggleSF`, `ToggleShowLR`, `ToggleClassColors`, `ToggleSortedByClass`, `ToggleSFBackdrop`, `ToggleWhatsNew`, `ToggleOF`, `ToggleIF`, `ToggleAOFKeys`, `ToggleAnchors`, `ToggleNRDebuffs`, `SpellGuardToggle`, `SoundsToggle`, `MiscToggle`, `ColorsToggle`, `GridToggle`, `ClassOrderToggle`, `TestModeToggle`, `FilterStringToggle`, `OFToggleGrp`, `GlobalSave`, `GlobalLoad`, `RegisterCompartment`, `SetMoving`.

**Rafraîchissement UI** : `SetButtons`, `SetStyle`, `SetPetButtons`, `CreateButtonsPetsIfEnabled`, `CheckDebuffs`, `CheckSFButtons`, `CheckCVars`, `ColorsUpdate`, `ColorsBackdrop`.

**Callbacks d'ouverture/fermeture par panneau** : `OFOnShow/OnHide`, `ClassOrderOnShow/OnHide/OnScroll`, `SoundsOnShow/OnHide/OnScroll`, `NRDebuffsOnShow/OnHide`, `NRDOnScroll`, `SpellGuardOnShow/OnHide/OnScroll`, `AuraSoundsOnShow/OnHide/OnScroll`, `GridOnShow/OnHide`, `MiscOnShow/OnHide`, `ColorsOnShow/OnHide`, `SmartDebuffAOFKeys_OnShow`.

**Helpers** : `SmartDebuffOFSlider_OnLoad(self, low, high, step)`, `SetGameTooltip`, `DisableCheckButton`, `AddTextToTable`, `AddMsgD`, `AddMsgErr`, `SetDefaultClassOrder/Sound/NotRemovableDebuffs/SpellGuard/Keys/Colors`, `SetAuraSoundsTestMode`, `SetAuraSoundsDetectTest`, **`SmartDebuffOF_MenuList_Refresh`** (définie **dans le XML**, §5.4), **`SMARTDEBUFF_HomeToggle`** (⚠️ **attendu côté Lua, pas encore défini** — appelé par l'item Accueil).

> Les appels Lua dans les handlers XML échouent **silencieusement en erreur** si la fonction disparaît (ex. renommage) : c'est la principale source de régression à chercher après toute modif.

### 6.3 État partagé

| Variable | Utilisation dans le XML |
|---|---|
| `SMARTDEBUFF_Options` (~50 champs) | Lecture/écriture systématique gardée par `if (SMARTDEBUFF_Options) then` : `DebuffGrp[1..8]`, `DebuffClasses[<CLASS>]`, `ShowPets/ShowPetsWL/ShowPetsDK`, `ShowHP`, `ShowMana`, `ShowHPText`, `Invert`, `SortedByClass`, `SortedByRole`, `ShowLR`, `ForceLR`, `ShowRaidIcon`, `ShowAggro`, `ShowHealRange`, `TargetMode`, `ShowSpellIcon`, `ShowVehicles`, `UseSound`, `ShowDebuffTooltip`, `ShowTooltip`, `AutoHide`, `IgnoreDebuff`, `AdvAnchors`, `StopCast`, `CheckInterval`, `ColDTexture`, `ShowNotRemov`, `ShowIF`, `NotRemovableDebuffs`, `SpellGuard`, `Vertical`, `VerticalUp`, `ShowHeaders`, `ShowGrpNr`, `ShowInfoRow`, `ShowHeaderRow`, `ShowBackdrop`, `ShowClassColors`, `ShowGradient`, `ShowRoleIcon`, `ShowRoleDpsIcon`, `Fontsize`, `RaidIconSize`, `Columns`, `BarH`, `BtnW`, `BtnH`, `BtnSpX`, `BtnSpY`, `ADebuff`, `ANormal`, `ANormalOOR`, `ColDebuffL/R/M/NR`, `ColNormal`, `ShowAuraSpellIDs`, `ChatNotif`, `VersionNr` |
| `SMARTDEBUFF_OptionsGlobal` | `FirstStart` (bouton Reload debug) |
| `KD_Settings` | `AddonCompartment`, `ForceEnglish` (panneau Misc) |
| Constantes | `SMARTDEBUFF_HEADERS`, `SMARTDEBUFF_CLASSES`, `SMARTDEBUFF_OFT_*/TT_*`, `SMARTDEBUFF_TTC_*`, `SMARTDEBUFF_TEXTURES`, `SMARTDEBUFF_BACKDROP_*`, `SMARTDEBUFF_KEYFORCLICK`, `SMARTDEBUFF_TITLE/TT`, `SDB_ERROR_SOUND`, **`SMARTDEBUFF_MENU_*`** (5 libellés × 9 langues, §5.4) |

### 6.4 Drapeaux conditionnels (comportement variable selon client/dev)

| Drapeau | Origine | Effet dans le XML |
|---|---|---|
| `SMARTDEBUFF_AURACONTAINERS` | `globals.lua` (`AuraContainerSortDirection`) | Désactive `_cbShowDebuffTooltip` et `_cbShowAuraSpellIDs` (l'ancien masquage de `_btnSpellGuard` n'est plus appliqué — écart §8.10) |
| `SMARTDEBUFF_MACROTEXT` | `globals.lua` | Désactive `_cbStopCast` |
| `SMARTDEBUFF_HASSECRETS` | `globals.lua` | Anciennement masquait `_btnSpellGuard` (bouton supprimé à l'étape menu — écart §8.10) |
| `SMARTDEBUFF_IS_DEV` | `globals.lua` (`--@do-not-package@`) | Seul moyen d'afficher `_cbShowNotRemov`, `_btnNotRemov`, `_cbShowInfoFrame` ; `_btnReload`, `_btnFakeMode` masqués par défaut (affichés en dev) |
| `SMARTDEBUFF_CLASSES["<CLASS>"]` | Lua | Auto-masquage icônes DK/Monk/DH/Evoker + pets DK |
| `SMARTDEBUFF_OFT_FORCELR == ""` | localisation | Masque `_cbForceLR` en anglais |

## 7. Points d'entrée Lua connus (`Core/SmartDebuff.lua`, 6 505 lignes — repérage partiel)

| Fonction | Ligne (2026-11-01) | Rôle |
|---|---|---|
| `SMARTDEBUFF_OnLoad(self)` | L446 | Initialisation appelée par `SmartDebuffFrame` |
| `SMARTDEBUFF_OnEvent(self, event, …)` | L503 | Flux d'événements (détail **non analysé**) |
| `SMARTDEBUFF_OnUpdate(self, elapsed)` | L588 | Boucle appelée par `SmartDebuffFrame` |
| `SMARTDEBUFF_Ticker(force)` | L622 | Timer complémentaire (détail **non analysé**) |
| `SMARTDEBUFF_SetUnits()` / `AddUnit()` | L764 / L848 | Collecte des unités |
| `SmartDebuffOFSlider_OnLoad(self, low, high, step)` | L960 | Init sliders (appelé par le XML) |
| `SMARTDEBUFF_SetSpells()` | L1047 | Configuration des sorts joueur |
| `SMARTDEBUFF_Options_Init()` | L1358 | Initialisation/migration des options |
| `SMARTDEBUFF_SetDefault*()` | L1612–1656 | Valeurs par défaut (couleurs, listes, sons, clés…) |

Le reste du fichier (scan de debuffs, couleurs, boutons d'action sécurisés, macros, mode test, slash commands `/kd…`) **n'est pas documenté ici**.

## 8. Anomalies et ambiguïtés préexistantes (à ne pas corriger sans demande)

1. **Doublon `SmartDebuffTooltip`** : deux `<GameTooltip name="SmartDebuffTooltip">` strictement identiques (L36–42 et L77–82). Le second masque le premier à la création. Comportement toléré par le client — laisser tel quel.
2. **Chaîne dev en recouvrement (mode `IS_DEV`)** : `cbShowNotRemov` (`TOPLEFT de btnTestMode + (0,-32)`) et `cbShowInfoFrame` suivent `btnTestMode` depuis son déplacement au-dessus du menu (§5.5) → recouvrent le coin de `btnGlobalSave` et le haut du menu (ligne « Accueil »). Dev-only ; à ré-ancrer si gênant.
3. **Indentation hétérogène** : `SmartDebuffOF_cbShowRoleIcon` (décalé), scripts de `SmartDebuffGridSetup`/`SmartDebuffMisc` non indentés, attributs parfois écrits sur une seule ligne (`_cbForceLR`).
4. **`KD_Settings` cross-projet** : même SavedVariable partagée avec KCursorCooldown (KaspOu) — ne pas y mettre d'état propre à SmartDebuff sans l'avoir vérifié.
5. **`SmartDebuffColTextureDropDown`** : nom global absolu — seul enfant de Home à ne pas provenir d'un `name="$parent_…"` (conservé tel quel lors du déplacement).
6. **Textes en dur** dans le XML malgré la localisation : `"Reload (Debug)"`, `"Toggle filterString"`, `"Force English"`, `MISCELLANEOUS`/`OPTIONS`/`UNLOCK_FRAME` (globals Blizzard).
7. **Constantes orphelines** : `SMARTDEBUFF_OFT_GRIDSETUP` et `SMARTDEBUFF_OFT_COLORSETUP` ne sont plus appelées depuis la suppression des boutons correspondants (conservées, sans effet).
8. **Écart connu de l'étape menu (§11.4)** : l'item « Sorts de HoT » n'a **pas hérité** de la condition de masquage de l'ancien `btnSpellGuard` (`if (SMARTDEBUFF_HASSECRETS and not SMARTDEBUFF_AURACONTAINERS) then self:Hide() end`). À réintégrer si le comportement client-compat doit être conservé.
9. **Volatilité des numéros de ligne** : ils décrivent l'état `34be62a` + évolutions §11 — toujours vérifier dans le code actuel.

## 9. Points de vigilance régression

1. **Couplage XML ↔ Lua** : renommer/déplacer un contrôle casse les usages `_G[...]` côté Lua et inversement (grep systématique avant/après).
2. **Chaînes d'ancrage** : celles de Home et de GridSetup (§5.6) ; les **ancres relatives à `SmartDebuffOF_MenuList`** font suivre les boutons bas si le menu bouge ; la **chaîne dev** fait suivre `btnTestMode` (§5.5).
3. **Handlers `InCombatLockdown`** : ne jamais retirer (taint/combat).
4. **Ordre de chargement** (§3) : ajouter un fichier Lua ⇒ l'insérer au bon endroit du TOC ; le XML doit rester **dernier**.
5. **Gardes `if (SMARTDEBUFF_Options) then`** : préservées telles quelles (sauvegarde absente au premier chargement).
6. **Drapeaux §6.4** : un contrôle désactivé/masqué est fonctionnel sur d'autres clients — ne pas le supprimer « parce qu'il ne s'affiche pas ».
7. **`SmartDebuffOF_btnKeys` est un doublon volontaire** (bouton d'origine dans Home + item « Keys » du menu) — ne pas le supprimer sans demande.
8. **`SMARTDEBUFF_HomeToggle()`** : appelé par l'item Accueil mais **pas encore défini** → erreur Lua au clic tant que le Lua n'est pas écrit.
9. **Noms absolus dans Home** : `SmartDebuffOF_cb*`/`sld*` sont des noms **codés en dur** depuis la refonte — un retour à `$parent_` recasserait le Lua.
10. **Validation** : voir `AGENTS.md` §6 (parse XML + cohérence TOC + test en jeu `/kd`, `/kdo`).

## 10. Ce qui n'est PAS couvert par ce document

- ❌ Logique interne de `SmartDebuff.lua` : événements, scan d'auras, décision de dispel, couleurs appliquées aux boutons, cycle `OnUpdate`, macros sécurisées, test mode, slash commands, hooks.
- ❌ `SmartDebuff.sounds.lua` (16 Ko) et `SmartDebuffAuraSounds` en runtime.
- ❌ Contenu des `SmartDebuff_spells_*.lua` et de `SMARTDEBUFF_DEBUFFS_LIST` (Forever…).
- ❌ `SmartDebuff.polyfill.lua` et la stratégie de compat multi-flavor.
- ❌ Localisations : structure des tables `SMARTDEBUFF_OFT_*/TT_*` par langue.
- ❌ Performances / taint / combat lockdown en conditions réelles.
- ❌ Génération dynamique des boutons (`SmartDebuffSF` crée les boutons d'unités **en Lua**, pas en XML).
- ❌ Historique et design des migrations d'options (`ReplaceDeprecatedOptions`).
- ❌ `SMARTDEBUFF_HomeToggle()` et la bascule « afficher Infos masque Home » : **appelés côté XML, non implémentés côté Lua** (§5.3, §5.4).
- ❌ L'interface post-refonte n'a **pas été testée en jeu** (validation statique uniquement : parse XML, greps, contrôles d'ancres).

**Ces lacunes sont volontaires et explicites : ce document est une ébauche incomplète, à enrichir au fur et à mesure de l'exploration du code.**

---

## 11. Journal des évolutions UI (refonte du 2026-11-01)

Refonte en cours de l'écran d'options, étape par étape (règles appliquées : `AGENTS.md` §5) :

| # | Étape | Commit | Détail |
|---|---|---|---|
| 1 | Suppression du masque | `6f10a91` | `SmartDebuffOF_AdvancedMask` + son bouton `btnOptions` supprimés (−111 lignes). Aucune référence Lua/ancrage existante. |
| 2 | Re positionnement boutons bas | `4478b7c` | `btnTestMode` → ex-emplacement de `btnMisc` (colonne droite) ; `btnFakeMode` → à gauche de `btnReload`. |
| 3 | Cadres **Home + Infos** | `e6717e8` | **51 contrôles** (`cbGrp1` → `SmartDebuffColTextureDropDown`) déplacés dans `SmartDebuffOF_Home` : renommages `name="$parent_X"` → **`SmartDebuffOF_X`** (noms globaux préservés), `relativeTo` absolus, 2 `GetParent()` → `_G[…]`. `SmartDebuffOF_Infos` créé (152×540, `hidden`). |
| 4 | **Menu de navigation** | `4f5ad75` | `SmartDebuffOF_MenuList` créé (7 items puis 8). **6 boutons supprimés** : `btnGridSetup`, `btnColorSetup`, `btnMisc`, `btnSounds`, `btnSpellGuard`, `btnClassOrder` (0 réf. Lua/ancres vérifiées). **`btnKeys` conservé en doublon**. Items = boutons sans template, OnClick recopiés à l'identique. |
| 5 | Design, **Accueil**, libellés | `4f5ad75`/`d950625` | Texte `GameFontHighlight` (items 140×16, conteneur **148×136**), **contour** `SMARTDEBUFF_BACKDROP_OPTIONS` + bordure or. Item **Accueil** → `SMARTDEBUFF_HomeToggle()` (⚠️ Lua à écrire). 5 libellés → **`SMARTDEBUFF_MENU_*` traduits dans les 9 `localization.*.lua`** : *Accueil / Grille / Couleurs / Sorts de HoT / Ordre des classes* (Keys/Sounds/Misc inchangés). |
| 6 | Boutons **au-dessus du menu** | `34be62a` | `btnGlobalSave`/`btnTestMode`/`btnReload` ré-ancrés `TOPRIGHT de MenuList (0, 4/28/52)` (mêmes écarts), `btnFakeMode` → à gauche de `btnTestMode`, `btnGlobalLoad` inchangé. |

**Effets de bord connus / résidus** :
- `btnMisc` supprimé → le chevauchement temporaire de l'étape 2 est résolu ;
- chaîne dev `cbShowNotRemov`/`cbShowInfoFrame` en recouvrement partiel en mode `IS_DEV` (§8.2) ;
- `OFT_GRIDSETUP`/`OFT_COLORSETUP` devenues orphelines (§8.9) ;
- écart SpellGuard : condition de masquage du vieux bouton non réintégrée dans l'item (§8.10).

**À venir (hors scope des étapes ci-dessus)** : `SMARTDEBUFF_HomeToggle()` côté Lua ; la bascule « afficher Infos masque Home » ; éventuel ré-ancrage de la chaîne dev ; réintégration de la garde SpellGuard si besoin.




