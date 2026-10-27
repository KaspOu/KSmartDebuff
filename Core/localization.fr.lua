-------------------------------------------------------------------------------
-- French localization
-------------------------------------------------------------------------------
if KD_Settings and KD_Settings.ForceEnglish then return end;

SMARTDEBUFF_UPGRADED = "KDecurse mis à jour : "..SMARTDEBUFF_VERSION;

SMARTDEBUFF_WHATSNEW = [[|cffffffffNouveautés :|r

|cfffff2cc> Redesign de l'écran options :|r
  - Texture de débuff directement appliquée
  - Infobulle de débuff
  - IDs de sort d'aura

|cfffff2cc> Sons ajoutés pour:|r
  - Le Déliement de Kith'ix
  - Le Labyrinthe de Kindo'jan





|cffff1010ATTENTION :|r
|cfffff2ccBugs côté Blizzard :|r
Chutes de FPS (avec des unités très distantes, ...) |cff4f81bd(Midnight)|r





             |cff00ff00K|r|cffffffffDecurse|r |cff999999/ SmartDebuff|r
]]

--@do-not-package@
-- Debuff types, in english in game!
--[[
SMARTDEBUFF_DISEASE = "Maladie";
SMARTDEBUFF_MAGIC   = "Magie";
SMARTDEBUFF_POISON  = "Poison";
SMARTDEBUFF_CURSE   = "Malédiction";
SMARTDEBUFF_CHARMED = "Contrôle mental";
]]--
--@end-do-not-package@


-- Creatures
SMARTDEBUFF_HUMANOID  = BATTLE_PET_NAME_1;
SMARTDEBUFF_DEMON     = PET_TYPE_DEMON;
SMARTDEBUFF_BEAST     = BATTLE_PET_NAME_8;
SMARTDEBUFF_ELEMENTAL = BATTLE_PET_NAME_7;
SMARTDEBUFF_IMP       = "Diablotin";
SMARTDEBUFF_FELHUNTER = "Chasseur corrompu";
SMARTDEBUFF_DOOMGUARD = "Garde funeste";

-- Classes
SMARTDEBUFF_CLASSES = {["HPET"] = "Familier Chasseur", ["WPET"] = "Familier Démoniste", ["DPET"] = "Familier Chasseur de démons"};
for _, class in ipairs(CLASS_SORT_ORDER) do SMARTDEBUFF_CLASSES[class] = LOCALIZED_CLASS_NAMES_MALE[class] end;


-- Bindings
BINDING_NAME_SMARTDEBUFF =  SMARTDEBUFF_TITLE.." Options";

if not SMARTDEBUFF_Options or not SMARTDEBUFF_Options.ForceLR then
    SMARTDEBUFF_KEY_L = "G";
    SMARTDEBUFF_KEY_R = "D";
    SMARTDEBUFF_KEY_M = "M";
end
SMARTDEBUFF_KEYS = {["L"]  = "Gauche (G)",
                    ["R"]  = "Droite (D)",
                    ["M"]  = "Milieu (M)",
                    ["SL"] = "Maj gauche",
                    ["SR"] = "Maj droite",
                    ["SM"] = "Maj milieu",
                    ["AL"] = "Alt gauche",
                    ["AR"] = "Alt droite",
                    ["AM"] = "Alt milieu",
                    ["CL"] = "Ctrl gauche",
                    ["CR"] = "Ctrl droite",
                    ["CM"] = "Ctrl milieu"
                    };


-- Messages
SMARTDEBUFF_MSG_LOADED         = "chargé";
SMARTDEBUFF_MSG_SDB            = "Menu d'options KDecurse";

-- Frame text
SMARTDEBUFF_FT_MODES           = "Touches / Modes";
SMARTDEBUFF_FT_MODENORMAL      = "Norm";
SMARTDEBUFF_FT_MODETARGET      = "Cible";


-- Options frame text
SMARTDEBUFF_OFT                = "Afficher/Masquer les options KDecurse";
SMARTDEBUFF_OFT_HUNTERPETS     = "Familier de Chasseur";
SMARTDEBUFF_OFT_WARLOCKPETS    = "Familier de Démoniste";
SMARTDEBUFF_OFT_DEATHKNIGHTPETS= "Familier de Chevalier de la mort";
SMARTDEBUFF_OFT_HP             = "Vie";
SMARTDEBUFF_OFT_MANA           = "Mana";
SMARTDEBUFF_OFT_HPTEXT         = "%";
SMARTDEBUFF_OFT_INVERT         = "Inverser";
SMARTDEBUFF_OFT_SORT           = "Tri"
SMARTDEBUFF_OFT_CLASSVIEW      = "Tri par classe";
SMARTDEBUFF_OFT_CLASSCOLOR     = "Couleurs de classe";
SMARTDEBUFF_OFT_SHOWLR         = "Afficher G / D / M";
SMARTDEBUFF_OFT_FORCELR        = "Forcer l'affichage de L / R / M"
SMARTDEBUFF_OFT_HEADERS        = "En-têtes";
SMARTDEBUFF_OFT_GROUPNR        = "Numéro de groupe";
SMARTDEBUFF_OFT_SOUND          = "Son";
SMARTDEBUFF_OFT_TOOLTIP        = "Infobulle";
SMARTDEBUFF_OFT_TARGETMODE     = "Mode cible";
SMARTDEBUFF_OFT_HEALRANGE      = "Portée de soin";
SMARTDEBUFF_OFT_SHOWAGGRO      = "Aggro";
SMARTDEBUFF_OFT_VERTICAL       = "Disposition verticale";
SMARTDEBUFF_OFT_VERTICALUP     = "Vertical vers le haut";
SMARTDEBUFF_OFT_HEADERROW      = "Barre de titre";
SMARTDEBUFF_OFT_BACKDROP       = "Arrière-plan";
SMARTDEBUFF_OFT_SHOWGRADIENT   = "Dégradé";
SMARTDEBUFF_OFT_INFOFRAME      = "Cadre récapitulatif";
SMARTDEBUFF_OFT_AUTOHIDE       = "Masquage auto.";
SMARTDEBUFF_OFT_COLUMNS        = "Colonnes";
SMARTDEBUFF_OFT_COLTEXTURE     = "Texture du débuff"
SMARTDEBUFF_OFT_INTERVAL       = "Intervalle";
SMARTDEBUFF_OFT_FONTSIZE       = "Taille de police";
SMARTDEBUFF_OFT_WIDTH          = "Largeur";
SMARTDEBUFF_OFT_HEIGHT         = "Hauteur";
SMARTDEBUFF_OFT_BARHEIGHT      = "Hauteur de barre";
SMARTDEBUFF_OFT_COLOR_LEFT     = "Débuff\nGauche"
SMARTDEBUFF_OFT_COLOR_RIGHT    = "Débuff\nDroite"
SMARTDEBUFF_OFT_COLOR_MIDDLE   = "Débuff\nMilieu"
SMARTDEBUFF_OFT_COLOR_NOTREM   = "Débuff\nNon\nDissipable"
SMARTDEBUFF_OFT_COLOR_UNIT     = "Bouton\nd'unité"
SMARTDEBUFF_OFT_COLOR_BACKDROP = "Arrière-plan\nCliquez-moi"
SMARTDEBUFF_OFT_OPACITYNORMAL  = "Opacité à portée";
SMARTDEBUFF_OFT_OPACITYOOR     = "Opacité hors de portée";
SMARTDEBUFF_OFT_OPACITYDEBUFF  = "Opacité des débuffs";
SMARTDEBUFF_OFT_NOTREMOVABLE   = "Débuffs critiques";
SMARTDEBUFF_OFT_DEBUFFTOOLTIP  = "Infobulle de débuff";
SMARTDEBUFF_OFT_AURASPELLIDS   = "IDs de sort d'aura";
SMARTDEBUFF_OFT_VEHICLE        = "Véhicules";
SMARTDEBUFF_OFT_SHOWRAIDICON   = "Icônes de raid";
SMARTDEBUFF_OFT_SHOWROLEICON   = "Icônes de rôle (tank/heal)";
SMARTDEBUFF_OFT_SHOWROLEDPSICON = "Icônes de rôle (dps)";
SMARTDEBUFF_OFT_SHOWSPELLICON  = "Icônes de HoT";
SMARTDEBUFF_OFT_INFOROW        = "Barre d'informations";
SMARTDEBUFF_OFT_GLOBALSAVE     = "Enregistrer";
SMARTDEBUFF_OFT_GLOBALLOAD     = "Charger";
SMARTDEBUFF_OFT_RESET          = "Réinit";
SMARTDEBUFF_OFT_ROLE           = "Rôle";
SMARTDEBUFF_OFT_ADVANCHORS     = "Configurer les ancres";
SMARTDEBUFF_OFT_ICONSIZE       = "Taille des icônes";
SMARTDEBUFF_OFT_COLORSETUP     = "Configurer les couleurs";
SMARTDEBUFF_OFT_GRIDSETUP      = "Configurer la grille";
SMARTDEBUFF_OFT_SPACEX         = "Espacement X";
SMARTDEBUFF_OFT_SPACEY         = "Espacement Y";
SMARTDEBUFF_OFT_TESTMODE       = "Mode test";
SMARTDEBUFF_OFT_STOPCAST       = "Interruption de sort";
SMARTDEBUFF_OFT_IGNOREDEBUFF   = "Ignorer en recharge";
SMARTDEBUFF_OFT_CHATNOTIF      = "Notifications de chat";
SMARTDEBUFF_OFT_ADDONCOMPARTMENT = "Compartiment des Add-ons";
SMARTDEBUFF_OFT_RESET_KEYS     = "Réinitialiser les sorts KDecurse par défaut ?\n\nCette action est nécessaire si vous avez l'impression que tous les débuffs ne sont pas correctement détectés.";
SMARTDEBUFF_AOFT_SORTBYCLASS   = "Ordre des classes";
SMARTDEBUFF_NRDT_TITLE         = "Débuffs non dissipables";
SMARTDEBUFF_SG_TITLE           = "Sorts (HoT) suivis";
SMARTDEBUFF_S_TITLE            = "Son d'alerte de débuff";


-- Tooltip text
SMARTDEBUFF_TT                 = "Glisser le titre avec Maj-Clic gauche : Déplace le cadre\n|cff20d2ff- Bouton K -|r\nClic gauche : Afficher par classe, rôle ou groupe\nMaj-Clic gauche : Couleurs de classe\nAlt-Clic gauche : Mise en avant G/D/M\nClic droit : Arrière-plan";
SMARTDEBUFF_TT_TARGETMODE      = "En mode normal, |cff20d2ffClic gauche|r dissipe l'unité...\n \nEn mode cible, |cff20d2ffClic gauche|r sélectionne l'unité,\ndissipez avec |cff20d2ffAlt-Clic|r\net |cff20d2ffClic droit|r lance le sort de soin le plus rapide.|r.";
SMARTDEBUFF_TT_NOTREMOVABLE    = "Affiche les débuffs critiques\nqui ne sont pas dissipables.";
SMARTDEBUFF_TT_DEBUFFTOOLTIP   = "Affiche les infobulles des débuffs\nau survol.";
SMARTDEBUFF_TT_AURASPELLIDS    = "|cffffffffBlizzard:|r Affiche le Spell ID des auras\n(buffs et debuffs) dans les infobulles.";
SMARTDEBUFF_TT_HP              = "Affiche les points de vie\nréels de l'unité.";
SMARTDEBUFF_TT_MANA            = "Affiche la barre de mana\nréelle de l'unité.";
SMARTDEBUFF_TT_HPTEXT          = "Affiche les points de vie/mana\nréels en pourcentage de\nl'unité en texte.";
SMARTDEBUFF_TT_INVERT          = "Affiche les points de vie\net la barre de mana inversés.";
SMARTDEBUFF_TT_CLASSVIEW       = "Affiche les boutons d'unité\ntriés par classe.";
SMARTDEBUFF_TT_CLASSCOLOR      = "Affiche les boutons d'unité dans\nleurs couleurs de classe respectives.";
SMARTDEBUFF_TT_SHOWLR          = "Affiche le bouton de souris correspondant (G/D/M)\nsi une unité a un débuff.";
SMARTDEBUFF_TT_HEADERS         = "Affiche le n° de groupe / classe / rôle\ncomme en-tête.";
SMARTDEBUFF_TT_GROUPNR         = "Affiche le numéro de groupe\ndevant le nom de l'unité.";
SMARTDEBUFF_TT_SOUND           = "Joue un son si une\nunité reçoit un débuff 'connu'.";
SMARTDEBUFF_TT_TOOLTIP         = "Affiche l'infobulle\nseulement hors combat.";
SMARTDEBUFF_TT_HEALRANGE       = "Affiche une bordure rouge\nsi votre sort est hors de portée.";
SMARTDEBUFF_TT_SHOWAGGRO       = "Affiche quelle\nunité a l'aggro.";
SMARTDEBUFF_TT_VERTICAL        = "Affiche les unités\ndisposées verticalement.";
SMARTDEBUFF_TT_VERTICALUP      = "Affiche les unités\ndu bas vers le haut.";
SMARTDEBUFF_TT_HEADERROW       = "Affiche la ligne d'en-tête,\ny compris les boutons de menu.";
SMARTDEBUFF_TT_BACKDROP        = "Affiche un cadre\nd'arrière-plan noir.";
SMARTDEBUFF_TT_SHOWGRADIENT    = "Affiche les boutons d'unité\navec un dégradé de couleur.";
SMARTDEBUFF_TT_INFOFRAME       = "Affiche le cadre récapitulatif\nseulement en configuration de groupe ou de raid.";
SMARTDEBUFF_TT_AUTOHIDE        = "Masque automatiquemt les boutons\nd'unité si vous êtes hors combat\net que personne n'a de débuff.";
SMARTDEBUFF_TT_VEHICLE         = "Affiche également le véhicule\nd'une unité comme un bouton distinct.";
SMARTDEBUFF_TT_SHOWRAIDICON    = "Affiche l'icône de raid\nde l'unité.";
SMARTDEBUFF_TT_SHOWROLEICON    = "Affiche l'icône de rôle des tanks / heals.\n(si pas d'icône de raid)";
SMARTDEBUFF_TT_SHOWROLEDPSICON    = "Affiche l'icône de rôle des dps.\n(si pas d'icône de raid)";
SMARTDEBUFF_TT_SHOWSPELLICON   = "Affiche les icônes de HoT\nsur l'unité.";
SMARTDEBUFF_TT_INFOROW         = "Affiche une barre d'informations concise (uniquement en raid) :\nJoueurs/Morts/AFK/Hors ligne\nVie/Mana\nJoueur prêt\n(seulement en raid)";
SMARTDEBUFF_TT_GLOBALSAVE      = "Paramètres enregistrés dans la sauvegarde globale.";
SMARTDEBUFF_TT_GLOBALLOAD      = "Paramètres chargés depuis la sauvegarde globale.";
SMARTDEBUFF_TT_ROLE            = "Affiche les boutons d'unité\npar ordre de rôle.";
SMARTDEBUFF_TT_ADVANCHORS      = "Affiche et utilise la configuration\navancée des points d'ancrage\npour le cadre de débuff.";
SMARTDEBUFF_TT_STOPCAST        = "Interrompt immédiatement le\nlancement ou la canalisation en\ncours pour lancer le sort défini.\n(Uniquement pour les sorts de dissipation)";
SMARTDEBUFF_TT_IGNOREDEBUFF    = "Ignore le débuff sur l'unité\nsi votre sort de dissipation est en temps de recharge";
SMARTDEBUFF_TT_CHATNOTIF       = "Affiche des notifications de chat au chargement";
SMARTDEBUFF_TT_ADDONCOMPARTMENT = "Afficher dans le compartiment des Add-ons (en haut à droite)"
SMARTDEBUFF_TT_RELOADREQUIRED   = "Un rechargement est requis (tapez /reload)"
SMARTDEBUFF_TT_DISABLED_VERSION  = "Cette option n'est pas disponible sur cette version de WoW."
SMARTDEBUFF_TT_DISABLED_BLIZZARD = "Cette option n'est plus disponible en raison des limitations de Blizzard."
SMARTDEBUFF_TT_COLTEXTURE       = "Définir la texture de l'icône\n(utiliser le Mode test pour prévisualiser)\n"

--SMARTDEBUFF_TT_COLUMNS         = "Columns";
--SMARTDEBUFF_TT_INTERVAL        = "Interval";
--SMARTDEBUFF_TT_FONTSIZE        = "Font size";
--SMARTDEBUFF_TT_WIDTH           = "Width";
--SMARTDEBUFF_TT_HEIGHT          = "Height";
--SMARTDEBUFF_TT_BARHEIGHT       = "Bar height";
--SMARTDEBUFF_TT_OPACITYNORMAL   = "Opacity in range";
--SMARTDEBUFF_TT_OPACITYOOR      = "Opacity out of range";
--SMARTDEBUFF_TT_OPACITYDEBUFF   = "Opacity debuff";

-- Tooltip text key bindings
SMARTDEBUFF_TT_DROP            = "Déposer";
SMARTDEBUFF_TT_DROPINFO        = "Glissez ici un sort/objet/macro de votre livre/inventaire.\n|cff00ff00Clic gauche pour définir la fonction cible.\nMaj-Clic gauche pour définir la fonction menu";
SMARTDEBUFF_TT_SPELLACTIONS    = "Clic sur le sort :\n Gauche pour prendre\n Maj-Gauche pour cloner\n Droit pour supprimer";
SMARTDEBUFF_TT_ITEMACTIONS     = "Clic sur l'objet :\n Gauche pour prendre\n Maj-Gauche pour cloner\n Droit pour supprimer";
SMARTDEBUFF_TT_MACROACTIONS    = "Clic sur la macro :\n Gauche pour prendre\n Maj-Gauche pour cloner\n Droit pour supprimer";
SMARTDEBUFF_TT_TARGET          = "Cible";
SMARTDEBUFF_TT_TARGETINFO      = "Sélectionne l'unité spécifiée\ncomme cible actuelle.";
SMARTDEBUFF_TT_PETACTION       = "Action de familier";
SMARTDEBUFF_TT_NOTFOUND        = "Erreur : Sort introuvable";
SMARTDEBUFF_TT_MISSINGINFO     = "Vérifiez votre Spécialisation / Talent / Familier.";
SMARTDEBUFF_TT_NOTMOVABLE      = "Impossible à déplacer avec votre Spécialisation";
SMARTDEBUFF_TT_TARGETACTIONS   = "Clic de la souris :\n Droit pour supprimer";
SMARTDEBUFF_TT_PETACTIONS      = "Action du familier :\nSuppression impossible !";
SMARTDEBUFF_TT_MENU            = "Menu";
SMARTDEBUFF_TT_MENUINFO        = "Ouvre le menu des options de l'unité.";
SMARTDEBUFF_TT_PICKMENU        = "Clic de la souris :\n Droit pour supprimer";
SMARTDEBUFF_TT_DROPABBLE       = "Clic de la souris :\n Gauche pour déposer\n Droit pour relâcher";
SMARTDEBUFF_TT_DROPREPLACE     = "Clic de la souris :\n Gauche pour remplacer\n Droit pour relâcher";
SMARTDEBUFF_TT_DROPEXCHANGE    = "Clic de la souris :\n Gauche pour échanger\n Droit pour relâcher";
SMARTDEBUFF_TT_CANTDROP        = "Clic de la souris :\n Droit pour relâcher";

SMARTDEBUFF_INFO_READY         = "Joueurs:\nPV %:\nMana %:\nMorts:\nAFK:\nHors ligne:\nPrêts:";
SMARTDEBUFF_INFO               = "Joueurs:\nPV %:\nMana %:\nMorts:\nAFK:\nHors ligne";

--Tooltips added by Semi#1287
SMARTDEBUFF_TT_OPTIONS          = "|cff20d2ff- Bouton O -|r\nClic gauche : Ouvrir les options\nClic droit : Modifier les raccourcis";
SMARTDEBUFF_OFT_CLASSSORT       = "Liste de tri des classes";
SMARTDEBUFF_TT_CLASSSORT 	      = "Cliquez pour modifier l'ordre des classes";
SMARTDEBUFF_OFT_NOTREMOVABLE_LIST = "Liste des débuffs critiques";
SMARTDEBUFF_TT_NOTREMOVABLE_LIST 	= "Cliquez pour modifier la liste";
SMARTDEBUFF_OFT_SKILLS          = "Raccourcis souris";
SMARTDEBUFF_TT_SKILLS           = "Cliquez pour modifier les raccourcis\n(Clic G/D/M, avec Alt/Maj/Ctrl)";
SMARTDEBUFF_TT_RESET_SKILLS     = "Réinitialise les raccourcis pour votre classe";
SMARTDEBUFF_OFT_SHOWDEBUFFGUARD	= "Liste de suivi des sorts";
SMARTDEBUFF_TT_SHOWDEBUFFGUARD  = "Cliquez pour modifier\nla liste des sorts à suivre";
SMARTDEBUFF_TT_SOUNDLIST        = "Cliquez pour sélectionner le son.\n(Clic droit pour écouter uniquement)";

-- Tooltip support
SMARTDEBUFF_FUBAR_TT           = "\nClic gauche : Ouvrir les options\nMaj-Clic gauche : On/Off";
SMARTDEBUFF_BROKER_TT          = "Clic gauche : Ouvrir les options\nClic droit : On/Off";

SMARTDEBUFF_ERR_RELOADREQUIRED  = [[Un rechargement ( /reload ) pourrait être nécessaire pour faire fonctionner les clicks]];

--@do-not-package@
-- https://code.google.com/archive/p/mangadmin/wikis/SpecialCharacters.wiki
-- https://wowwiki.fandom.com/wiki/Localizing_an_addon
--@end-do-not-package@