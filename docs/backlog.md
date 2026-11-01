# Backlog — KSmartDebuff

Travail ouvert et constats d'audit pour KDecurse (SmartDebuff). Audit report-only : aucun code n'a
été modifié.

## KSmartDebuff audit 2026-11-02

Périmètre : intégralité du répertoire (arbre git propre en contenu — bruit EOL seul), profondeur
`high`. Classement par sévérité ; chaque constat est tracé dans le code réel.

### Medium

1. **`Core/SmartDebuff.lua:3440` — affichage AFK entièrement mort.**
   `local isAFK UnitIsAFK(unit)` sans `=` : Lua 5.1 valide (deux instructions juxtaposées — vérifié
   au parser du projet), donc `isAFK` reste `nil` et la branche 3441-3445 (préfixe « AFK », teinte
   marron, `ST.iTotAFK + 1`) ne s'exécute **jamais** ; le compteur AFK de la ligne d'info reste à 0.
   Correctif attendu : `local isAFK = UnitIsAFK(unit)`.
2. **`Core/SmartDebuff.lua:5365-5366` — `GlobalLoadSave` force `IgnoreDebuff` et `ChatNotif` à `true`.**
   `S.IgnoreDebuff = L.IgnoreDebuff or true` (idem `ChatNotif`) : un `false` utilisateur devient
   `true` à travers les boutons Global Save (5370) et Global Load (5376). Seul `StopCast` utilise
   l'idiome neutre `or false`. Une préférence « off » est perdue à chaque passage par ces boutons.

### Low

3. **`Core/SmartDebuff.lua:1758-1764` — frontière de pages de macros incorrecte.**
   `SDB_GetMacroIndex` utilise `MAX_CHARACTER_MACROS` comme frontière comptes/personnage
   (`Id > MAX_CHARACTER_MACROS` → page « personnage » depuis `MAX_CHARACTER_MACROS+1`) alors que la
   frontière d'index de l'API est `MAX_ACCOUNT_MACROS`. Les macros de compte au-delà de l'index 18
   et les macros personnage sont cherchées dans la mauvaise page ; au pire, une macro différente
   avec la même icône est rattachée à une touche. (Basé sur le contrat documenté de l'API macros.)
4. **`Core/SmartDebuff.lua:3564, 3571, 3596, 3616, 3638` — `string.format("%.2f", remains)` évalué
   sans garde.** Les arguments sont construits même sans debug actif ; si `remains` est `nil`, le
   format lève une erreur dans la boucle de scan (toutes les `O.CheckInterval`). Atteignable via la
   branche esclavage de `CheckUnitDebuffs_Legacy`/`_Secrets` (4979/5059) quand aucune aura n'a
   rempli `cud_tl` (unité humanoïde charmée, chemin non-AuraContainer). Étroit mais réel.
5. **`Core/SmartDebuff.lua:5449-5453` — global implicite `numToDisplay`.**
   `getMaxScrollBtn` l'assigne sans `local` et le retourne : pollution de `_G`, fragile face aux
   autres addons.
6. **`Core/SmartDebuff.lua:6461-6462` — exports `ns.O`/`ns.cSpells` morts.**
   `ns.O = O` capture `nil` (avant `Options_Init`) et `ns.cSpells` devient périmé dès la première
   réassignation de `cSpells` (1836). Aucun consommateur aujourd'hui (grep) — code mort, piège pour
   un futur appelant.
7. **`Core/SmartDebuff.lua:4685` — détection « offline » anglaise uniquement.**
   `string.find(string.lower(io_text), "offline")` ne marche que sur client anglais (frFR affiche
   « Absent »). Redondant avec `UnitIsConnected` (3448) : repli perdu, pas une fonctionnalité cassée.
8. **Amas cosmétique XML (vérifié) :** `SmartDebuffTooltip` déclaré deux fois (`SmartDebuff.xml:36`
   et `:77`, blocs identiques) ; `SmartDebuffWNF` `movable="true"` mais handlers de drag vides et
   aucun `RegisterForDrag` (`:4736-4756`) — non déplaçable ; `--SMARTDEBUFF_ToggleAOFOrder(1);`
   commenté (`:1395`, `:2384`) vers une fonction inexistante ; contrôles nommés `SmartDebuffOF_*`
   parentés à GridSetup/AOFKeys ; `txtIn` du panneau Sounds en `EnableMouse(false)` alors que
   NRDebuffs/SpellGuard acceptent la saisie (probablement intentionnel, liste alimentée par le
   catalogue) ; `GameTooltip:AddLine(…PETACTION…)` dupliqué (`SmartDebuff.lua:6365-6366`) ; handlers
   vides (SF/IF/OF/WNF) ; indentation hétérogène.

### Cleared (vérifié — ne pas re-fouiller)

- `local isAFK UnitIsAFK(unit)` n'est **pas** une erreur de chargement : syntaxe Lua 5.1 valide
  (deux instructions), confirmée par le parser `tools/validate_lua.py` — le bug est la branche
  morte, pas un crash.
- `ns.Enum_SpellBookSpellBank_Player0` (1078, champ inexistant → `nil`) : comportement correct car
  `IsSpellKnownOrInSpellBook` défaut sur la banque joueur quand `spellBank` est nil, et la branche
  pet passe la bonne énumération.
- Sécurité des valeurs secrètes : `ns.IsSecretValue` + gardes à chaque lecture sensible
  (`SetButtonState` 3526, `SetButtonBars` 3853/3859/3881/3908/4009, `GetSpellCD` 282-284) ;
  `SetButtonState_Curve_Secrets` passe par `C_CurveUtil`, jamais de format/comparaison directe.
- Discipline combat : chaque mutation de frame/attributs est gardée par `InCombatLockdown()`
  (`SetUnits`, `SetButtons`, `SetButton`, ticker) ; les lectures utilisent
  `SecureButton_GetModifiedAttribute`.
- `sounds.lua` s'auto-désactive proprement sans `C_UnitAuras.AddAuraSound` (return ligne 1) — aucune
  inscription partielle.
- Init ordonnée : gates `isLoaded/isPlayer/isTTreeLoaded` + queue AceAddon absente ici (frame nu) ;
  `checkForInit` prévient l'utilisateur ; `PopulateCdSpellsOptions`-style sans risque d'ordre.
- Listes de skip indexées : les indices sont validés à l'usage (`SMARTDEBUFF_DEBUFFSKIP_NAME[val]`,
  1528/1542) avant résolution en noms.
- XML bien formé (parse ElementTree) ; les 79 fonctions du contrat XML→Lua résolvent (seule la
  référence commentée `ToggleAOFOrder` pointe vers du vide) ; `SmartDebuffOF_MenuList_Refresh` est
  définie dans le XML par conception.
- `SetCVar("tooltipShowAuraSpellIDs", …)` : comportement voulu par l'option `ShowAuraSpellIDs`.
- Hooks macro `hooksecurefunc` (1728/1741) : post-hooks uniquement, pas de taint.

### Hardening (correct aujourd'hui, fragile — pas des vulnérabilités)

- `O.Keys[1]["M"]` (1474) suppose `O.Keys[1]` existant : une SV tronquée (`Keys = {}`) erreurne à
  l'init.
- `CFG.filterString` est remplacé par classe (WARLOCK/HUNTER) via chaînes magiques couplées aux
  filtres d'auras Blizzard.
- `BlizzUnitFrame("pet")` renvoie un tableau `{ inDistance = true }` déguisé en frame (seul
  `.inDistance` est lu) — fragile si d'autres champs sont lus plus tard.
- `GetInstanceByID` (sounds.lua) change la sélection de palier de l'Encounter Journal pendant la
  construction du cache (restaurée à la fin, mais pas de `pcall` : une erreur intermédiaire
  laisserait la sélection déplacée).
- Les constantes localisées portent de la logique (`SMARTDEBUFF_HUMANOID`, `SMARTDEBUFF_IMP`,
  `SMARTDEBUFF_FONT`) : une mauvaise traduction casse des comportements.

### Coverage

Parcouru intégralement : `Core/SmartDebuff.lua` (6 539 l.), `SmartDebuff.globals.lua`,
`SmartDebuff.polyfill.lua`, `SmartDebuff.sounds.lua`, `SmartDebuff.toc`, `Bindings.xml`, `.pkgmeta`,
structure du XML (inventaire frames/contrat + vérifications ponctuelles des lignes citées),
`SmartDebuff_spells.lua` (en-tête + tables), lignes de config des flavors Mists/Forever,
mécanisme des locales (échantillons en/de/fr + constantes), `README/ReadMe/ChangeLog` (surface).
Partiel : tables des fichiers de sorts au-delà des premières entrées ; corps du XML hors
vérifications ponctuelles. **GAP non audité** : `UTF8/utf8data.lua` (données tierces),
intérieur de `UTF8/utf8.lua`, contenu des traductions, `.release/` (exclu), binaires. Un
sous-agent d'exploration n'a pas renvoyé son rapport (sorts/sons/utf8/locales) : ses candidats ne
sont pas intégrés ; le périmètre a été recouvert par lectures directes. Rien n'a été exécuté dans
WoW.

### Synthèse

2 medium, 6 low (dont un amas cosmétique), 0 vulnérabilité de sécurité (addon client sans surface
injection/mémoire/crypto), risque global : fonctionnel — l'addon fonctionne en jeu, mais deux
fonctionnalités sont silencieusement mortes ou trahies (affichage AFK ; préférences
IgnoreDebuff/ChatNotif via Global Save/Load). Priorités : ① ajouter le `=` manquant ligne 3440,
② corriger les `or true` de `GlobalLoadSave` (5365-5366), ③ revoir la frontière de pages macros
(`MAX_ACCOUNT_MACROS`). Toute correction reste à valider en jeu (`AGENTS.md` §6).
