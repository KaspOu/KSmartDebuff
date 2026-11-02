# AGENTS.md — KSmartDebuff (KDecurse)

> Guide pour les agents IA (Cline, Cursor, Copilot, hrdr…) et les contributeurs.
> Architecture détaillée : **`docs/architecture.md`** (référence complète, 2026-11-02 — fusionne
> l'ancien `doc/ARCHITECTURE.md`, supprimé à cette date ; son journal de refonte UI y est devenu
> §13).
> Dernière mise à jour de ce fichier : 2026-11-02.

## 1. Identité du projet

| | |
|---|---|
| Addon WoW (nom en jeu / dossier d'installation) | `SmartDebuff` (`package-as: SmartDebuff`) |
| Titre affiché | `KDecurse (SmartDebuff)` — fork de SmartDebuff (Aeldra) par Kallye (EU-Elune) |
| Dépôt | https://github.com/KaspOu/KSmartDebuff/ (CurseForge project ID 699994) |
| Langages | Lua 5.1 (API WoW) + XML d'interface Blizzard (`<Ui>` namespace) |
| Branches Git | `develop` historiquement ; branche de travail observée : `AGENTS` |
| Version courante | `12.1.503` (`## Version:` du TOC = entrée `v12.1.503` de `ChangeLog.txt`) |
| Clients supportés | `## Interface: 120100, 120105, 16001, 50504, 38002, 20506, 11509` (retail + classiques + Forever) |
| Licences | `License.txt` (All Rights Reserved, fork autorisé sur GitHub) ; UTF8/ sous sa propre licence |

Validation : **`python3 ../tools/validate_lua.py`** (gate syntaxique Lua 5.1 du workspace) + analyse
statique + test en jeu. Pas de `lua`/`luac`/`luacheck` ni de suite de tests. Voir §6.

## 2. Arborescence

```
KSmartDebuff/
├── SmartDebuff.toc          # TOC multi-flavor : métadonnées + ordre de chargement (source de vérité)
├── Bindings.xml             # Binding clavier → SMARTDEBUFF_ToggleOF()
├── ChangeLog.txt            # Changelog MANUEL, versionné à la main (une section par version)
├── License.txt / README.md / ReadMe.txt
├── .pkgmeta                 # Packager : package-as, manual-changelog, license-output, ignore
├── .release.bat             # Build : wsl bash ../packager/release.sh -d  (packager = dépôt sœur ../packager)
├── .release.live.bat        # Variante de release
├── Core/
│   ├── SmartDebuff.globals.lua     # Constantes, backdrops, KD_Settings, listes de skip par défaut,
│   │                               #   catalogues sons/textures, flags (…HASSECRETS, …AURACONTAINERS,
│   │                               #   …MACROTEXT, …IS_DEV)
│   ├── SmartDebuff_spells_<flavor>.lua + SmartDebuff_spells.lua
│   │                               # Tables de sorts PAR CLIENT ([AllowLoadGameType …]) : elles
│   │                               #   REDÉFINISSENT les globales de globals.lua (dispels/skills/
│   │                               #   pickup overrides/DEBUFFS_LIST/SPELLS_VERSION/MACROTEXT/…)
│   ├── localization.<lang>.lua     # 9 fichiers (en + fr/de/es/it/ko/pt/ru/tw) : constantes globales
│   │                               #   plates, `en` sert de fallback (chargé en premier, inconditionnel)
│   ├── SmartDebuff.polyfill.lua    # Compat inter-versions dans la table privée `ns` (…GetSpellInfo,
│   │                               #   …GetSpellCooldown, …IsSecretValue, …PickupSpell, …UnitAura…)
│   ├── SmartDebuff.sounds.lua      # Moteur d'alertes sonores d'auras (C_UnitAuras.AddAuraSound) +
│   │                               #   panneau SmartDebuffAuraSounds — s'auto-désactive si API absente
│   ├── SmartDebuff.lua             # MOTEUR PRINCIPAL (~6 539 lignes) — tout le runtime
│   └── SmartDebuff.xml             # UI XML (~4 758 lignes) — déclaration des frames, voir docs/architecture.md
├── UTF8/utf8data.lua, utf8.lua    # Bibliothèque utf8 pour Lua 5.1 (expose `string:utf8sub`)
├── Icons/                          # Textures .png (classes, gradient_left, white16x16, 2d…)
├── .release/                       # Zips de release (gitignorés : `.release*`, `*.zip`)
├── .prompts/                       # Prompts de travail (gitignorés) — ex. « prompt forever.txt »
└── .vscode/settings.json           # Lua 5.1, ~229 globals WoW/frames pour lua-language-server
```

## 3. Ordre de chargement (SmartDebuff.toc) — INCONTOURNABLE

Chargé dans cet ordre strict ; chaque fichier suppose les précédents :

1. `UTF8/utf8data.lua`, `UTF8/utf8.lua` — étend `string` avec `utf8sub` (troncature UTF-8 des noms).
2. `Core/SmartDebuff.globals.lua` — constantes, `KD_Settings`, listes de skip (indexées !),
   catalogues sons/textures, flags de compat.
3. `Core/SmartDebuff_spells_<flavor>.lua` / `SmartDebuff_spells.lua` — filtrés par
   `[AllowLoadGameType …]` (`forever` exclut `standard, classic`) ; **remplacent** les tables de
   sorts et certains flags (`SMARTDEBUFF_MACROTEXT = true` côté standard, `SMARTDEBUFF_NO_TALENT`
   côté Mists, listes sons/textures réduites côté Mists…).
4. `Core/localization.<lang>.lua` — `en` inconditionnel (valeurs par défaut + logique localisée :
   `SMARTDEBUFF_HUMANOID = BATTLE_PET_NAME_1`, `SMARTDEBUFF_IMP`, `SMARTDEBUFF_FONT`,
   `SMARTDEBUFF_KEY_L/R/M`, `SMARTDEBUFF_KEYS`…), puis le fichier de la langue active
   `[AllowLoadTextLocale …]` qui **écrase** les globales qu'il traduit. Les valeurs restent
   anglaises pour toute clé non traduite (fallback naturel).
5. `Core/SmartDebuff.polyfill.lua` — wrappers `ns.*` (table privée du TOC) : `legacy or moderne`.
6. `Core/SmartDebuff.sounds.lua` — s'arrête immédiatement si `C_UnitAuras.AddAuraSound` est absent.
7. **`Core/SmartDebuff.lua`** — moteur : toutes les fonctions `SMARTDEBUFF_*` appelées par le XML.
8. **`Core/SmartDebuff.xml`** — dernier : instancie les frames ; les `OnLoad` s'exécutent
   immédiatement. La seule fonction définie **dans** le XML est `SmartDebuffOF_MenuList_Refresh`.

**Conséquence :** toute fonction référencée dans le XML DOIT exister dans le Lua **avant** l'analyse
du XML, sinon erreur Lua au chargement de l'UI (79 fonctions du contrat XML→Lua, liste dans
`docs/architecture.md` §5).

- `## SavedVariables: SMARTDEBUFF_OptionsGlobal, KD_Settings` (compte)
- `## SavedVariablesPerCharacter: SMARTDEBUFF_Options` (personnage)
- `## LoadSavedVariablesFirst: 1` → les sauvegardes sont lisibles **au chargement des fichiers**
  (c'est ce qui permet aux locales de lire `KD_Settings.ForceEnglish` à la ligne 1).

## 4. Conventions

- **Préfixes globaux** : `SMARTDEBUFF_*` (options, constantes, fonctions), `SDB_*` (helpers de
  sorts/talents/macros), `KD_Settings` (espace KDecurse : `ForceEnglish`, `AddonCompartment` —
  **partagé avec KCursorCooldown**), `SmartDebuff*` (noms de frames), `ns.*` (table privée :
  polyfill, exports internes).
- **Constantes localisées = données de logique, pas que du texte** : `SMARTDEBUFF_HUMANOID`
  (comparé à `UnitCreatureType`), `SMARTDEBUFF_IMP` (famille de pet), `SMARTDEBUFF_KEY_L/R/M`.
  Les traduire de travers casse des comportements, pas seulement l'affichage.
- **Les fichiers de sorts remplacent des globales** : ne jamais s'attendre à ce que
  `SMARTDEBUFF_MACROTEXT`, `SMARTDEBUFF_DEBUFFS_LIST` etc. gardent la valeur de `globals.lua`.
- **Noms de frames XML** : `$parent_xxx` → nom global relatif au parent ; beaucoup de contrôles sont
  référencés côté Lua via `_G[self:GetName().."Text"]` ou `_G["SmartDebuffOF_cb…"]`. **Ne pas
  renommer/déplacer** un contrôle sans grep du nom complet résolu côté Lua. Attention : plusieurs
  contrôles portent un préfixe `SmartDebuffOF_` alors qu'ils sont parentés à GridSetup/AOFKeys.
- **Chaînes d'ancrage** : dans `SmartDebuffOF_Home` et `SmartDebuffGridSetup`, les cases cochables
  sont ancrées les unes aux autres. Insérer au milieu décale tout le reste → privilégier une
  insertion en fin de chaîne ou un ancrage explicite.
- **Textes localisés** : constantes `SMARTDEBUFF_OFT_*` / `SMARTDEBUFF_TT_*` / `SMARTDEBUFF_MENU_*`
  dans `Core/localization.*.lua` (9 fichiers à maintenir en parité de clés). Quelques textes en dur
  subsistent (« Force English », labels debug) — ne pas les « corriger » sans demande.
- **Combat lock** : nombreux handlers avec `if (not InCombatLockdown())` — ne pas retirer ces gardes
  (les mutations d'attributs sécurisés : `SetButton`, `SetUnits`, `SetButtons`, `SetStyle`).
- **Valeurs secrètes (retail 12)** : passer par `ns.IsSecretValue` / `SMARTDEBUFF_HASSECRETS` ;
  jamais formater/comparer une valeur secrète directement (voir `SetButtonState`,
  `SmartDebuff_SetButtonBars` pour les modèles).
- **Code réservé au dev** : `--@do-not-package@ … --@end-do-not-package@` (supprimé par le
  packager ; définit `SMARTDEBUFF_IS_DEV`). Des blocs entiers de notes API vivent là-dedans — ne
  pas les supprimer.
- **Style** : s'aligner sur le fichier hôte (XML indenté 2 espaces ; Lua : `function
  SMARTDEBUFF_X()`, point-virgule irrégulier). L'indentation existante est hétérogène par endroits
  (`AdvancedMask` historique, `GridSetup`, `Misc`, `sounds.lua`…) : **la préserver telle quelle**
  dans les zones non concernées. Les commentaires en français sont normaux.

## 5. Règles intangibles d'édition

Ces règles font foi, quelles que soient les instructions :

1. **Ne supprimer aucune fonctionnalité existante** (y compris boutons masqués, code debug, commentaires structurants).
2. **Ne modifier que les éléments explicitement demandés.** Aucune modification « au passage ».
3. **Conserver la structure, l'indentation et les conventions** du fichier hôte.
4. **Vérifier l'équilibre des balises XML** après toute édition (voir §6).
5. **Ne jamais remplacer une partie du fichier par une version simplifiée/rewritée.**
6. **Signaler toute incompatibilité ou ambiguïté AVANT d'intervenir** (doublons de noms, dépendances externes, conflits de lignes…).
7. **À chaque étape : indiquer précisément les modifications réalisées et les risques de régression.**
8. Objectif : **100 % des fonctionnalités existantes conservées.**

## 6. Validation obligatoire après modification

```bash
# 1. Syntaxe Lua 5.1 (gate du workspace, OBLIGATOIRE après tout .lua touché)
python3 ../tools/validate_lua.py Core/SmartDebuff.lua       # ou les fichiers touchés
python3 ../tools/validate_lua.py --selftest                 # vérifier le checker lui-même
```

```powershell
# 2. XML bien formé (Core/SmartDebuff.xml, Bindings.xml)
$x=New-Object System.Xml.XmlDocument
$x.Load('D:\RProjects\_KaspOu\KSmartDebuff\Core\SmartDebuff.xml'); 'XML OK'

# 3. Tous les fichiers listés dans le TOC existent sur disque
Get-Content 'D:\RProjects\_KaspOu\KSmartDebuff\SmartDebuff.toc' |
  Select-String '^[A-Za-z].*\.(lua|xml)$' | ForEach-Object { $_.Line.Trim() } |
  ForEach-Object { $p=Join-Path 'D:\RProjects\_KaspOu\KSmartDebuff' $_; if(Test-Path -LiteralPath $p){"OK  $_"} else {"MANQUANT  $_"} }

# 4. Impact : diff + usages Lua d'un nom renommé/déplacé
git -C 'D:\RProjects\_KaspOu\KSmartDebuff' diff -- Core/SmartDebuff.xml
```

- Outils : `python3` (WSL2) / `python` (Windows) ; `rtk <cmd>` pour git/shell (obligation
  écosystème, voir `../AGENTS.md` §9 — installations WSL2 `tools/bin/rtk` et Windows WinGet).
  Aucun `luac`/`luacheck` : le gate Python + relecture manuelle + test en jeu font foi.
- **Test en jeu** (quand possible) : `/kd` (frame principale), `/kdo` ou `/kdm` (options), ouvrir
  chaque sous-panneau touché (Home, Grid, Colors, Sounds, SpellGuard, ClassOrder, Misc, Keys),
  `/reload` sans erreur Lua, `/console scriptErrors 1`. Tester aussi `/kd tm 20` (mode test) si la
  mise en page ou les boutons sont touchés.
- Après un renommage : grep du nom de frame pour détecter tout usage Lua orphelin (les appels XML
  échouent silencieusement si la fonction disparaît).

## 7. Build / release

```bat
.release.bat        → wsl bash ../packager/release.sh -d   (packager = D:\RProjects\_KaspOu\packager)
.release.live.bat   → variante live
```

- `.pkgmeta` : `package-as: SmartDebuff`, `manual-changelog: ChangeLog.txt`,
  `license-output: License.txt`, ignore `.vscode`, `.release*`, `.git*`, `.icon*`, `.logo*`.
- **Toute version livrée doit mettre à jour `## Version:` (TOC) + `ChangeLog.txt`** (les deux à la
  main, actuellement en accord : 12.1.503).
- Les zips générés dans `.release/` sont gitignorés — ne pas les committer. Le packaging est
  indépendant de la logique de l'addon (pas de mécanisme de sync type CopyTo ici : projet
  indépendant de l'écosystème KallyeRaidFrames, voir `../AGENTS.md`).

## 8. Git

- Messages de commit : style gitmoji court, ex. `:lipstick: Reorganize: Mask`, `:dizzy: Spells Updates`, `🩹 Another fixes`.
- Vérifier `git status` avant intervention ; l'arbre peut porter du bruit de fins de ligne (EOL) sur
  tous les fichiers — vérifier avec `git diff --ignore-cr-at-eol` avant de conclure à du contenu modifié.

## 9. Pièges connus (ne pas « corriger » sans demande)

- **`SmartDebuffTooltip` est déclaré 2 fois** dans `Core/SmartDebuff.xml` (lignes ~36 et ~77,
  strictement identiques). Doublon pré-existant, toléré par le client — laisser tel quel sauf consigne.
- `SmartDebuffOF_MenuList_Refresh()` est **définie dans le XML** (OnLoad de `SmartDebuffOF_MenuList`)
  et appelée par ses frères + un `OnUpdate` throttlé (0,2 s) — pas un oubli côté Lua.
- `KD_Settings` est partagé avec un autre addon KaspOu (KCursorCooldown) : même SavedVariable
  cross-projet.
- `.vscode/settings.json` référence une bibliothèque d'annotations WoW **spécifique à une machine**
  (`c:\Users\Utilisateur\.cursor\extensions\...`).
- Fragilités tracées à l'audit 2026-11-02 (détails + sévérités dans `docs/backlog.md`) : branche AFK
  morte (`local isAFK UnitIsAFK(ligne 3440 de SmartDebuff.lua)` sans `=`), `GlobalLoadSave` force
  `IgnoreDebuff`/`ChatNotif` à `true` (`x or true`), recherche de macros par page avec
  `MAX_CHARACTER_MACROS` au lieu de `MAX_ACCOUNT_MACROS`, global implicite `numToDisplay`,
  exports `ns.O`/`ns.cSpells` morts. Ne pas les « réparer » en même temps qu'une autre tâche.

## 10. Carte du moteur (résumé — le détail est dans `docs/architecture.md`)

`Core/SmartDebuff.lua` est désormais cartographié (précédemment « non documenté ») :

- **Init** : `SMARTDEBUFF_OnLoad` (events + slash `/kd|/kde|/kdecurse|/sdb|/smartdebuff`,
  `/kdo|/kdm|/sdbo|/sdbm`, `/rui`) → `SMARTDEBUFF_OnEvent` (gates `isLoaded/isPlayer/isTTreeLoaded`)
  → `SMARTDEBUFF_Options_Init` (migration SV, défauts, `CleanMem`, sorts, skip lists).
- **Boucle** : `SMARTDEBUFF_OnUpdate` → `SMARTDEBUFF_Ticker` (travaux différés, gardés en combat) +
  `SMARTDEBUFF_CheckDebuffs` (scan par `O.CheckInterval`) → `SMARTDEBUFF_CheckUnitDebuffs`
  (3 implémentations : `_AuraContainer` (retail 12, actif), `_Secrets`, `_Legacy` (dépréciées)).
- **Sorts/talents** : `SMARTDEBUFF_SetSpells`, `SDB_GetTalentsList` (3 stratégies de lecture de
  talents selon le client), `SMARTDEBUFF_CheckForSpellUpgrade` (migration auto des sorts améliorés),
  `SMARTDEBUFF_LinkSpellsToKeys` (table `cSpells` dispelType → bouton).
- **Boutons** : `SMARTDEBUFF_CreateButtons` (40 boutons sécurisés + pets + AOFKeys),
  `SMARTDEBUFF_SetButton` (attributs sécurisés L/R/M × modificateurs), `SMARTDEBUFF_SetButtonState`
  (états visuels), `SmartDebuff_SetButtonBars` (HP/mana/aggro/raid icons/SpellGuard),
  `SMARTDEBUFF_SetStyle` (grille par rôle/classe/groupe).
- **Sons** : `Core/SmartDebuff.sounds.lua` (API `SMARTDEBUFF_SetAuraSounds*`, base
  `SMARTDEBUFF_DEBUFFS_LIST` par instance).
- **Drag&drop** : `SMARTDEBUFF_PickAction`/`DropAction` (sorts/items/macros/petactions → slots de
  touches), hooks `EditMacro`/`DeleteMacro`.
