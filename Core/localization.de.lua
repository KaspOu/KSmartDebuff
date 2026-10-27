-------------------------------------------------------------------------------
-- German localization
-------------------------------------------------------------------------------
if KD_Settings and KD_Settings.ForceEnglish then return end;

SMARTDEBUFF_UPGRADED = "KDecurse aktualisiert: "..SMARTDEBUFF_VERSION;

-- Creatures
SMARTDEBUFF_HUMANOID  = BATTLE_PET_NAME_1;
SMARTDEBUFF_DEMON     = PET_TYPE_DEMON;
SMARTDEBUFF_BEAST     = BATTLE_PET_NAME_8;
SMARTDEBUFF_ELEMENTAL = BATTLE_PET_NAME_7;
SMARTDEBUFF_IMP       = "Wichtel";
SMARTDEBUFF_FELHUNTER = "Teufelsjäger";
SMARTDEBUFF_DOOMGUARD = "Verdammniswache";

-- Classes
SMARTDEBUFF_CLASSES = { ["HPET"] = "Jäger Pet", ["WPET"] = "Hexer Pet", ["DPET"] = "Todesritter Pets"};
for _, class in ipairs(CLASS_SORT_ORDER) do SMARTDEBUFF_CLASSES[class] = LOCALIZED_CLASS_NAMES_MALE[class] end;

-- Bindings
BINDING_NAME_SMARTDEBUFF =  SMARTDEBUFF_TITLE.." Optionen";

if not SMARTDEBUFF_Options.ForceLR then
    SMARTDEBUFF_KEY_L = "L";
    SMARTDEBUFF_KEY_R = "R";
    SMARTDEBUFF_KEY_M = "M";
end
SMARTDEBUFF_KEYS = {["L"]  = "Links",
                    ["R"]  = "Rechts",
                    ["M"]  = "Mitte",
                    ["SL"] = "Shift links",
                    ["SR"] = "Shift rechts",
                    ["SM"] = "Shift mitte",
                    ["AL"] = "Alt links",
                    ["AR"] = "Alt rechts",
                    ["AM"] = "Alt mitte",
                    ["CL"] = "Strg links",
                    ["CR"] = "Strg rechts",
                    ["CM"] = "Strg mitte"
                    };


-- Messages
SMARTDEBUFF_MSG_LOADED         = "geladen";
SMARTDEBUFF_MSG_SDB            = "KDecurse Optionen";

-- Frame text
SMARTDEBUFF_FT_MODES           = "Tasten/Modus";
SMARTDEBUFF_FT_MODENORMAL      = "Norm";
SMARTDEBUFF_FT_MODETARGET      = "Ziel";


-- Options frame text
SMARTDEBUFF_OFT                = "Zeige/verberge KDecurse Optionen";
SMARTDEBUFF_OFT_HUNTERPETS     = "Jäger Pets";
SMARTDEBUFF_OFT_WARLOCKPETS    = "Hexer Pets";
SMARTDEBUFF_OFT_DEATHKNIGHTPETS= "Todesritter Pets";
SMARTDEBUFF_OFT_HP             = "HP";
SMARTDEBUFF_OFT_MANA           = "Mana";
SMARTDEBUFF_OFT_HPTEXT         = "%";
SMARTDEBUFF_OFT_INVERT         = "Invertiert";
SMARTDEBUFF_OFT_SORT           = "Sortierung"
SMARTDEBUFF_OFT_CLASSVIEW      = "Klassenansicht";
SMARTDEBUFF_OFT_CLASSCOLOR     = "Klassenfarben";
SMARTDEBUFF_OFT_SHOWLR         = "L / R / M";
SMARTDEBUFF_OFT_FORCELR        = ""
SMARTDEBUFF_OFT_HEADERS        = "Titel";
SMARTDEBUFF_OFT_GROUPNR        = "Gruppen Nr.";
SMARTDEBUFF_OFT_SOUND          = "Warnton";
SMARTDEBUFF_OFT_TOOLTIP        = "Tooltip";
SMARTDEBUFF_OFT_TARGETMODE     = "Ziel-Modus";
SMARTDEBUFF_OFT_HEALRANGE      = "Heil-Reichweite";
SMARTDEBUFF_OFT_SHOWAGGRO      = "Aggro";
SMARTDEBUFF_OFT_VERTICAL       = "Vertikal anordnen";
SMARTDEBUFF_OFT_VERTICALUP     = "Unten -> Oben";
SMARTDEBUFF_OFT_HEADERROW      = "Titelleiste";
SMARTDEBUFF_OFT_BACKDROP       = "Hintergrund";
SMARTDEBUFF_OFT_SHOWGRADIENT   = "Farbverlauf";
SMARTDEBUFF_OFT_INFOFRAME      = "Status-Fenster";
SMARTDEBUFF_OFT_AUTOHIDE       = "Auto. verbergen";
SMARTDEBUFF_OFT_COLUMNS        = "Spalten";
SMARTDEBUFF_OFT_COLTEXTURE     = "Debuff-Textur"
SMARTDEBUFF_OFT_COLTEXTURE     = "Textur"
SMARTDEBUFF_OFT_INTERVAL       = "Interval";
SMARTDEBUFF_OFT_FONTSIZE       = "Schriftgrösse";
SMARTDEBUFF_OFT_WIDTH          = "Breite";
SMARTDEBUFF_OFT_HEIGHT         = "Höhe";
SMARTDEBUFF_OFT_BARHEIGHT      = "Balkenhöhe";
SMARTDEBUFF_OFT_COLOR_LEFT     = "Debuff\nLinks"
SMARTDEBUFF_OFT_COLOR_RIGHT    = "Debuff\nRechts"
SMARTDEBUFF_OFT_COLOR_MIDDLE   = "Debuff\nMitte"
SMARTDEBUFF_OFT_COLOR_NOTREM   = "Nicht\nEntfernbarer\nDebuff"
SMARTDEBUFF_OFT_COLOR_UNIT     = "Einheiten\nKnopf"
SMARTDEBUFF_OFT_COLOR_BACKDROP = "Hintergrund\nKlick mich"
SMARTDEBUFF_OFT_OPACITYNORMAL  = "In Reichweite";
SMARTDEBUFF_OFT_OPACITYOOR     = "Ausser Reichweite";
SMARTDEBUFF_OFT_OPACITYDEBUFF  = "Debuff";
SMARTDEBUFF_OFT_NOTREMOVABLE   = "Debuff Wächter";
SMARTDEBUFF_OFT_DEBUFFTOOLTIP  = "Debuff Tooltip";
SMARTDEBUFF_OFT_AURASPELLIDS   = "Zeige Aura Zauber IDs";
SMARTDEBUFF_OFT_VEHICLE        = "Fahrzeuge";
SMARTDEBUFF_OFT_SHOWRAIDICON   = "Raidsymbole";
SMARTDEBUFF_OFT_SHOWROLEICON   = "Rollensymbole (Tank/Heiler)"; -- ChatGPT
SMARTDEBUFF_OFT_SHOWROLEDPSICON = "Rollensymbole (DPS)"; -- ChatGPT
SMARTDEBUFF_OFT_SHOWSPELLICON  = "HoT-Symbole";
SMARTDEBUFF_OFT_INFOROW        = "Info-Zeile";
SMARTDEBUFF_OFT_GLOBALSAVE     = "Speichern"; -- ChatGPT
SMARTDEBUFF_OFT_GLOBALLOAD     = "Laden"; -- ChatGPT
SMARTDEBUFF_OFT_RESET          = "Reset"; -- ChatGPT
SMARTDEBUFF_OFT_ROLE           = "Rolle";
SMARTDEBUFF_OFT_ADVANCHORS     = "Anker Setup";
SMARTDEBUFF_OFT_ICONSIZE       = "Symbolgrösse";
SMARTDEBUFF_OFT_COLORSETUP     = "Farbeinstellungen";
SMARTDEBUFF_OFT_GRIDSETUP      = "Raster konfigurieren";
SMARTDEBUFF_OFT_SPACEX         = "Abstand X";
SMARTDEBUFF_OFT_SPACEY         = "Abstand Y";
SMARTDEBUFF_OFT_TESTMODE       = "Test Modus";
SMARTDEBUFF_OFT_STOPCAST       = "Stoppe Zauber";
SMARTDEBUFF_OFT_IGNOREDEBUFF   = "Bei Abklingzeit ignorieren";
SMARTDEBUFF_OFT_CHATNOTIF      = "Chat-Benachrichtigungen"; -- ChatGPT
SMARTDEBUFF_OFT_ADDONCOMPARTMENT = "Addon-Fach";
SMARTDEBUFF_OFT_RESET_KEYS     = "Die KDecurse Zauber-Bindings zurücksetzen?\nDies ist nur nötig falls du das Gefühl hast,\ndass nicht alle Debuffs korrekt angezeigt werden.";
SMARTDEBUFF_AOFT_SORTBYCLASS   = "Klassenanordnung";
SMARTDEBUFF_NRDT_TITLE         = "Unentfernbare Debuffs";
SMARTDEBUFF_SG_TITLE           = "Zauber-Wächter";
SMARTDEBUFF_S_TITLE            = "Debuff Warnton";


-- Tooltip text
SMARTDEBUFF_TT                 = "Shift-Links ziehen: Fenster verschieben\n|cff20d2ff- K Knopf -|r\nLinks Klick: Ordne nach Klassen\nShift-Links Klick: Klassen-Farben\nAlt-Links Klick: Zeige L/R/M\nRechts Klick: Hintergrund";
SMARTDEBUFF_TT_TARGETMODE      = "Im Ziel-Modus wählt |cff20d2fflinks klick|r die Einheit aus\nund |cff20d2ffrechts klick|r zaubert den schnellsten Heilspruch.\n|cff20d2ffAlt-Links/Rechts klick|r wird zum Debuffen benutzt.";
SMARTDEBUFF_TT_NOTREMOVABLE    = "Zeigt kritische Debuffs an,\nauch wenn sie nicht entfernt\nwerden können.";
SMARTDEBUFF_TT_DEBUFFTOOLTIP   = "Zeigt die Debuff-Tooltip-Infos an,\nwenn man mit der Maus über den Knopf geht.";
SMARTDEBUFF_TT_AURASPELLIDS    = "|cffffffffBlizzard:|r Zeigt die Zauber-ID von Auren\n(Buffs und Debuffs) in den Tooltips an.";
SMARTDEBUFF_TT_HP              = "Zeigt die aktuellen Lebenspunkte\nder Einheit an.";
SMARTDEBUFF_TT_MANA            = "Zeigt das aktuelle Mana\nder Einheit an.";
SMARTDEBUFF_TT_HPTEXT          = "Zeigt die aktuellen Lebens-\nund Manapunkte der Einheit\nals Text in Prozent an.";
SMARTDEBUFF_TT_INVERT          = "Stellt die Lebenspunkte und\ndas Mana invertiert dar.";
SMARTDEBUFF_TT_CLASSVIEW       = "Stellt die Knöpfe nach\nKlasse sortiert dar.";
SMARTDEBUFF_TT_CLASSCOLOR      = "Stellt die Knöpfe in der\njeweiligen Klassenfarbe dar.";
SMARTDEBUFF_TT_SHOWLR          = "Zeigt den zugehörigen\nMausknopf (L/R/M)\nan, wenn jemand\neinen Debuff hat.";
SMARTDEBUFF_TT_HEADERS         = "Stellt den Klassennamen\nals Zeilentitel dar.";
SMARTDEBUFF_TT_GROUPNR         = "Blendet die Gruppennummer\nvor dem Spielernamen ein.";
SMARTDEBUFF_TT_SOUND           = "Spielt einen Ton ab, wenn\njemand einen Debuff bekommt.";
SMARTDEBUFF_TT_TOOLTIP         = "Zeigt Tooltip-Infos zum\njeweiligen Knopf an, nur\nausserhalb des Kampfes.";
SMARTDEBUFF_TT_HEALRANGE       = "Stellt einen roten Rahmen dar,\nwenn der Heil-Zauber ausser\nReichweite ist.";
SMARTDEBUFF_TT_SHOWAGGRO       = "Zeigt wer gerade\nAggro hat.";
SMARTDEBUFF_TT_VERTICAL        = "Stellt die Knöpfe vertikal\nangeordnet dar.";
SMARTDEBUFF_TT_VERTICALUP      = "Baut die Knöpfe vertikal\nvon unten nach oben auf.";
SMARTDEBUFF_TT_HEADERROW       = "Stellt die Titelzeile, inklusiv\nder Menü-Knöpfe dar.";
SMARTDEBUFF_TT_BACKDROP        = "Blendet einen schwarzen\nHintergrund ein.";
SMARTDEBUFF_TT_SHOWGRADIENT    = "Stellt die Knöpfe mit\neinem Farbverlauf dar.";
SMARTDEBUFF_TT_INFOFRAME       = "Blendet das Status-Fenster ein,\nnur in der Gruppe oder Raid.";
SMARTDEBUFF_TT_AUTOHIDE        = "Verbirgt die Knöpfe automatisch,\nwenn man nicht mehr im Kampf\nist und niemand einen Debuff hat.";
SMARTDEBUFF_TT_VEHICLE         = "Stellt zusätzlich das Fahrzeug der\nEinheit als eigener Knopf dar.";
SMARTDEBUFF_TT_SHOWRAIDICON    = "Stellt das Raidsymbol\nder Einheit dar.";
SMARTDEBUFF_TT_SHOWROLEICON    = "Zeigt das Rollensymbol für Tanks / Heiler an.\n(falls kein Raidsymbol vorhanden)"; -- ChatGPT
SMARTDEBUFF_TT_SHOWROLEDPSICON    = "Zeigt das Rollensymbol für DPS an.\n(falls kein Raidsymbol vorhanden)"; -- ChatGPT
SMARTDEBUFF_TT_SHOWSPELLICON   = "Stellt die Cast-Symbole\n(HoT-Icons) auf der Einheit dar.";
SMARTDEBUFF_TT_INFOROW         = "Zeigt in kurzform eine Infozeile #\nSpieler/Tot/AFK/Offline\nHP/Mana\nReady check Status\n(Nur im Raid)";
SMARTDEBUFF_TT_GLOBALSAVE      = "Einstellungen wurden global gespeichert."; -- ChatGPT
SMARTDEBUFF_TT_GLOBALLOAD      = "Einstellungen wurden global geladen."; -- ChatGPT
SMARTDEBUFF_TT_ROLE            = "Stellt die Knöpfe nach\nRolle sortiert dar.";
SMARTDEBUFF_TT_ADVANCHORS      = "Stellt dar und benutzt das\nerweiterte Anker-Setup\nfür das Debuff-Fenster.";
SMARTDEBUFF_TT_STOPCAST        = "Stoppt sofort den aktuellen\nZauber, um den definierten\nZauber benutzen zu können.\n(Nur Debuff-Zauber)";
SMARTDEBUFF_TT_IGNOREDEBUFF    = "Ignoriert den Debuff auf der Einheit\nwenn der Debuff-Zauber noch Cooldown hat.";
SMARTDEBUFF_TT_CHATNOTIF       = "Zeigt Chat-Benachrichtigungen beim Laden an."; -- ChatGPT
SMARTDEBUFF_TT_ADDONCOMPARTMENT = "Im Addon-Fach anzeigen (oben rechts)"
SMARTDEBUFF_TT_RELOADREQUIRED   = "Ein UI-Reload ist erforderlich (/reload eingeben)"
SMARTDEBUFF_TT_DISABLED_VERSION  = "Diese Option ist in dieser WoW-Version nicht verfügbar."
SMARTDEBUFF_TT_DISABLED_BLIZZARD = "Diese Option ist aufgrund von Einschränkungen durch Blizzard nicht mehr verfügbar."
SMARTDEBUFF_TT_COLTEXTURE       = "Symboltextur festlegen\n(Testmodus zum Vorschauen verwenden)\n"

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
SMARTDEBUFF_TT_DROP            = "Drop";
SMARTDEBUFF_TT_DROPINFO        = "Füge einen Zauber/Item/Makro\naus dem Buch/Inventar ein.\n|cff00ff00Mausklick\nLinks: Ziel-Funktion setzen\nShift-Links: Menü-Funktion setzen";
SMARTDEBUFF_TT_SPELLACTIONS    = "Zauber klick:\nLinks Aufnehmen\nShift-Links Kopieren\nRechts: Entfernen";
SMARTDEBUFF_TT_ITEMACTIONS     = "Item klick\nLinks: Aufnehmen\nShift-Links: Kopieren\nRechts: Entfernen";
SMARTDEBUFF_TT_MACROACTIONS    = "Makro klick\nLinks: Aufnehmen\nShift-Links: Kopieren\nRechts: Entfernen";
SMARTDEBUFF_TT_TARGET          = "Ziel";
SMARTDEBUFF_TT_TARGETINFO      = "Selektiert die gewählte Einheit\nund nimmt diese ins Ziel."; -- ChatGPT
SMARTDEBUFF_TT_PETACTION       = "Begleiter Zauber";
SMARTDEBUFF_TT_NOTFOUND        = "Fehler: Zauber nicht gefunden";
SMARTDEBUFF_TT_MISSINGINFO     = "Überprüfen Sie Ihre Spezialisierung / Talent / Begleiter.";
SMARTDEBUFF_TT_NOTMOVABLE      = "Mit Ihrer Spezialisierung nicht bewegbar";
SMARTDEBUFF_TT_TARGETACTIONS   = "Mausklick\nRechts: Entfernen";
SMARTDEBUFF_TT_PETACTIONS      = "Pet-Aktion:\nEntfernen nicht möglich!";
SMARTDEBUFF_TT_MENU            = "Menu";
SMARTDEBUFF_TT_MENUINFO        = "öffnet das Optionenmenü\nder Einheit.";
SMARTDEBUFF_TT_PICKMENU        = "Mausklick:\nRechts: Entfernen";
SMARTDEBUFF_TT_PICKMENU        = "Mausklick:\nRechts zum Entfernen";
SMARTDEBUFF_TT_DROPABBLE       = "Mausklick:\nLinks zum Ablegen\nRechts zum Freigeben";
SMARTDEBUFF_TT_DROPREPLACE     = "Mausklick:\nLinks zum Ersetzen\nRechts zum Freigeben";
SMARTDEBUFF_TT_DROPEXCHANGE    = "Mausklick:\nLinks zum Austauschen\nRechts zum Freigeben";
SMARTDEBUFF_TT_CANTDROP        = "Mausklick:\nRechts zum Freigeben";

SMARTDEBUFF_INFO_READY         = "Spieler:\nHP %:\nMana %:\nTote:\nAFK:\nOffline:\nBereit:"; -- ChatGPT
SMARTDEBUFF_INFO               = "Spieler:\nHP %:\nMana %:\nTote:\nAFK:\nOffline"; -- ChatGPT

--Tooltips added by Semi#1287
SMARTDEBUFF_TT_OPTIONS		   		= "|cff20d2ff- O Knopf -|r\nLinks Klick: Optionen öffnen\nRechts Klick: Tastenkürzel bearbeiten"; -- ChatGPT
SMARTDEBUFF_OFT_CLASSSORT       = "Klassen-Sortierliste"; -- ChatGPT
SMARTDEBUFF_TT_CLASSSORT 	      = "Klicken, um die Klassenreihenfolge zu ändern"; -- ChatGPT
SMARTDEBUFF_OFT_NOTREMOVABLE_LIST = "Liste der geschützten Debuffs"; -- ChatGPT
SMARTDEBUFF_TT_NOTREMOVABLE_LIST 	= "Klicken, um die Liste zu bearbeiten"; -- ChatGPT
SMARTDEBUFF_OFT_SKILLS          = "Maus-Verknüpfungen"; -- ChatGPT
SMARTDEBUFF_TT_SKILLS           = "Klicken, um die Tastenkürzel zu bearbeiten\n(Klick L/R/M, mit Alt/Shift/Strg)"; -- ChatGPT
SMARTDEBUFF_TT_RESET_SKILLS     = "Setzt die Tastenkürzel für Ihre Klasse zurück"; -- ChatGPT
SMARTDEBUFF_OFT_SHOWDEBUFFGUARD	= "Zauber-Verfolgungsliste"; -- ChatGPT
SMARTDEBUFF_TT_SHOWDEBUFFGUARD  = "Klicken, um die Liste der zu verfolgenden Zauber zu bearbeiten"; -- ChatGPT
SMARTDEBUFF_TT_SOUNDLIST        = "Klicken, um den Sound auszuwählen.\n(Rechtsklick nur zum Anhören)"; -- ChatGPT

-- Tooltip support
SMARTDEBUFF_FUBAR_TT           = "\nLinks Klick: Optionen Menü\nShift-Links Klick: An/Aus";
SMARTDEBUFF_BROKER_TT          = "\nLinks Klick: Optionen Menü\nRechts Klick: An/Aus";

SMARTDEBUFF_ERR_RELOADREQUIRED  = [[Ein Neuladen ( /reload ) könnte erforderlich sein, damit die Klicks funktionieren]]; -- ChatGPT
