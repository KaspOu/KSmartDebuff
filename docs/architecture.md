# KSmartDebuff (KDecurse) — Architecture

Référence technique de **KSmartDebuff** (« KDecurse (SmartDebuff) », nom interne du TOC :
`SmartDebuff`) : addon WoW qui affiche des boutons par unité de groupe avec suivi des debuffs,
actions de dispel sur clics (L/R/M + modificateurs), alertes sonores d'auras, et un large panneau
d'options. Fork de SmartDebuff (Aeldra) par Kallye.

Document écrit le 2026-11-02 après lecture intégrale du code réel. Les numéros de ligne sont
volatils : toujours revérifier dans le code courant. L'ancien `doc/ARCHITECTURE.md` ne conserve
que le journal de la refonte UI (§11) — voir `AGENTS.md` pour les règles d'édition.

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
        │  Core/SmartDebuff.xml  (UI — 4 758 lignes)             │
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

Le XML (17 frames principales, chargé en dernier) appelle **79 fonctions** du moteur — un appel à
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
  Grid, Misc, Colors, Home + `SmartDebuffAOFKeys_OnShow`.
- Helpers : `SmartDebuffOFSlider_OnLoad(self, low, high, step)`, `SetGameTooltip` (59 appels),
  `DisableCheckButton`, `AddTextToTable`, `AddMsgD`/`AddMsgErr`, `SetDefault*` (6 boutons reset),
  `SetAuraSoundsTestMode`, `SetAuraSoundsDetectTest`.
- Définie **dans** le XML : `SmartDebuffOF_MenuList_Refresh()` (OnLoad de `SmartDebuffOF_MenuList`),
  appelée par les 8 items du menu et par un `OnUpdate` throttlé à 0,2 s.

Frames : `SmartDebuffFrame` (driver caché : OnLoad/OnUpdate), `SmartDebuffSF` (barre principale
déplaçable : Titre, btnClose/btnStyle/btnOptions), `SmartDebuffIF` (info), `SmartDebuffOF` (options
: `Home` = 48 contrôles, `Infos`, `MenuList` = menu 8 entrées, boutons dev), `SmartDebuffClassOrder`,
`SmartDebuffSounds`, `SmartDebuffNRDebuffs`, `SmartDebuffSpellGuard`, `SmartDebuffAOFKeys`,
`SmartDebuffGridSetup` (11 cases + 8 sliders), `SmartDebuffMisc`, `SmartDebuffColors` (5 sélecteurs
+ sliders d'opacité), `SmartDebuffAuraSounds`, `SmartDebuffWNF` (What's New), plus le template
`SmartDebuffOptionsSliderTemplate`, 6 fonts virtuelles et le tooltip partagé `SmartDebuffTooltip`
(déclaré en double — piège connu). Le détail ligne à ligne des contrôles et ancres est dans
`doc/ARCHITECTURE.md` §4–§5 (journal de la refonte UI).

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
