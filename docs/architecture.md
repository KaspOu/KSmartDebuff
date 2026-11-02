# KSmartDebuff (KDecurse) — Architecture

Référence technique de **KSmartDebuff** (« KDecurse (SmartDebuff) », nom interne du TOC :
`SmartDebuff`) : addon WoW qui affiche des boutons par unité de groupe avec suivi des debuffs,
actions de dispel sur clics (L/R/M + modificateurs), alertes sonores d'auras, et un large panneau
d'options. Fork de SmartDebuff (Aeldra) par Kallye.

Document écrit le 2026-11-02 après lecture intégrale du code réel, après **fusion de l'ancien
`doc/ARCHITECTURE.md`** (supprimé le 2026-11-02 — son contenu encore unique est repris dans §5.1–
§5.3, §10, §12 et §13). Les numéros de ligne sont volatils : toujours revérifier dans le code
courant. Voir `AGENTS.md` pour les règles d'édition.

## 1. Vue d'ensemble

Deux piliers, plus trois bibliothèques de support :

```
        ┌────────────────────────────────────────────────────────┐
        │  Core/SmartDebuff.lua  (MOTEUR — 6 539 lignes)         │
        │  init/options, événements, scan d'unités, dispel,      │
        │  boutons sécurisés, drag&drop, test mode, slash cmds   │
        └───────────────▲───────────────────────┬────────────────┘
                        │ handlers OnLoad/      │ lecture/écriture
                        │ OnClick/OnShow        │ SMARTDEBUFF_Options…
        ┌───────────────┴───────────────────────▼────────────────┐
        │  Core/SmartDebuff.xml  (UI — 4 781 lignes)             │
        │  17 frames, templates, handlers inline qui délèguent   │
        │  aux fonctions SMARTDEBUFF_* (chargé EN DERNIER)       │
        └────────────────────────────────────────────────────────┘
   supports : globals.lua (constantes) · spells_<flavor>.lua (données par client)
              localization.* (textes + valeurs logiques) · polyfill.lua (ns.*)
              sounds.lua (alertes d'auras) · UTF8/ (troncature utf8)
```

- Le XML ne contient **pas** de logique métier : agencement + handlers qui appellent des fonctions
  globales définies par le Lua chargé avant. Exception unique : `SmartDebuffOF_MenuList_Refresh()`
  est définie dans un `OnLoad` du XML.
- Le Lua référence les frames par leur **nom global** (`SmartDebuffOF_cbClassColors`,
  `_G["SmartDebuffBtn"..i]`…) → couplage bidirectionnel fort (grep obligatoire avant renommage).

## 2. Ordre de chargement et rôle de chaque fichier

Source de vérité : `SmartDebuff.toc` (multi-flavor). Chaque fichier suppose les précédents.

| # | Fichier | Rôle | Ce qu'il définit / remplace |
|---|---|---|---|
| 1 | `UTF8/utf8data.lua` | Tables de cas Unicode (données) | — |
| 2 | `UTF8/utf8.lua` | Implémentation utf8 pour Lua 5.1 | `string:utf8sub` (utilisé 5× dans le moteur pour tronquer les noms) |
| 3 | `Core/SmartDebuff.globals.lua` | Constantes globales | `SMARTDEBUFF_VERSION(_NR)`, `SMARTDEBUFF_BREAKINGVERSION`, titres, backdrops, types de debuffs (`SMARTDEBUFF_MAGIC/CURSE/DISEASE/POISON/BLEEDING/CHARMED`, `HEAL/UTIL/MISDIRECT`), `KD_Settings` (+ défauts), flags (`SMARTDEBUFF_IS_RETAIL`, `SMARTDEBUFF_MACROTEXT=false`, `SMARTDEBUFF_HASSECRETS=true`, `SMARTDEBUFF_AURACONTAINERS`, `SMARTDEBUFF_KEYFORCLICK`), listes `SMARTDEBUFF_DEBUFFSKIP_ID` / `…SKIPLIST_ID` / `…CLASSSKIPLIST_ID` (**indexées**), `SMARTDEBUFF_NOTREMOVABLE_ID`, catalogues `SMARTDEBUFF_SOUNDS` / `SMARTDEBUFF_TEXTURES`, tables vides `…CLASS_DISPELS_LIST_ID` / `…CLASS_SKILLS_LIST_ID` / `…OVERRIDE_PICKUP_LIST_ID` (remplacées ensuite) |
| 4 | `Core/SmartDebuff_spells.lua` (standard) et `SmartDebuff_spells_{Vanilla,TBC,Wrath,Cata,Mists,Forever}.lua` | Données de sorts **par client** (`[AllowLoadGameType …]` ; `forever` exclut `standard, classic`) | **Redéfinissent** `SMARTDEBUFF_CLASS_DISPELS_LIST_ID` (dispels par classe : `Spell_ID`, `Spell_List`, `Improved_Talent`, `Improved_Spell_List`, `OnlyIfUsable`, `Spell_Type`), `SMARTDEBUFF_CLASS_SKILLS_LIST_ID` (`Spell_ID`, `Button`, `Types` — surcharge par ordre), `SMARTDEBUFF_OVERRIDE_PICKUP_LIST_ID`, `SMARTDEBUFF_DEBUFFS_LIST` (base par instance : `[instanceID] = { [spellID] = dispelType, __name, __name_<locale>, __ext, __type }`, `[0]` = défaut), `SMARTDEBUFF_SPELLS_VERSION`, `SMARTDEBUFF_MACROTEXT` (`true` côté standard) ; Mists ajoute `SMARTDEBUFF_NO_TALENT` et réduit `…DISABLED_SOUNDS/TEXTURES` |
| 5 | `Core/localization.<lang>.lua` (9 : en, fr, de, es, it, ko, pt, ru, tw) | Textes **et valeurs logiques** | Constantes globales plates : `SMARTDEBUFF_OFT_*`/`TT_*`/`MENU_*`/`MSG_*`, `SMARTDEBUFF_WHATSNEW`, mais aussi `SMARTDEBUFF_HUMANOID = BATTLE_PET_NAME_1`, `SMARTDEBUFF_IMP`, `SMARTDEBUFF_FONT`, `SMARTDEBUFF_KEY_L/R/M`, `SMARTDEBUFF_KEYS`. `en` charge toujours (fallback) ; le fichier de la langue active (`[AllowLoadTextLocale …]`) écrase ses clés |
| 6 | `Core/SmartDebuff.polyfill.lua` | Compat API inter-versions | Dans la table privée `ns` : `IsSecretValue`, `PickupSpell`, `GetSpellLink`, `GetSpellInfo/Name/Texture`, `GetSpellCooldown` (forme tableau), `IsSpellInRange`, `UnitInRange` (repli secret-safe), `PickupSpellBookItem`, `GetTalentInfo`, `UnitAura`/`UnitBuff` (dépréciés), `IsSpellInSpellBook`, `FindBaseSpellByID`, `Enum_SpellBookSpellBank_*`. Schéma : `legacy or moderne` |
| 7 | `Core/SmartDebuff.sounds.lua` | Alertes sonores d'auras | S'**auto-désactive** (return ligne 1) si `C_UnitAuras.AddAuraSound` absent. API : `SMARTDEBUFF_SetAuraSounds`, `…SetAuraSoundsOnKeySet`, `…SetAuraSoundsTestMode`, handlers du panneau `SmartDebuffAuraSounds`. Voir §8 |
| 8 | `Core/SmartDebuff.lua` | **Moteur** | Toutes les fonctions `SMARTDEBUFF_*`/`SDB_*` (détail §4–§6) |
| 9 | `Core/SmartDebuff.xml` | **UI** | 17 frames + templates ; handlers → fonctions du moteur (détail §7) |

Transverse : `Bindings.xml` (binding `SMARTDEBUFF` → `SMARTDEBUFF_ToggleOF()`), `.pkgmeta`
(packaging), `ChangeLog.txt` (manuel, en accord avec le TOC : 12.1.503), `.vscode/settings.json`
(Lua 5.1 + ~229 globals pour lua-language-server), `.prompts/` (prompts de travail, dont la
génération de `SMARTDEBUFF_DEBUFFS_LIST` Forever).

## 3. Cycle de vie

1. **`LoadSavedVariablesFirst: 1`** → `SMARTDEBUFF_Options`, `SMARTDEBUFF_OptionsGlobal`,
   `KD_Settings` lisibles dès le chargement des fichiers (les locales lisent
   `KD_Settings.ForceEnglish` à leur ligne 1 pour s'auto-annuler).
2. **Chargement des fichiers** : la locale `en` crée toutes les constantes, la locale active
   écrase ; `sounds.lua` peut s'arrêter net ; `SmartDebuff.lua` définit le moteur ; le XML crée les
   frames et exécute leurs `OnLoad` immédiatement.
3. **`SMARTDEBUFF_OnLoad`** (XML `SmartDebuffFrame`) : enregistre les événements (§6), ajoute
   `SmartDebuffOF` à `UISpecialFrames` (Échap ferme), déclare les slash commands, branche
   `OnEvent`.
4. **Triple gate d'init** (`SMARTDEBUFF_OnEvent`) : `isLoaded` (ADDON_LOADED) ∧ `isPlayer`
   (PLAYER_ENTERING_WORLD/UNIT_NAME_UPDATE) ∧ `isTTreeLoaded` (arbre de talents prêt, sondé par
   `SMARTDEBUFF_OnUpdate` selon 3 stratégies : `SMARTDEBUFF_NO_TALENT`, `C_ClassTalents`, ou
   `ns.GetTalentInfo`) → **`SMARTDEBUFF_Options_Init`**.
5. **`SMARTDEBUFF_Options_Init`** (gardé `InCombatLockdown`) : classe du joueur, filtre
   `CFG.filterString` par classe (WARLOCK `HARMFUL|DISPELLABLE`, HUNTER `HARMFUL`), `CleanMem()`
   (libère les tables de sorts des autres classes), cache des talents, `SMARTDEBUFF_SetSpells`,
   puis **~60 initialisations `O.… == nil`** (défauts), migrations (`ReplaceDeprecatedOptions`,
   `NotRemovableDebuffs` format `id: nom`, `CurrentSpells`), listes de skip localisées,
   `SMARTDEBUFF_CreateButtons`, popup de reset des touches si version majeure/breaking, What's New
   par compte (`OG.FirstStart`), `SMARTDEBUFF_CheckCVars`, `SMARTDEBUFF_RegisterCompartment`.
6. **Boucle runtime** : `SMARTDEBUFF_OnUpdate` appelle `SMARTDEBUFF_Ticker` (défère les travaux
   lourds, gardés hors combat : `SetUnits`, `SetSpells`, `SetTalents`, macros, boutons) et
   `SMARTDEBUFF_CheckDebuffs` (throttle `O.CheckInterval`, défaut 0,1 s).
7. **Désactivation/Combat** : `PLAYER_REGEN_*` → auto-hide, `SetMoving(false)`, refresh forcé.

## 4. Le moteur (`Core/SmartDebuff.lua`) — principales fonctions

### 4.1 État et configuration

- Locales d'état : `isLoaded/isPlayer/isInit/isTTreeLoaded`, 9 drapeaux `shouldCall*` (travaux
  différés), `tTicker/tDebuff/tSound`, caches (`SDB_cachePlayerClass`, `SDB_cachePlayerTalentsList`,
  `SDB_cacheRangeCheckSpell`…), tables de travail `cUnits/cGroups/cClasses/cPets`, `cSpells`
  (dispelType → {sort, bouton, type}), `cSpellList`, `cSpellDefault`, `ST` (stats de la frame
  d'info), `CFG` (maxRaid 40, maxPets 40, maxColumns 14, maxSpellIcons 10, filtres d'auras).
- `O` = `SMARTDEBUFF_Options` (personnage), `OG` = `SMARTDEBUFF_OptionsGlobal` (compte).

### 4.2 Unités et mise en page

- `SMARTDEBUFF_SetUnits` → `SMARTDEBUFF_AddUnit` : reconstruit `cUnits/cGroups/cClasses/cPets`
  selon `iGroupSetup` (3=raid, 2=party, 1=solo ; mode test `tm` simule N unités avec classes
  cycliques et noms de placeholder).
- `SMARTDEBUFF_SetButtons` : reset puis pose les unités (ordre **par rôle**, **par classe** ou
  **par groupe** via `O.SortedByRole/SortedByClass`), gère véhicules (boutons pets), puis
  `SMARTDEBUFF_SetPetButtons` + `SMARTDEBUFF_SetStyle`.
- `SMARTDEBUFF_SetStyle` : moteur de grille (colonnes, verticale/horizontale, en-têtes de
  classe/groupe/rôle, ligne d'info) puis recale `SmartDebuffSF` et finit sur
  `SMARTDEBUFF_CheckDebuffs(true)`.

### 4.3 Sorts, talents, touches

- `SMARTDEBUFF_SetSpells` : construit `cSpellList`/`cSpellDefault` depuis les tables du flavor
  (priorité documentée dans `globals.lua` : dispel utilisable > talent amélioré > talent existant >
  forcé) et choisit le sort de **détection de portée** (`SDB_cacheRangeCheckSpell`, avec replis sur
  `SDB_IsBaseSpellInRange`/`ns.UnitInRange`).
- `SDB_GetTalentsList` : 3 lectures de talents selon le client (`C_Traits` retail,
  `GetTalentInfoBySpecialization` WoD, `GetTalentInfo` Vanilla) → `{[spellID]=connu}`.
  `SDB_IsSpellTalented`/`SDB_IsSpellTalentExists` interrogent ce cache.
- `SMARTDEBUFF_CheckForSpellUpgrade` + `SMARTDEBUFF_UpgradeSpell` : quand un sort par défaut change
  de nom/ID (talent amélioré), les touches utilisateur sont migrées automatiquement (comparaison
  avec `O.CurrentSpells`).
- `SMARTDEBUFF_LinkSpellsToKeys` : mappe `O.Keys[mode][touche]` → `cSpells[dispelType]` puis
  réinitialise les conteneurs d'auras et les courbes. `GetActionKeyInfo`/`SetActionInfo` lisent/
  écrivent `O.Keys` (format `{type, name, rank, id, link}` ; touches `L R M SL SR SM AL AR AM CL
  CR CM` = bouton × modificateur, 2 modes : normal / target).

### 4.4 Boutons et affichage des debuffs

- `SMARTDEBUFF_CreateButtons` : 40 boutons `SecureActionButtonTemplate` (`SmartDebuffBtn<i>`), 40
  boutons pets (`SmartDebuffPetBtn<i>`, créés à la demande), colonnes d'en-tête, radio d'ancrage,
  24 boutons de touches (`SmartDebuff_btnAction<i>`). `CreateButton` monte texture/fond, overlay de
  dispel, bordure, texte, barres HP/mana, icônes raid/rôle/spell.
- `SMARTDEBUFF_SetButton(unit, idx, pet)` : pose les **attributs sécurisés**
  (`type1/2/3`, `spell1/2`, `macro`, `togglemenu`, `target`) à partir de `O.Keys` — avec macro
  `"/stopcasting\n/cast [@unit] sort"` si `SMARTDEBUFF_MACROTEXT` et `O.StopCast`. Gardé en combat.
- **Trois implémentations du scan** (`SMARTDEBUFF_CheckUnitDebuffs`, dispatch à 5080) :
  1. `_AuraContainer` (retail 12, actif si `SMARTDEBUFF_AURACONTAINERS`) : conteneurs d'auras
     sécurisés (`CustomAuraContainerTemplate`) par bouton/dispelType, filtres
     `includeDispelTypes`/`excludeSpellIDs`, slot « non retirable » (`sdb_…_nr`), overlay
     d'esclavage (CHARMED). L'init est enveloppée d'`xpcall` avec compteur d'erreurs.
  2. `_Secrets` (dépréciée) : `C_UnitAuras.GetAuraDataByIndex` avec garde `ns.IsSecretValue` et
     couleur via `SMARTDEBUFF_SetButtonState_Curve_Secrets` (`C_CurveUtil`).
  3. `_Legacy` (dépréciée) : `ns.UnitAura` en boucle.
- `SMARTDEBUFF_SetButtonState(unit, idx, nr, isInRange, remains, isPet, spellCD, durationObject)` :
  état visuel complet (couleur de classe, préfixes AFK/OFF/DEAD/GHO/-FD-, reste du timer, overlay
  L/R/M par `nr` 1-3, `nr=10` non retirable, `-99` unité disparue), couleurs par bouton
  (`O.ColDebuffL/R/M/NR`), textes `SMARTDEBUFF_KEY_*`.
- `SmartDebuff_SetButtonBars` : barres HP/mana (avec chemins `UnitHealthPercent`/`UnitPowerPercent`
  secrets-safe et replis), aggro (`UnitThreatSituation`), icônes raid/ready-check/rôle, et
  **SpellGuard** (3 chemins : slots AuraContainer, boucle `C_UnitAuras` secrets, boucle
  `GetAuraDataBySpellName` classic).

### 4.5 Options, drag&drop, macros

- Handlers `SMARTDEBUFF_Toggle*`, `…OnShow/OnHide/OnScroll` par panneau (§7) ; listes à défilement
  génériques (`CreateScrollButtons`/`OnScroll`, template `FauxScrollFrame`) pour NRDebuffs,
  SpellGuard, ClassOrder, Sounds.
- Drag&drop : `SMARTDEBUFF_PickAction`/`SMARTDEBUFF_DropAction` (cursor API : `ns.PickupSpell`,
  `C_Item.PickupItem`, `PickupMacro`, `ns.PickupSpellBookItem`) avec échange d'ancien slot, garde
  `SMARTDEBUFF_IsSpellMovable` (sort actif pour la spé), et remplacements via
  `SDB_GetPickupOverride` (`SMARTDEBUFF_OVERRIDE_PICKUP_LIST_ID`).
- Hooks `hooksecurefunc("EditMacro"/"DeleteMacro")` pour suivre les renommages/suppressions ;
  `SDB_GetMacroIndex` retrouve une macro par nom > index+icône > icône (voir constat d'audit sur
  `MAX_CHARACTER_MACROS`).
- Couleurs : `SMARTDEBUFF_ColorsBackdrop` avec les deux widgets ColorPicker (moderne
  `SetupColorPickerAndShow` / classic `OpacitySliderFrame`).

## 5. Contrat XML ↔ Lua

Le XML (17 frames principales, chargé en dernier) appelle **80 fonctions** du moteur — un appel à
une fonction manquante échoue silencieusement à l'exécution du handler. Familles :

- Cycle de vie : `SMARTDEBUFF_OnLoad`, `SMARTDEBUFF_OnUpdate`.
- Toggles : `ToggleSF`, `ToggleOF`, `ToggleIF`, `ToggleShowLR`, `ToggleForceLR`,
  `ToggleClassColors`, `ToggleSortedByClass`, `ToggleSFBackdrop`, `ToggleWhatsNew`,
  `ToggleAOFKeys`, `ToggleAnchors`, `ToggleNRDebuffs`, `ToggleIF`, `TestModeToggle`,
  `FilterStringToggle`, `OFToggleGrp`, `GridToggle`, `ColorsToggle`, `SoundsToggle`,
  `SpellGuardToggle`, `ClassOrderToggle`, `MiscToggle`, `HomeToggle`, `GlobalSave`, `GlobalLoad`,
  `RegisterCompartment`, `SetMoving`.
- Rafraîchissement : `SetButtons`, `SetPetButtons`, `SetStyle`, `CheckDebuffs`, `CheckSFButtons`,
  `CheckCVars`, `ColorsUpdate`, `ColorsBackdrop`, `CreateButtonsPetsIfEnabled`.
- Panneaux (`*OnShow/OnHide/OnScroll`) : ClassOrder, Sounds, NRDebuffs, SpellGuard, AuraSounds,
  Grid, Misc, Colors, Home, Infos + `SmartDebuffAOFKeys_OnShow`.
- Helpers : `SmartDebuffOFSlider_OnLoad(self, low, high, step)`, `SetGameTooltip` (59 appels),
  `DisableCheckButton`, `AddTextToTable`, `AddMsgD`/`AddMsgErr`, `SetDefault*` (6 boutons reset),
  `SetAuraSoundsTestMode`, `SetAuraSoundsDetectTest`, `UpdateDispelRecap` (`OnShow` d'Infos).
- Définie **dans** le XML : `SmartDebuffOF_MenuList_Refresh()` (OnLoad de `SmartDebuffOF_MenuList`),
  appelée par les 8 items du menu et par un `OnUpdate` throttlé à 0,2 s.

Frames : `SmartDebuffFrame` (driver caché : OnLoad/OnUpdate), `SmartDebuffSF` (barre principale
déplaçable : Titre, btnClose/btnStyle/btnOptions), `SmartDebuffIF` (info), `SmartDebuffOF` (options
: `Home` = 49 contrôles, `Infos`, `MenuList` = menu 8 entrées, boutons dev), `SmartDebuffClassOrder`,
`SmartDebuffSounds`, `SmartDebuffNRDebuffs`, `SmartDebuffSpellGuard`, `SmartDebuffAOFKeys`,
`SmartDebuffGridSetup` (11 cases + 8 sliders), `SmartDebuffMisc`, `SmartDebuffColors` (5 sélecteurs
+ sliders d'opacité), `SmartDebuffAuraSounds`, `SmartDebuffWNF` (What's New), plus le template
`SmartDebuffOptionsSliderTemplate`, 6 fonts virtuels et le tooltip partagé `SmartDebuffTooltip`
(déclaré en double — piège connu).

### 5.1 Carte structurelle du XML (lignes relevées le 2026-11-02 — volatiles)

Racine `<Ui>` (namespace Blizzard WoW UI), 4 781 lignes ; enfants de premier niveau dans l'ordre
du fichier :

| Lignes | Élément | Rôle |
|---|---|---|
| 3–24 | `Slider` virtuel `SmartDebuffOptionsSliderTemplate` | Template réutilisé par les ~15 sliders |
| 25–34 | `Frame` **SmartDebuffFrame** | Boucle principale : `OnLoad` → `SMARTDEBUFF_OnLoad`, `OnUpdate` → `SMARTDEBUFF_OnUpdate` |
| 36–42 | `GameTooltip` **SmartDebuffTooltip** (1/2) | Tooltip interne, `SetOwner(SmartDebuffFrame, "ANCHOR_NONE")` |
| 44–75 | 6 × `Font` virtuels | `…NormalMini` (9px), `…HighlightMini`, `…NormalMicro` (8px), `…HighlightMicro`, `SmartDebuff_Font`, `SmartDebuff_FontHP` |
| 77–82 | `GameTooltip` **SmartDebuffTooltip** (2/2) | **Doublon exact** (constat §10) |
| 84–247 | `Frame` **SmartDebuffSF** | Panneau compact flottant : `_btnClose`, `_btnStyle` ("K" : clics Alt/Shift/Droit), `_btnOptions` ("O"), `_Title` |
| 248–334 | `Frame` **SmartDebuffIF** | Frame d'info (`_lblInfo`, `_lblOut`) — déplacée Shift+glisser |
| 335–2785 | `Frame` **SmartDebuffOF** | Panneau d'options — 13 enfants dont **Home / Infos / MenuList** (détail §5.2) |
| 2786–2875 | `Frame` **SmartDebuffClassOrder** | Ordre des classes (`FauxScrollFrameTemplate` + Reset) |
| 2876–2986 | `Frame` **SmartDebuffSounds** | Liste des sons (`_txtIn`, scroll, Reset) |
| 2987–3130 | `Frame` **SmartDebuffNRDebuffs** | Debuffs non retirables — saisie `SpellID` (`C_Spell.GetSpellInfo`) |
| 3131–3247 | `Frame` **SmartDebuffSpellGuard** | Sorts de HoT / Spell Guard (liste de suivi) |
| 3248–3341 | `Frame` **SmartDebuffAOFKeys** | Raccourcis/clés — contenu **généré en Lua** (`SmartDebuffAOFKeys_OnShow`) |
| 3342–3990 | `Frame` **SmartDebuffGridSetup** | Cases + sliders de mise en page grille |
| 3991–4072 | `Frame` **SmartDebuffMisc** | AuraSpellIDs, ChatNotif, **AddonCompartment**, **Force English** (`KD_Settings`) |
| 4073–4618 | `Frame` **SmartDebuffColors** | Couleurs/opaçités : 6 boutons test + 5 `ColorSelect`, sliders `sldADebuff`/`sldNormal`/`sldNormalOOR` |
| 4619–4704 | `Frame` **SmartDebuffAuraSounds** | Sons d'auras (ancré sur `SmartDebuffSounds`) |
| 4705–fin | `Frame` **SmartDebuffWNF** | « What's New » (`_lblText`, repositionnement dynamique) |

Tous les panneaux sauf `SmartDebuffSF/IF/WNF` sont `parent="SmartDebuffOF"`, `hidden="true"`,
ancrés `TOPLEFT → SmartDebuffOF TOPRIGHT (+2, 0)` et calent leur hauteur sur
`SmartDebuffOF:GetHeight()` en OnLoad/OnShow.

### 5.2 Détail de `SmartDebuffOF` (refonte du 2026-11-01)

**13 enfants directs** : `_Title` (titre éditable, `EditBox` multi-lignes 300×20), `_btnClose`
(`UIPanelCloseButton`), **`_Home`** (conteneur des options, 304×540, `enableMouse="false"`, ancré
`TOPLEFT (0,0)` de l'OF → origine identique, coordonnées internes inchangées), **`_Infos`**
(152×540, `hidden`, 1 enfant : `_DispelRecap` (récapitulatif dispels, voir ci-dessous) — la
bascule « afficher Infos masque Home » n'est pas implémentée), **`_MenuList`** (menu principal, 148×136, `BOTTOMLEFT (8, 6)` de l'OF,
`enableMouse="false"`), `_btnReload`, `_btnTestMode`, `_btnFakeMode`, `_btnGlobalSave`,
`_btnGlobalLoad`, puis la chaîne dev `_cbShowNotRemov` / `_btnNotRemov` / `_cbShowInfoFrame` (zone
`IS_DEV`). Supprimés lors de la refonte (remplacés par le menu) : `_btnGridSetup`,
`_btnColorSetup`, `_btnMisc`, et dans Home : `_btnClassOrder`, `_btnSpellGuard`, `_btnSounds`.

- **`_Home`** (début ligne 381) : 49 enfants directs — les 50 anciens contrôles `cbGrp1` →
  `sldCheckInterval` + `SmartDebuffColTextureDropDown`, moins les 3 boutons supprimés.
  `SmartDebuffOF_btnKeys` **conservé en doublon volontaire** avec l'item « Keys » du menu.
  Renommages de la refonte : `name="$parent_X"` → **`name="SmartDebuffOF_X"`** (×50, noms globaux
  résolus identiques, Lua non impacté), `relativeTo` en absolu, 2 `GetParent():GetName()` réécrits
  en `_G["SmartDebuffOF_cbRoleView"]` / `_G["SmartDebuffOF_cbClassView"]`. Seule racine «
  orpheline » : `cbGrp1` (`TOPLEFT 4/−20`, ré-ancré sur Home — coïncide avec l'OF).
- **`_MenuList`** (début ligne 2 226) : contour `BackdropTemplateMixin` +
  `SMARTDEBUFF_BACKDROP_OPTIONS` + `SetBackdropBorderColor(1, 0.82, 0, 1)` (or) ; **8 items**
  `Button` **sans template**, 140×16, empilés `TOPLEFT → BOTTOMLEFT` depuis `(4, −4)` (padding
  4 px, pas de scroll) ; texte `GameFontHighlight`, highlight blanc α0.12 au survol, **état actif =
  texte + fond or α0.10**, clic sur toute la ligne (`RegisterForClicks(SMARTDEBUFF_KEYFORCLICK)`).
  État actif : `SmartDebuffOF_MenuList_Refresh()` (définie dans le XML, §5) compare
  `self.panelName` → `_G[…]:IsShown()` via un `OnUpdate` throttlé à 0,2 s, + appel immédiat en
  `OnClick` — aucun panneau existant n'est modifié.

| Item (`SmartDebuffOF_MenuList_…`) | Libellé (constante) | `OnClick` | `panelName` suivi |
|---|---|---|---|
| `_Home` | `SMARTDEBUFF_MENU_HOME` (« Accueil »…) | `SMARTDEBUFF_HomeToggle()` | `SmartDebuffOF_Home` |
| `_Keys` | `SMARTDEBUFF_OFT_SKILLS` | `SMARTDEBUFF_ToggleAOFKeys()` | `SmartDebuffAOFKeys` |
| `_Grid` | `SMARTDEBUFF_MENU_GRID` | `SMARTDEBUFF_GridToggle()` | `SmartDebuffGridSetup` |
| `_Colors` | `SMARTDEBUFF_MENU_COLORS` | `SMARTDEBUFF_ColorsToggle()` | `SmartDebuffColors` |
| `_Sounds` | `SMARTDEBUFF_OFT_SOUND` | `SMARTDEBUFF_SoundsToggle()` | `SmartDebuffSounds` |
| `_SpellGuard` | `SMARTDEBUFF_MENU_HOTS` | `SMARTDEBUFF_SpellGuardToggle()` | `SmartDebuffSpellGuard` |
| `_ClassOrder` | `SMARTDEBUFF_MENU_CLASSORDER` | `SMARTDEBUFF_ClassOrderToggle()` | `SmartDebuffClassOrder` |
| `_Misc` | `MISCELLANEOUS` | `SMARTDEBUFF_MiscToggle()` | `SmartDebuffMisc` |

Les 5 libellés `SMARTDEBUFF_MENU_*` sont traduits dans les 9 fichiers `localization.*.lua` (bloc
`-- Main menu (SmartDebuffOF_MenuList)`) ; tooltips des items = constantes `OFT_*/TT_*`
d'origine.

- **Récapitulatif dispels** (ajouté le 2026-11-02) : une FontString
  `SmartDebuffOF_Home_DispelRecap` (300×84) dans `_Home` et `SmartDebuffOF_Infos_DispelRecap`
  (148×140) dans `_Infos`, centrées (position provisoire, à repositionner), texte identique dans
  les deux panneaux : par clic L/M/R assigné, un carré `■` en `|cff` de la couleur
  `O.ColDebuffL/M/R`, les types dispels du sort, puis `Spell binded: [nom]` ; sinon
  `No dispel available` en rouge. Constantes `SMARTDEBUFF_OFT_DISPEL*` (locale `en`, repli pour
  toutes les langues). Mise à jour par `SMARTDEBUFF_UpdateDispelRecap()` : `OnUpdate` throttlé à
  0,2 s (`tRecap`, seulement si l'un des deux panneaux est visible) + appel direct à l'ouverture
  (`HomeOnShow`, `OnShow` d'Infos) ; le texte n'est réécrit que s'il change (`sRecapText`).
- **Boutons bas** (ancrés **au-dessus du menu**) : `btnGlobalSave` `BOTTOMRIGHT → TOPRIGHT de
  MenuList (0, 4)`, `btnTestMode` `(0, 28)`, `btnReload` `(0, 52)` (écart 24 px entre rangées) ;
  `btnGlobalLoad` à gauche de `btnGlobalSave` ; `btnFakeMode` à gauche de `btnTestMode`
  (`BOTTOMRIGHT → BOTTOMLEFT`, −4/0). **La chaîne dev suit `btnTestMode`** → recouvrements
  partiels en mode `IS_DEV` (constat §10).
- **Ancrages à connaître** : dans Home, chaînes inchangées `_cbGrp1→…→_cbGrp8`,
  `_cbClassIcon1→…→16`, `_cbHP→_cbMana→_cbHPText` (+ `_cbInvert`), colonne gauche
  `_cbClassView→_cbShowLR→_cbShowAggro→_cbShowHealRange→_cbTargetMode→_cbShowDebuffTooltip→
  _cbAutoHide→_cbAdvAnchors` (doublons `x=+152` / `+87/+106/+108/+115/+130`) ; GridSetup : chaîne
  verticale `_cbVertical → … → _cbShowRoleDpsIcon` puis sliders `sldFontsize → … → sldSpaceY` ;
  boutons bas relativement au menu (suivent s'il bouge). **Insérer un contrôle au milieu d'une
  chaîne décale tout ce qui suit** (régression silencieuse).

### 5.3 Drapeaux conditionnels appliqués par le XML

| Drapeau | Origine | Effet dans le XML |
|---|---|---|
| `SMARTDEBUFF_AURACONTAINERS` | `globals.lua` (`AuraContainerSortDirection`) | Désactive `_cbShowDebuffTooltip` et `_cbShowAuraSpellIDs` |
| `SMARTDEBUFF_MACROTEXT` | `globals.lua` | Désactive `_cbStopCast` |
| `SMARTDEBUFF_HASSECRETS` | `globals.lua` | Plus aucun effet XML direct : l'ancien masquage de `_btnSpellGuard` n'a pas été réintégré dans l'item menu (constat §10) |
| `SMARTDEBUFF_IS_DEV` | `globals.lua` (`--@do-not-package@`) | Seul moyen d'afficher `_cbShowNotRemov`, `_btnNotRemov`, `_cbShowInfoFrame` ; `_btnReload`, `_btnFakeMode` affichés en dev |
| `SMARTDEBUFF_CLASSES["<CLASS>"]` | Lua | Auto-masquage icônes DK/Monk/DH/Evoker + pets DK |
| `SMARTDEBUFF_OFT_FORCELR == ""` | localisation | Masque `_cbForceLR` en anglais |

## 6. Événements WoW utilisés

| Porteur | Événements | Effet |
|---|---|---|
| `SmartDebuffFrame` (OnEvent) | `ADDON_LOADED`, `CVAR_UPDATE`, `PLAYER_ENTERING_WORLD`, `ZONE_CHANGED_NEW_AREA`, `UNIT_NAME_UPDATE` | gates d'init ; `CVAR_UPDATE("ActionButtonUseKeyDown")` → message « reload requis » |
| idem | `PLAYER_ROLES_ASSIGNED`, `GROUP_ROSTER_UPDATE`, `UNIT_FACTION`, `UNIT_ENTERED_VEHICLE`, `UNIT_EXITED_VEHICLE`, `UNIT_PET` | `shouldCallSetUnits/SetButtons` (+ `SetAuraSounds` pour le roster) |
| idem | `PLAYER_REGEN_ENABLED/DISABLED` | auto-hide, gel du déplacement, refresh |
| idem | `SPELLS_CHANGED`, `UPDATE_MACROS`, `BAG_UPDATE`, `TRAIT_CONFIG_UPDATED`, `PLAYER_TALENT_UPDATE`, `CHARACTER_POINTS_CHANGED` | travaux différés (`SetSpells`, `SetTalents`, macros, UI) |

Aucun event AceEvent : le moteur utilise un frame nu + un routeur maison (les modules Ace3 ne sont
pas utilisés par ce projet).

## 7. Sons d'auras (`Core/SmartDebuff.sounds.lua`)

Fonctionne uniquement avec `C_UnitAuras.AddAuraSound` (sinon le fichier ne charge pas) :

- `BuildAuraSoundUnits` — unités suivies (player/pet/raid1-40/party1-4, pets selon options) ;
  `ShouldShowUnit` applique `DebuffClasses`/`DebuffGrp`/options pets.
- `RefreshAuraSounds` — pour chaque unité, enregistre un `AddAuraSound` par spellID de
  `SMARTDEBUFF_DEBUFFS_LIST[instanceID]` (ou `[0]`) dont le dispelType est actif pour le joueur
  (déclenchement `Added`, `soundFileID = O.Sound`, throttle 2 s).
- `SMARTDEBUFF_SetAuraSounds` (roster/zone, dédoublonné par `lastIsRaid/lastInstanceID`),
  `…OnKeySet` (uniquement si les dispels actifs ont changé), `…TestMode` (force ; spell 8936 en
  test).
- Panneau `SmartDebuffAuraSounds` : liste scrollée de la base par instance (métadonnées `__name`,
  `__name_<locale>`, `__ext`, `__type`), noms d'instances via l'Encounter Journal
  (`GetInstanceByID`, cache mapID), couleurs via `AuraUtil.GetAuraBorderColor`.

## 8. Gestion des données

- **`SMARTDEBUFF_Options`** (personnage) : ~60 champs initialisés dans `Options_Init`
  (position `SFPos*`, tri `SortedByRole/SortedByClass/OrderClass/OrderGrp`, `DebuffGrp[8]`,
  `DebuffClasses`, affichages HP/mana/tooltip/aggro/raid icons/SpellGuard, couleurs
  `ColNormal/ColDebuffL/R/M/NR/ColBack`, alphas `ANormal/ANormalOOR/ADebuff`, grille
  `Columns/BarH/BtnW/BtnH/BtnSpX/BtnSpY/Fontsize`, `Keys[2][12]`, `NotRemovableDebuffs`,
  `SpellGuard`, `Sound`, `CheckInterval`, `VersionNr`, `CurrentSpells`).
- **`SMARTDEBUFF_OptionsGlobal`** (compte) : `FirstStart` (What's New par version) + copie
  paramétrée via `GlobalLoadSave` pour les boutons Global Save/Load (voir constat d'audit).
- **`KD_Settings`** (compte, **partagé avec KCursorCooldown**) : `ForceEnglish`, `AddonCompartment`.
- **Migrations** : `ReplaceDeprecatedOptions` (`IgnoreDebuff_Old`, `ShowIF_Old`, `ShowNotRemov_Old`),
  format `id: nom` des `NotRemovableDebuffs`, reset des touches si `O.VersionNr <
  SMARTDEBUFF_BREAKINGVERSION` ou nouvelle extension, `CleanMem()` (tables de sorts des autres
  classes remises à nil en mémoire).
- **Listes de skip indexées** : `…SKIPLIST_ID`/`…CLASSSKIPLIST_ID` contiennent des **index** dans
  `SMARTDEBUFF_DEBUFFSKIP_ID` (résolus en noms localisés à l'init). Tout réordonnements de
  `DEBUFFSKIP_ID` décale silencieusement les listes — contrat fragile assumé.

## 9. Dépendances

**Internes** : table privée `ns` (polyfill + `ns.O`/`ns.cSpells`, sans consommateur actuel),
`cSpells`/`cSpellDefault` partagés moteur↔sounds, callbacks `SMARTDEBUFF_GetAuraContainer*` et
`SMARTDEBUFF_GetDispelCooldownByType` utilisés par sounds.lua (appels runtime, ordre de chargement
sans effet).

**Bibliothèques embarquées** : aucune (contrairement aux autres addons K) — seules `UTF8/utf8.lua`
(+ `utf8data.lua`) sont tierces. Pas de LibStub/Ace3.

**API Blizzard** (surface réelle) : `C_Spell`, `C_SpellBook`, `C_Item`, `C_UnitAuras`,
`C_ClassTalents`, `C_Traits`, `C_CurveUtil`, `C_Timer`, `C_AddOns`, `AuraUtil`,
`UnitCastingInfo`/`UnitChannelInfo` non utilisés (c'est un addon de debuffs, pas de cast),
`UnitHealth(Max)`/`UnitHealthPercent`/`UnitPower*`, `UnitThreatSituation`, `UnitGroupRolesAssigned`,
`GetRaidRosterInfo`, `UnitIsCharmed`, `UnitCreatureType`, `GetReadyCheckStatus`, `GetRaidTargetIndex`,
`SetRaidTargetIconTexture`, `SecureButton_GetModifiedAttribute/GetEffectiveButton`,
`FauxScrollFrame_*`, `UIDropDownMenu_*`, `ColorPickerFrame`, `StaticPopupDialogs`,
`hooksecurefunc`, `PlaySoundFile`, `EJ_*` (Encounter Journal), `AddOnCompartmentFrame`,
`GameTooltip`/`SetSpellByID`/`SetHyperlink`.

**Templates et widgets XML** : `SmartDebuffOptionsSliderTemplate` (→ `UISliderTemplate`),
`UIPanelCloseButton`, `UIPanelButtonTemplate`, `UIMenuButtonStretchTemplate`,
`InterfaceOptionsCheckButtonTemplate`, `UIDropDownMenuTemplate` (+ `UIDropDownMenu_Initialize/
CreateInfo/AddButton/SetSelectedValue/SetText/JustifyText`), `FauxScrollFrameTemplate` (+
`FauxScrollFrame_OnVerticalScroll`), `InputBoxTemplate`, `GameTooltipTemplate`, `SystemFont_Tiny`,
`GameFontNormalSmall/HighlightSmall/Highlight`, `BackdropTemplateMixin` (+ `Mixin`, `CreateColor`,
`SetGradient`).

## 10. Incohérences, redondances et risques

Constats complets (sévérités, traces) : **`docs/backlog.md`**, section audit 2026-11-02. Principaux
— ne pas les corriger « au passage » :

1. `SmartDebuff.lua:3440` — `local isAFK UnitIsAFK(unit)` sans `=` : deux instructions, `isAFK`
   reste nil → affichage AFK et compteur AFK **morts** (silencieux).
2. `SmartDebuff.lua:5365-5366` — `GlobalLoadSave` : `L.IgnoreDebuff or true` /
   `L.ChatNotif or true` force ces options à `true` via les boutons Global Save/Load.
3. `SmartDebuff.lua:1758-1764` — recherche de macro par page avec `MAX_CHARACTER_MACROS` comme
   frontière compte/personnage (la frontière API est `MAX_ACCOUNT_MACROS`).
4. `SmartDebuff.lua:3564+` — `string.format("%.2f", remains)` évalué hors garde debug : erreur si
   `remains` est nil (branche esclavage sans aura scannée).
5. `SmartDebuff.lua:5449` — `numToDisplay` global implicite dans `getMaxScrollBtn` ;
   `SmartDebuff.lua:6461` — exports `ns.O`/`ns.cSpells` morts (nil/périmés).
6. XML : `SmartDebuffTooltip` déclaré 2× (36/77) ; `SmartDebuffWNF` « movable » mais handlers de
   drag vides et sans `RegisterForDrag` ; `--SMARTDEBUFF_ToggleAOFOrder` commenté vers une fonction
   inexistante ; contrôles nommés `SmartDebuffOF_*` mais parentés ailleurs ; `txtIn` du panneau
   Sounds non éditable (contrairement à NRDebuffs/SpellGuard) ; handlers vides (SF/IF/OF/WNF) ;
   indentation hétérogène.
7. Résidus de la refonte UI du 2026-11-01 (journal §13) : la chaîne dev
   (`cbShowNotRemov`/`cbShowInfoFrame`) recouvre partiellement le coin de `btnGlobalSave` et le haut
   du menu (ligne « Accueil ») en mode `IS_DEV` ; `SMARTDEBUFF_OFT_GRIDSETUP` et
   `SMARTDEBUFF_OFT_COLORSETUP` sont devenues orphelines (boutons supprimés, constantes conservées
   sans effet) ; l'item « Sorts de HoT » du menu n'a **pas** hérité de la condition de masquage de
   l'ancien `btnSpellGuard`
   (`if (SMARTDEBUFF_HASSECRETS and not SMARTDEBUFF_AURACONTAINERS) then self:Hide() end`) — à
   réintégrer si ce comportement client-compat doit être conservé ; textes en dur dans le XML malgré
   la localisation (`"Reload (Debug)"`, `"Toggle filterString"`, `"Force English"`,
   `MISCELLANEOUS`/`OPTIONS`/`UNLOCK_FRAME` — globals Blizzard) ; `SmartDebuffColTextureDropDown` :
   seul enfant de Home à porter un nom global absolu.

Redondances structurelles : les 3 implémentations du scan de debuffs partagent ~80 % de leur
squelette ; les chemins SpellGuard existent en 3 copies (AuraContainer/secrets/classic) ;
`GetActionKeyInfo`/`SetActionInfo` et les 24 slots dupliquent la logique de mapping touche →
attribut. À considérer avant toute refactorisation lourde (règle §5 de l'AGENTS.md).

## 11. Zones non analysées (2026-11-02)

- **Exécuté dans WoW : rien** — tous les constats sont statiques ; la validation en jeu reste
  requise (procédure dans `AGENTS.md` §6).
- `UTF8/utf8data.lua` (1 860 lignes) : traité comme des données tierces (non auditées) ;
  `UTF8/utf8.lua` : seul le point d'extension `utf8sub` a été vérifié.
- Tables de `SmartDebuff_spells.lua` au-delà des premières entrées, et fichiers de sorts
  Vanilla/TBC/Wrath/Cata/Forever : formats et lignes de config vérifiés, contenu de données non
  relu ligne à ligne.
- Contenu des traductions (parité de clés et mécanisme vérifiés, texte non relu) ; `.release/`
  (exclu de l'analyse, conformément à la consigne) ; binaires (`Icons/`, `.icon*`, `.logo*`) ;
  `.vscode/settings.json` au-delà de l'inventaire.
- Un sous-agent d'exploration (sorts/sons/utf8/locales) n'a pas renvoyé son rapport : sa liste de
  candidats n'est pas intégrée ici ; le périmètre a été recouvert par lectures directes
  (`sounds.lua`, en-têtes et tables des fichiers de sorts, échantillons de locales).

## 12. Points de vigilance régression

1. **Couplage XML ↔ Lua** : renommer/déplacer un contrôle casse les usages `_G[…]` côté Lua et
   l'inverse — grep systématique avant/après.
2. **Chaînes d'ancrage** (§5.2) : celles de Home et de GridSetup ; les ancres relatives à
   `SmartDebuffOF_MenuList` font suivre les boutons bas si le menu bouge ; la chaîne dev fait
   suivre `btnTestMode`.
3. **Handlers `InCombatLockdown`** : ne jamais retirer (taint/combat).
4. **Ordre de chargement** (§2) : ajouter un fichier Lua ⇒ l'insérer au bon endroit du TOC ; le XML
   doit rester **dernier**.
5. **Gardes `if (SMARTDEBUFF_Options) then`** : préservées telles quelles (sauvegarde absente au
   premier chargement).
6. **Drapeaux §5.3** : un contrôle désactivé/masqué est fonctionnel sur d'autres clients — ne pas
   le supprimer « parce qu'il ne s'affiche pas ».
7. **`SmartDebuffOF_btnKeys`** : doublon volontaire (bouton conservé dans Home + item « Keys » du
   menu) — ne pas le supprimer sans demande.
8. **Noms absolus dans Home** : `SmartDebuffOF_cb*`/`sld*` sont codés en dur depuis la refonte — un
   retour à `$parent_` recasserait le Lua.
9. **Validation** : voir `AGENTS.md` §6 (parse XML + cohérence TOC + test en jeu `/kd`, `/kdo`).

## 13. Journal des évolutions UI (refonte du 2026-11-01)

Refonte de l'écran d'options, étape par étape (règles appliquées : `AGENTS.md` §5) — reprise du
journal de l'ancien `doc/ARCHITECTURE.md` :

| # | Étape | Commit | Détail |
|---|---|---|---|
| 1 | Suppression du masque | `6f10a91` | `SmartDebuffOF_AdvancedMask` + son bouton `btnOptions` supprimés (−111 lignes). Aucune référence Lua/ancrage existante. |
| 2 | Re positionnement boutons bas | `4478b7c` | `btnTestMode` → ex-emplacement de `btnMisc` (colonne droite) ; `btnFakeMode` → à gauche de `btnReload`. |
| 3 | Cadres **Home + Infos** | `e6717e8` | **51 contrôles** (`cbGrp1` → `SmartDebuffColTextureDropDown`) déplacés dans `SmartDebuffOF_Home` : renommages `name="$parent_X"` → **`SmartDebuffOF_X`** (noms globaux préservés), `relativeTo` absolus, 2 `GetParent()` → `_G[…]`. `SmartDebuffOF_Infos` créé (152×540, `hidden`). |
| 4 | **Menu de navigation** | `4f5ad75` | `SmartDebuffOF_MenuList` créé (7 items puis 8). **6 boutons supprimés** : `btnGridSetup`, `btnColorSetup`, `btnMisc`, `btnSounds`, `btnSpellGuard`, `btnClassOrder` (0 réf. Lua/ancres vérifiées). **`btnKeys` conservé en doublon**. Items = boutons sans template, `OnClick` recopiés à l'identique. |
| 5 | Design, **Accueil**, libellés | `4f5ad75`/`d950625` | Texte `GameFontHighlight` (items 140×16, conteneur **148×136**), **contour** `SMARTDEBUFF_BACKDROP_OPTIONS` + bordure or. Item **Accueil** → `SMARTDEBUFF_HomeToggle()`. 5 libellés → **`SMARTDEBUFF_MENU_*` traduits dans les 9 `localization.*.lua`** : *Accueil / Grille / Couleurs / Sorts de HoT / Ordre des classes* (Keys/Sounds/Misc inchangés). |
| 6 | Boutons **au-dessus du menu** | `34be62a` | `btnGlobalSave`/`btnTestMode`/`btnReload` ré-ancrés `TOPRIGHT de MenuList (0, 4/28/52)` (mêmes écarts), `btnFakeMode` → à gauche de `btnTestMode`, `btnGlobalLoad` inchangé. |

**Effets de bord connus / résidus** : `btnMisc` supprimé → le chevauchement temporaire de l'étape 2
est résolu ; chaîne dev en recouvrement partiel en mode `IS_DEV` (§10) ; `OFT_GRIDSETUP`/
`OFT_COLORSETUP` devenues orphelines (§10) ; écart SpellGuard : condition de masquage du vieux
bouton non réintégrée dans l'item (§10).

**À venir (hors scope des étapes ci-dessus)** : la bascule « afficher Infos masque Home » ;
éventuel ré-ancrage de la chaîne dev ; réintégration de la garde SpellGuard si besoin.
