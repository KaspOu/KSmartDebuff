-------------------------------------------------------------------------------
-- Italian localization (ChatGPT)
-------------------------------------------------------------------------------

SMARTDEBUFF_UPGRADED = "SmartDebuff aggiornato: "..SMARTDEBUFF_VERSION;

-- Creatures
SMARTDEBUFF_HUMANOID  = BATTLE_PET_NAME_1;
SMARTDEBUFF_DEMON     = PET_TYPE_DEMON;
SMARTDEBUFF_BEAST     = BATTLE_PET_NAME_8;
SMARTDEBUFF_ELEMENTAL = BATTLE_PET_NAME_7;
SMARTDEBUFF_IMP       = "Folletto";
SMARTDEBUFF_FELHUNTER = "Cacciatore Vil";
SMARTDEBUFF_DOOMGUARD = "Guardia Apocalittica";

-- Classes
SMARTDEBUFF_CLASSES = {["HPET"] = "Mascotte del Cacciatore", ["WPET"] = "Mascotte dello Stregone", ["DPET"] = "Mascotte del Cacciatore di Demoni"};
for _, class in ipairs(CLASS_SORT_ORDER) do SMARTDEBUFF_CLASSES[class] = LOCALIZED_CLASS_NAMES_MALE[class] end;


-- Bindings
BINDING_NAME_SMARTDEBUFF =  SMARTDEBUFF_TITLE.." Opzioni";

SMARTDEBUFF_KEY_L = "S";
SMARTDEBUFF_KEY_R = "D";
SMARTDEBUFF_KEY_M = "C";
SMARTDEBUFF_KEYS = {["L"]  = "Sinistra (S)",
                    ["R"]  = "Destra (D)",
                    ["M"]  = "Centrale (C)",
                    ["SL"] = "Maiusc Sinistra",
                    ["SR"] = "Maiusc Destra",
                    ["SM"] = "Maiusc Centrale",
                    ["AL"] = "Alt Sinistra",
                    ["AR"] = "Alt Destra",
                    ["AM"] = "Alt Centrale",
                    ["CL"] = "Ctrl Sinistra",
                    ["CR"] = "Ctrl Destra",
                    ["CM"] = "Ctrl Centrale"
                    };


-- Messages
SMARTDEBUFF_MSG_LOADED         = "caricato";
SMARTDEBUFF_MSG_SDB            = "Menu opzioni SmartDebuff";

-- Frame text
SMARTDEBUFF_FT_MODES           = "Tasti / Modalit\195\160";
SMARTDEBUFF_FT_MODENORMAL      = "Norm";
SMARTDEBUFF_FT_MODETARGET      = "Bers";


-- Options frame text
SMARTDEBUFF_OFT                = "Mostra/Nascondi opzioni SmartDebuff";
SMARTDEBUFF_OFT_HUNTERPETS     = "Mascotte del Cacciatore";
SMARTDEBUFF_OFT_WARLOCKPETS    = "Mascotte dello Stregone";
SMARTDEBUFF_OFT_DEATHKNIGHTPETS= "Mascotte del Cavaliere della Morte";
SMARTDEBUFF_OFT_HP             = "Vita";
SMARTDEBUFF_OFT_MANA           = "Mana";
SMARTDEBUFF_OFT_HPTEXT         = "%";
SMARTDEBUFF_OFT_INVERT         = "Inverti";
SMARTDEBUFF_OFT_CLASSVIEW      = "Ord per classe";
SMARTDEBUFF_OFT_CLASSCOLOR     = "Colori classe";
SMARTDEBUFF_OFT_SHOWLR         = "Mostra S / D / C";
SMARTDEBUFF_OFT_HEADERS        = "Intestazioni";
SMARTDEBUFF_OFT_GROUPNR        = "Numero gruppo";
SMARTDEBUFF_OFT_SOUND          = "Suono";
SMARTDEBUFF_OFT_TOOLTIP        = "Descrizione";
SMARTDEBUFF_OFT_TARGETMODE     = "Modalit\195\160 bersaglio";
SMARTDEBUFF_OFT_HEALRANGE      = "Raggio di cura";
SMARTDEBUFF_OFT_SHOWAGGRO      = "Aggro";
SMARTDEBUFF_OFT_VERTICAL       = "Disposizione verticale";
SMARTDEBUFF_OFT_VERTICALUP     = "Verticale verso l'alto";
SMARTDEBUFF_OFT_HEADERROW      = "Barra del titolo";
SMARTDEBUFF_OFT_BACKDROP       = "Sfondo";
SMARTDEBUFF_OFT_SHOWGRADIENT   = "Sfumatura";
SMARTDEBUFF_OFT_INFOFRAME      = "Riquadro riepilogativo";
SMARTDEBUFF_OFT_AUTOHIDE       = "Nascondi automaticamente";
SMARTDEBUFF_OFT_COLUMNS        = "Colonne";
SMARTDEBUFF_OFT_INTERVAL       = "Intervallo";
SMARTDEBUFF_OFT_FONTSIZE       = "Dimensione carattere";
SMARTDEBUFF_OFT_WIDTH          = "Larghezza";
SMARTDEBUFF_OFT_HEIGHT         = "Altezza";
SMARTDEBUFF_OFT_BARHEIGHT      = "Altezza barra";
SMARTDEBUFF_OFT_COLOR_LEFT     = "Debuff\nSinistra"
SMARTDEBUFF_OFT_COLOR_RIGHT    = "Debuff\nDestra"
SMARTDEBUFF_OFT_COLOR_MIDDLE   = "Debuff\nCentrale"
SMARTDEBUFF_OFT_COLOR_NOTREM   = "Debuff\nNon\nRimovibile"
SMARTDEBUFF_OFT_COLOR_UNIT     = "Pulsante\nUnit\195\160"
SMARTDEBUFF_OFT_COLOR_BACKDROP = "Sfondo\nCliccami"
SMARTDEBUFF_OFT_OPACITYNORMAL  = "Opacit\195\160 a portata";
SMARTDEBUFF_OFT_OPACITYOOR     = "Opacit\195\160 fuori portata";
SMARTDEBUFF_OFT_OPACITYDEBUFF  = "Opacit\195\160 dei debuff";
SMARTDEBUFF_OFT_NOTREMOVABLE   = "Debuff protetti";
SMARTDEBUFF_OFT_VEHICLE        = "Veicoli";
SMARTDEBUFF_OFT_SHOWRAIDICON   = "Icone raid";
SMARTDEBUFF_OFT_SHOWROLEICON   = "Icone ruolo (tank/heal)";
SMARTDEBUFF_OFT_SHOWROLEDPSICON = "Icone ruolo (dps)";
SMARTDEBUFF_OFT_SHOWSPELLICON  = "Icone incantesimi";
SMARTDEBUFF_OFT_INFOROW        = "Barra informazioni";
SMARTDEBUFF_OFT_GLOBALSAVE     = "Salva";
SMARTDEBUFF_OFT_GLOBALLOAD     = "Carica";
SMARTDEBUFF_OFT_RESET          = "Reset";
SMARTDEBUFF_OFT_ROLE           = "Ruolo";
SMARTDEBUFF_OFT_ADVANCHORS     = "Configura ancore";
SMARTDEBUFF_OFT_ICONSIZE       = "Dimensione icone";
SMARTDEBUFF_OFT_COLORSETUP     = "Configura colori";
SMARTDEBUFF_OFT_SPACEX         = "Spaziatura X";
SMARTDEBUFF_OFT_SPACEY         = "Spaziatura Y";
SMARTDEBUFF_OFT_TESTMODE       = "Modalit\195\160 test";
SMARTDEBUFF_OFT_STOPCAST       = "Interrompi lancio";
SMARTDEBUFF_OFT_IGNOREDEBUFF   = "Ignora debuff";
SMARTDEBUFF_OFT_CHATNOTIF      = "Notifiche chat";
SMARTDEBUFF_OFT_RESET_KEYS     = "Reimpostare gli incantesimi SmartDebuff ai valori predefiniti?\n\nQuesta azione \195\168 necessaria se ritieni che tutti i debuff non vengano rilevati correttamente.";
SMARTDEBUFF_AOFT_SORTBYCLASS   = "Ordine delle classi";
SMARTDEBUFF_NRDT_TITLE         = "Debuff non rimovibili";
SMARTDEBUFF_SG_TITLE           = "Incantesimi (HoT) tracciati";
SMARTDEBUFF_S_TITLE            = "Suono di avviso debuff";


-- Tooltip text
SMARTDEBUFF_TT                 = "Trascina il titolo con Maiusc-Clic sinistro: Sposta il riquadro\n|cff20d2ff- Pulsante S -|r\nClic sinistro: Mostra per classe, ruolo o gruppo\nMaiusc-Clic sinistro: Colori classe\nAlt-Clic sinistro: Evidenzia S/D/C\nClic destro: Sfondo";
SMARTDEBUFF_TT_TARGETMODE      = "In modalit\195\160 normale, |cff20d2ffClic sinistro|r rimuove il debuff dall'unit\195\160...\n \nIn modalit\195\160 bersaglio, |cff20d2ffClic sinistro|r seleziona l'unit\195\160,\nrimuovi il debuff con |cff20d2ffAlt-Clic|r\ne |cff20d2ffClic destro|r lancia l'incantesimo di cura pi\195\185 veloce.|r.";
SMARTDEBUFF_TT_NOTREMOVABLE    = "Mostra i debuff critici\nche non sono rimovibili.";
SMARTDEBUFF_TT_HP              = "Mostra i punti vita\nreali dell'unit\195\160.";
SMARTDEBUFF_TT_MANA            = "Mostra la barra mana\nreale dell'unit\195\160.";
SMARTDEBUFF_TT_HPTEXT          = "Mostra i punti vita/mana\nreali in percentuale\ndell'unit\195\160 come testo.";
SMARTDEBUFF_TT_INVERT          = "Mostra i punti vita\ne la barra mana invertiti.";
SMARTDEBUFF_TT_CLASSVIEW       = "Mostra i pulsanti unit\195\160\nordinati per classe.";
SMARTDEBUFF_TT_CLASSCOLOR      = "Mostra i pulsanti unit\195\160 nei\nrispettivi colori di classe.";
SMARTDEBUFF_TT_SHOWLR          = "Mostra il pulsante del mouse corrispondente (S/D/C)\nse un'unit\195\160 ha un debuff.";
SMARTDEBUFF_TT_HEADERS         = "Mostra il n\195\176 di gruppo / classe / ruolo\ncome intestazione.";
SMARTDEBUFF_TT_GROUPNR         = "Mostra il numero di gruppo\ndavanti al nome dell'unit\195\160.";
SMARTDEBUFF_TT_SOUND           = "Riproduce un suono se un'\nunit\195\160 riceve un debuff.";
SMARTDEBUFF_TT_TOOLTIP         = "Mostra la descrizione\nsolo fuori dal combattimento.";
SMARTDEBUFF_TT_HEALRANGE       = "Mostra un bordo rosso\nse il tuo incantesimo \195\168 fuori portata.";
SMARTDEBUFF_TT_SHOWAGGRO       = "Mostra quale\nunit\195\160 ha l'aggro.";
SMARTDEBUFF_TT_VERTICAL        = "Mostra le unit\195\160\ndisposte verticalmente.";
SMARTDEBUFF_TT_VERTICALUP      = "Mostra le unit\195\160\ndal basso verso l'alto.";
SMARTDEBUFF_TT_HEADERROW       = "Mostra la riga dell'intestazione,\ninclusi i pulsanti del menu.";
SMARTDEBUFF_TT_BACKDROP        = "Mostra un riquadro\ndi sfondo nero.";
SMARTDEBUFF_TT_SHOWGRADIENT    = "Mostra i pulsanti unit\195\160\ncon una sfumatura di colore.";
SMARTDEBUFF_TT_INFOFRAME       = "Mostra il riquadro riepilogativo\nsolo in configurazione di gruppo o raid.";
SMARTDEBUFF_TT_AUTOHIDE        = "Nasconde automaticamente i pulsanti\nunit\195\160 se sei fuori dal combattimento\ne nessuno ha un debuff.";
SMARTDEBUFF_TT_VEHICLE         = "Mostra anche il veicolo\ndi un'unit\195\160 come un pulsante separato.";
SMARTDEBUFF_TT_SHOWRAIDICON    = "Mostra l'icona del raid\ndell'unit\195\160.";
SMARTDEBUFF_TT_SHOWROLEICON    = "Mostra l'icona del ruolo di tank / heal.\n(se non c'\195\168 un'icona del raid)";
SMARTDEBUFF_TT_SHOWROLEDPSICON    = "Mostra l'icona del ruolo di dps.\n(se non c'\195\168 un'icona del raid)";
SMARTDEBUFF_TT_SHOWSPELLICON   = "Mostra le icone HoT\nsull'unit\195\160.";
SMARTDEBUFF_TT_INFOROW         = "Mostra una barra informazioni concisa (solo in raid) :\nGiocatori/Morti/AFK/Offline\nVita/Mana\nGiocatore pronto\n(solo in raid)";
SMARTDEBUFF_TT_GLOBALSAVE      = "Impostazioni salvate nel salvataggio globale.";
SMARTDEBUFF_TT_GLOBALLOAD      = "Impostazioni caricate dal salvataggio globale.";
SMARTDEBUFF_TT_ROLE            = "Mostra i pulsanti unit\195\160\nper ordine di ruolo.";
SMARTDEBUFF_TT_ADVANCHORS      = "Mostra e usa la configurazione\navanzata dei punti di ancoraggio\nper il riquadro dei debuff.";
SMARTDEBUFF_TT_STOPCAST        = "Interrompe immediatamente il\nlancio o la canalizzazione in\ncorso per lanciare l'incantesimo definito.\n(Solo per incantesimi di rimozione)";
SMARTDEBUFF_TT_IGNOREDEBUFF    = "Ignora il debuff sull'unit\195\160\nse il tuo incantesimo di rimozione \195\168 in ricarica";
SMARTDEBUFF_TT_CHATNOTIF       = "Mostra notifiche chat al caricamento";

--SMARTDEBUFF_TT_COLUMNS         = "Colonne";
--SMARTDEBUFF_TT_INTERVAL        = "Intervallo";
--SMARTDEBUFF_TT_FONTSIZE        = "Dimensione carattere";
--SMARTDEBUFF_TT_WIDTH           = "Larghezza";
--SMARTDEBUFF_TT_HEIGHT          = "Altezza";
--SMARTDEBUFF_TT_BARHEIGHT       = "Altezza barra";
--SMARTDEBUFF_TT_OPACITYNORMAL   = "Opacit\195\160 a portata";
--SMARTDEBUFF_TT_OPACITYOOR      = "Opacit\195\160 fuori portata";
--SMARTDEBUFF_TT_OPACITYDEBUFF   = "Opacit\195\160 debuff";

-- Tooltip text key bindings
SMARTDEBUFF_TT_DROP            = "Rilascia";
SMARTDEBUFF_TT_DROPINFO        = "Trascina qui un incantesimo/oggetto/macro dal tuo libro/inventario.\n|cff00ff00Clic sinistro per definire la funzione bersaglio.\nMaiusc-Clic sinistro per definire la funzione menu";
SMARTDEBUFF_TT_SPELLACTIONS    = "Clic sull'incantesimo :\n Sinistra per prendere\n Maiusc-Sinistra per clonare\n Destra per eliminare";
SMARTDEBUFF_TT_ITEMACTIONS     = "Clic sull'oggetto :\n Sinistra per prendere\n Maiusc-Sinistra per clonare\n Destra per eliminare";
SMARTDEBUFF_TT_MACROACTIONS    = "Clic sulla macro :\n Sinistra per prendere\n Maiusc-Sinistra per clonare\n Destra per eliminare";
SMARTDEBUFF_TT_TARGET          = "Bersaglio";
SMARTDEBUFF_TT_TARGETINFO      = "Seleziona l'unit\195\160 specificata\ncome bersaglio attuale.";
SMARTDEBUFF_TT_PETACTION       = "Azione mascotte";
SMARTDEBUFF_TT_NOTFOUND        = "Errore: Incantesimo non trovato";
SMARTDEBUFF_TT_MISSINGINFO     = "Verifica la tua Specializzazione / Talento / Mascotte.";
SMARTDEBUFF_TT_NOTMOVABLE      = "Impossibile spostare con la tua Specializzazione";
SMARTDEBUFF_TT_TARGETACTIONS   = "Clic del mouse :\n Destro per eliminare";
SMARTDEBUFF_TT_PETACTIONS      = "Azione mascotte :\nImpossibile eliminare!";
SMARTDEBUFF_TT_MENU            = "Menu";
SMARTDEBUFF_TT_MENUINFO        = "Apre il menu delle opzioni dell'unit\195\160.";
SMARTDEBUFF_TT_PICKMENU        = "Clic del mouse :\n Destro per eliminare";
SMARTDEBUFF_TT_DROPABBLE       = "Clic del mouse :\n Sinistra per rilasciare\n Destra per annullare";
SMARTDEBUFF_TT_DROPREPLACE     = "Clic del mouse :\n Sinistra per sostituire\n Destra per annullare";
SMARTDEBUFF_TT_DROPEXCHANGE    = "Clic del mouse :\n Sinistra per scambiare\n Destra per annullare";
SMARTDEBUFF_TT_CANTDROP        = "Clic del mouse :\n Destra per annullare";

SMARTDEBUFF_INFO_READY         = "Giocatori:\nVita %:\nMana %:\nMorti:\nAFK:\nOffline:\nPronti:";
SMARTDEBUFF_INFO               = "Giocatori:\nVita %:\nMana %:\nMorti:\nAFK:\nOffline";

--Tooltips added by Semi#1287
SMARTDEBUFF_TT_OPTIONS          = "|cff20d2ff- Pulsante O -|r\nClic sinistro: Apri opzioni\nClic destro: Modifica scorciatoie";
SMARTDEBUFF_OFT_CLASSSORT       = "Elenco ordinamento classi";
SMARTDEBUFF_TT_CLASSSORT 	      = "Clicca per modificare l'ordine delle classi";
SMARTDEBUFF_OFT_NOTREMOVABLE_LIST = "Elenco debuff protetti";
SMARTDEBUFF_TT_NOTREMOVABLE_LIST 	= "Clicca per modificare l'elenco";
SMARTDEBUFF_OFT_SKILLS          = "Scorciatoie mouse";
SMARTDEBUFF_TT_SKILLS           = "Clicca per modificare le scorciatoie\n(Clic S/D/C, con Alt/Maiusc/Ctrl)";
SMARTDEBUFF_TT_RESET_SKILLS     = "Reimposta le scorciatoie per la tua classe";
SMARTDEBUFF_OFT_SHOWDEBUFFGUARD	= "Elenco incantesimi tracciati";
SMARTDEBUFF_TT_SHOWDEBUFFGUARD  = "Clicca per modificare\nl'elenco degli incantesimi da tracciare";
SMARTDEBUFF_TT_SOUNDLIST        = "Clicca per selezionare il suono.\n(Clic destro solo per ascoltare)";

-- Tooltip support
SMARTDEBUFF_FUBAR_TT           = "\nClic sinistro: Apri opzioni\nMaiusc-Clic sinistro: On/Off";
SMARTDEBUFF_BROKER_TT          = "Clic sinistro: Apri opzioni\nClic destro: On/Off";

SMARTDEBUFF_ERR_RELOADREQUIRED  = [[Potrebbe essere necessario un ricaricamento ( /reload ) per far funzionare i click]];
