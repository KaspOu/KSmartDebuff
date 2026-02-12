-------------------------------------------------------------------------------
-- Portuguese localization (ChatGPT)
-------------------------------------------------------------------------------

SMARTDEBUFF_UPGRADED = "SmartDebuff atualizado: "..SMARTDEBUFF_VERSION;


-- Creatures
SMARTDEBUFF_HUMANOID  = BATTLE_PET_NAME_1;
SMARTDEBUFF_DEMON     = PET_TYPE_DEMON;
SMARTDEBUFF_BEAST     = BATTLE_PET_NAME_8;
SMARTDEBUFF_ELEMENTAL = BATTLE_PET_NAME_7;
SMARTDEBUFF_IMP       = "Diabrete";
SMARTDEBUFF_FELHUNTER = "Ca\195\167ador Corrompido";
SMARTDEBUFF_DOOMGUARD = "Guarda Vil";

-- Classes
SMARTDEBUFF_CLASSES = {["HPET"] = "Mascote de Ca\195\167ador", ["WPET"] = "Mascote de Bruxo", ["DPET"] = "Mascote de Ca\195\167ador de Dem\195\180nios"};
for _, class in ipairs(CLASS_SORT_ORDER) do SMARTDEBUFF_CLASSES[class] = LOCALIZED_CLASS_NAMES_MALE[class] end;


-- Bindings
BINDING_NAME_SMARTDEBUFF =  SMARTDEBUFF_TITLE.." Op\195\167\195\180es";

SMARTDEBUFF_KEY_L = "E";
SMARTDEBUFF_KEY_R = "D";
SMARTDEBUFF_KEY_M = "M";
SMARTDEBUFF_KEYS = {["L"]  = "Esquerda (E)",
                    ["R"]  = "Direita (D)",
                    ["M"]  = "Meio (M)",
                    ["SL"] = "Shift Esquerda",
                    ["SR"] = "Shift Direita",
                    ["SM"] = "Shift Meio",
                    ["AL"] = "Alt Esquerda",
                    ["AR"] = "Alt Direita",
                    ["AM"] = "Alt Meio",
                    ["CL"] = "Ctrl Esquerda",
                    ["CR"] = "Ctrl Direita",
                    ["CM"] = "Ctrl Meio"
                    };


-- Messages
SMARTDEBUFF_MSG_LOADED         = "carregado";
SMARTDEBUFF_MSG_SDB            = "Menu de op\195\167\195\180es SmartDebuff";

-- Frame text
SMARTDEBUFF_FT_MODES           = "Teclas / Modos";
SMARTDEBUFF_FT_MODENORMAL      = "Norm";
SMARTDEBUFF_FT_MODETARGET      = "Alvo";


-- Options frame text
SMARTDEBUFF_OFT                = "Mostrar/Ocultar op\195\167\195\180es SmartDebuff";
SMARTDEBUFF_OFT_HUNTERPETS     = "Mascotes de Ca\195\167ador";
SMARTDEBUFF_OFT_WARLOCKPETS    = "Mascotes de Bruxo";
SMARTDEBUFF_OFT_DEATHKNIGHTPETS= "Mascotes de Cavaleiro da Morte";
SMARTDEBUFF_OFT_HP             = "Vida";
SMARTDEBUFF_OFT_MANA           = "Mana";
SMARTDEBUFF_OFT_HPTEXT         = "%";
SMARTDEBUFF_OFT_INVERT         = "Inverter";
SMARTDEBUFF_OFT_CLASSVIEW      = "Ordenar por Classe";
SMARTDEBUFF_OFT_CLASSCOLOR     = "Cores de Classe";
SMARTDEBUFF_OFT_SHOWLR         = "Mostrar E / D / M";
SMARTDEBUFF_OFT_HEADERS        = "Cabe\195\167alhos";
SMARTDEBUFF_OFT_GROUPNR        = "N\195\186mero do Grupo";
SMARTDEBUFF_OFT_SOUND          = "Som";
SMARTDEBUFF_OFT_TOOLTIP        = "Dica de Ferramenta";
SMARTDEBUFF_OFT_TARGETMODE     = "Modo Alvo";
SMARTDEBUFF_OFT_HEALRANGE      = "Alcance de Cura";
SMARTDEBUFF_OFT_SHOWAGGRO      = "Amea\195\167a";
SMARTDEBUFF_OFT_VERTICAL       = "Disposi\195\167\195\180o Vertical";
SMARTDEBUFF_OFT_VERTICALUP     = "Vertical para Cima";
SMARTDEBUFF_OFT_HEADERROW      = "Barra de T\195\173tulo";
SMARTDEBUFF_OFT_BACKDROP       = "Plano de Fundo";
SMARTDEBUFF_OFT_SHOWGRADIENT   = "Gradiente";
SMARTDEBUFF_OFT_INFOFRAME      = "Quadro de Informa\195\167\195\180es";
SMARTDEBUFF_OFT_AUTOHIDE       = "Ocultar Automaticamente";
SMARTDEBUFF_OFT_COLUMNS        = "Colunas";
SMARTDEBUFF_OFT_INTERVAL       = "Intervalo";
SMARTDEBUFF_OFT_FONTSIZE       = "Tamanho da Fonte";
SMARTDEBUFF_OFT_WIDTH          = "Largura";
SMARTDEBUFF_OFT_HEIGHT         = "Altura";
SMARTDEBUFF_OFT_BARHEIGHT      = "Altura da Barra";
SMARTDEBUFF_OFT_COLOR_LEFT     = "Debuff\nEsquerda"
SMARTDEBUFF_OFT_COLOR_RIGHT    = "Debuff\nDireita"
SMARTDEBUFF_OFT_COLOR_MIDDLE   = "Debuff\nMeio"
SMARTDEBUFF_OFT_COLOR_NOTREM   = "Debuff\nN\195\180o\nRemov\195\173vel"
SMARTDEBUFF_OFT_COLOR_UNIT     = "Bot\195\163o\nde Unidade"
SMARTDEBUFF_OFT_COLOR_BACKDROP = "Plano de\nFundo\nClique-me"
SMARTDEBUFF_OFT_OPACITYNORMAL  = "Opacidade no alcance";
SMARTDEBUFF_OFT_OPACITYOOR     = "Opacidade fora do alcance";
SMARTDEBUFF_OFT_OPACITYDEBUFF  = "Opacidade dos debuffs";
SMARTDEBUFF_OFT_NOTREMOVABLE   = "Debuffs Protegidos";
SMARTDEBUFF_OFT_VEHICLE        = "Ve\195\173culos";
SMARTDEBUFF_OFT_SHOWRAIDICON   = "\195\173cones de Raide";
SMARTDEBUFF_OFT_SHOWROLEICON   = "\195\173cones de Fun\195\167\195\180o (tank/cura)";
SMARTDEBUFF_OFT_SHOWROLEDPSICON = "\195\173cones de Fun\195\167\195\180o (dps)";
SMARTDEBUFF_OFT_SHOWSPELLICON  = "\195\173cones de Feiti\195\167os";
SMARTDEBUFF_OFT_INFOROW        = "Barra de Informa\195\167\195\180es";
SMARTDEBUFF_OFT_GLOBALSAVE     = "Salvar";
SMARTDEBUFF_OFT_GLOBALLOAD     = "Carregar";
SMARTDEBUFF_OFT_RESET          = "Redefinir";
SMARTDEBUFF_OFT_ROLE           = "Fun\195\167\195\180o";
SMARTDEBUFF_OFT_ADVANCHORS     = "Configurar \195\162ncoras";
SMARTDEBUFF_OFT_ICONSIZE       = "Tamanho dos \195\173cones";
SMARTDEBUFF_OFT_COLORSETUP     = "Configurar Cores";
SMARTDEBUFF_OFT_SPACEX         = "Espa\195\167amento X";
SMARTDEBUFF_OFT_SPACEY         = "Espa\195\167amento Y";
SMARTDEBUFF_OFT_TESTMODE       = "Modo de Teste";
SMARTDEBUFF_OFT_STOPCAST       = "Interromper Feiti\195\167o";
SMARTDEBUFF_OFT_IGNOREDEBUFF   = "Ignorar Debuffs";
SMARTDEBUFF_OFT_CHATNOTIF      = "Notifica\195\167\195\180es de Chat";
SMARTDEBUFF_OFT_RESET_KEYS     = "Redefinir os feiti\195\167os do SmartDebuff para o padr\195\163o?\n\nEsta a\195\167\195\180o \195\169 necess\195\161ria se voc\195\170 sentir que nem todos os debuffs est\195\163o sendo detectados corretamente.";
SMARTDEBUFF_AOFT_SORTBYCLASS   = "Ordem das Classes";
SMARTDEBUFF_NRDT_TITLE         = "Debuffs N\195\180o Remov\195\173veis";
SMARTDEBUFF_SG_TITLE           = "Feiti\195\167os (HoT) Monitorados";
SMARTDEBUFF_S_TITLE            = "Som de Alerta de Debuff";


-- Tooltip text
SMARTDEBUFF_TT                 = "Arraste o t\195\173tulo com Shift-Clique Esquerdo: Move o quadro\n|cff20d2ff- Bot\195\163o S -|r\nClique Esquerdo: Mostrar por classe, fun\195\167\195\180o ou grupo\nShift-Clique Esquerdo: Cores de classe\nAlt-Clique Esquerdo: Destacar E/D/M\nClique Direito: Plano de Fundo";
SMARTDEBUFF_TT_TARGETMODE      = "No modo normal, |cff20d2ffClique Esquerdo|r remove o debuff da unidade...\n \nNo modo alvo, |cff20d2ffClique Esquerdo|r seleciona a unidade,\nremova o debuff com |cff20d2ffAlt-Clique|r\ne |cff20d2ffClique Direito|r lan\195\167a o feiti\195\167o de cura mais r\195\161pido.|r.";
SMARTDEBUFF_TT_NOTREMOVABLE    = "Mostra debuffs cr\195\173ticos\nque n\195\180o s\195\163o remov\195\173veis.";
SMARTDEBUFF_TT_HP              = "Mostra os pontos de vida\nreais da unidade.";
SMARTDEBUFF_TT_MANA            = "Mostra a barra de mana\nreal da unidade.";
SMARTDEBUFF_TT_HPTEXT          = "Mostra os pontos de vida/mana\nreais em porcentagem da\nunidade em texto.";
SMARTDEBUFF_TT_INVERT          = "Mostra os pontos de vida\ne a barra de mana invertidos.";
SMARTDEBUFF_TT_CLASSVIEW       = "Mostra os bot\195\163es de unidade\nordenados por classe.";
SMARTDEBUFF_TT_CLASSCOLOR      = "Mostra os bot\195\163es de unidade nas\nsuas respectivas cores de classe.";
SMARTDEBUFF_TT_SHOWLR          = "Mostra o bot\195\163o do mouse correspondente (E/D/M)\nse uma unidade tiver um debuff.";
SMARTDEBUFF_TT_HEADERS         = "Mostra o n\195\186mero do grupo / classe / fun\195\167\195\180o\ncomo cabe\195\167alho.";
SMARTDEBUFF_TT_GROUPNR         = "Mostra o n\195\186mero do grupo\nna frente do nome da unidade.";
SMARTDEBUFF_TT_SOUND           = "Toca um som se uma\nunidade receber um debuff.";
SMARTDEBUFF_TT_TOOLTIP         = "Mostra a dica de ferramenta\nsomente fora de combate.";
SMARTDEBUFF_TT_HEALRANGE       = "Mostra uma borda vermelha\nse seu feiti\195\167o estiver fora de alcance.";
SMARTDEBUFF_TT_SHOWAGGRO       = "Mostra qual\nunidade tem o aggro.";
SMARTDEBUFF_TT_VERTICAL        = "Mostra as unidades\ndispostas verticalmente.";
SMARTDEBUFF_TT_VERTICALUP      = "Mostra as unidades\nde baixo para cima.";
SMARTDEBUFF_TT_HEADERROW       = "Mostra a linha do cabe\195\167alho,\nincluindo os bot\195\163es de menu.";
SMARTDEBUFF_TT_BACKDROP        = "Mostra um quadro\nde plano de fundo preto.";
SMARTDEBUFF_TT_SHOWGRADIENT    = "Mostra os bot\195\163es de unidade\ncom um gradiente de cor.";
SMARTDEBUFF_TT_INFOFRAME       = "Mostra o quadro de informa\195\167\195\180es\nsomente em configura\195\167\195\180o de grupo ou raide.";
SMARTDEBUFF_TT_AUTOHIDE        = "Oculta automaticamente os bot\195\163es\nde unidade se voc\195\170 estiver fora de combate\ne ningu\195\169m tiver um debuff.";
SMARTDEBUFF_TT_VEHICLE         = "Tamb\195\169m mostra o ve\195\173culo\nde uma unidade como um bot\195\163o separado.";
SMARTDEBUFF_TT_SHOWRAIDICON    = "Mostra o \195\173cone de raide\nda unidade.";
SMARTDEBUFF_TT_SHOWROLEICON    = "Mostra o \195\173cone de fun\195\167\195\180o de tanks / curas.\n(se n\195\180o houver \195\173cone de raide)";
SMARTDEBUFF_TT_SHOWROLEDPSICON    = "Mostra o \195\173cone de fun\195\167\195\180o de dps.\n(se n\195\180o houver \195\173cone de raide)";
SMARTDEBUFF_TT_SHOWSPELLICON   = "Mostra os \195\173cones de HoT\nnas unidades.";
SMARTDEBUFF_TT_INFOROW         = "Mostra uma barra de informa\195\167\195\180es concisa (somente em raide):\nJogadores/Mortos/AFK/Offline\nVida/Mana\nJogador pronto\n(somente em raide)";
SMARTDEBUFF_TT_GLOBALSAVE      = "Configura\195\167\195\180es salvas no salvamento global.";
SMARTDEBUFF_TT_GLOBALLOAD      = "Configura\195\167\195\180es carregadas do salvamento global.";
SMARTDEBUFF_TT_ROLE            = "Mostra os bot\195\163es de unidade\npor ordem de fun\195\167\195\180o.";
SMARTDEBUFF_TT_ADVANCHORS      = "Mostra e usa a configura\195\167\195\180o\navan\195\167ada dos pontos de \195\162ncora\npara o quadro de debuff.";
SMARTDEBUFF_TT_STOPCAST        = "Interrompe imediatamente o\nlan\195\167amento ou canaliza\195\167\195\180o em\nandamento para lan\195\167ar o feiti\195\167o definido.\n(Somente para feiti\195\167os de remo\195\167\195\180o)";
SMARTDEBUFF_TT_IGNOREDEBUFF    = "Ignora o debuff na unidade\nse seu feiti\195\167o de remo\195\167\195\180o estiver em tempo de recarga";
SMARTDEBUFF_TT_CHATNOTIF       = "Mostra notifica\195\167\195\180es de chat ao carregar";

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
SMARTDEBUFF_TT_DROP            = "Soltar";
SMARTDEBUFF_TT_DROPINFO        = "Arraste aqui um feiti\195\167o/item/macro do seu livro/invent\195\161rio.\n|cff00ff00Clique Esquerdo para definir a fun\195\167\195\180o de alvo.\nShift-Clique Esquerdo para definir a fun\195\167\195\180o de menu";
SMARTDEBUFF_TT_SPELLACTIONS    = "Clique no feiti\195\167o:\n Esquerdo para pegar\n Shift-Esquerdo para clonar\n Direito para excluir";
SMARTDEBUFF_TT_ITEMACTIONS     = "Clique no item:\n Esquerdo para pegar\n Shift-Esquerdo para clonar\n Direito para excluir";
SMARTDEBUFF_TT_MACROACTIONS    = "Clique na macro:\n Esquerdo para pegar\n Shift-Esquerdo para clonar\n Direito para excluir";
SMARTDEBUFF_TT_TARGET          = "Alvo";
SMARTDEBUFF_TT_TARGETINFO      = "Seleciona a unidade especificada\ncomo alvo atual.";
SMARTDEBUFF_TT_PETACTION       = "A\195\167\195\180o de Mascote";
SMARTDEBUFF_TT_NOTFOUND        = "Erro: Feiti\195\167o n\195\180o encontrado";
SMARTDEBUFF_TT_MISSINGINFO     = "Verifique sua Especializa\195\167\195\180o / Talento / Mascote.";
SMARTDEBUFF_TT_NOTMOVABLE      = "Imposs\195\173vel mover com sua Especializa\195\167\195\180o";
SMARTDEBUFF_TT_TARGETACTIONS   = "Clique do mouse:\n Direito para excluir";
SMARTDEBUFF_TT_PETACTIONS      = "A\195\167\195\180o de Mascote:\nExclus\195\163o imposs\195\173vel!";
SMARTDEBUFF_TT_MENU            = "Menu";
SMARTDEBUFF_TT_MENUINFO        = "Abre o menu de op\195\167\195\180es da unidade.";
SMARTDEBUFF_TT_PICKMENU        = "Clique do mouse:\n Direito para excluir";
SMARTDEBUFF_TT_DROPABBLE       = "Clique do mouse:\n Esquerdo para soltar\n Direito para liberar";
SMARTDEBUFF_TT_DROPREPLACE     = "Clique do mouse:\n Esquerdo para substituir\n Direito para liberar";
SMARTDEBUFF_TT_DROPEXCHANGE    = "Clique do mouse:\n Esquerdo para trocar\n Direito para liberar";
SMARTDEBUFF_TT_CANTDROP        = "Clique do mouse:\n Direito para liberar";

SMARTDEBUFF_INFO_READY         = "Jogadores:\nPV %:\nMana %:\nMortos:\nAFK:\nOffline:\nProntos:";
SMARTDEBUFF_INFO               = "Jogadores:\nPV %:\nMana %:\nMortos:\nAFK:\nOffline";

--Tooltips added by Semi#1287
SMARTDEBUFF_TT_OPTIONS          = "|cff20d2ff- Bot\195\163o O -|r\nClique Esquerdo: Abrir op\195\167\195\180es\nClique Direito: Editar atalhos";
SMARTDEBUFF_OFT_CLASSSORT       = "Lista de Ordem das Classes";
SMARTDEBUFF_TT_CLASSSORT 	      = "Clique para modificar a ordem das classes";
SMARTDEBUFF_OFT_NOTREMOVABLE_LIST = "Lista de Debuffs Protegidos";
SMARTDEBUFF_TT_NOTREMOVABLE_LIST 	= "Clique para modificar a lista";
SMARTDEBUFF_OFT_SKILLS          = "Atalhos do Mouse";
SMARTDEBUFF_TT_SKILLS           = "Clique para modificar os atalhos\n(Clique E/D/M, com Alt/Shift/Ctrl)";
SMARTDEBUFF_TT_RESET_SKILLS     = "Redefine os atalhos para sua classe";
SMARTDEBUFF_OFT_SHOWDEBUFFGUARD	= "Lista de Monitoramento de Feiti\195\167os";
SMARTDEBUFF_TT_SHOWDEBUFFGUARD  = "Clique para modificar\na lista de feiti\195\167os a monitorar";
SMARTDEBUFF_TT_SOUNDLIST        = "Clique para selecionar o som.\n(Clique Direito para apenas ouvir)";

-- Tooltip support
SMARTDEBUFF_FUBAR_TT           = "\nClique Esquerdo: Abrir op\195\167\195\180es\nShift-Clique Esquerdo: Ligar/Desligar";
SMARTDEBUFF_BROKER_TT          = "Clique Esquerdo: Abrir op\195\167\195\180es\nClique Direito: Ligar/Desligar";

SMARTDEBUFF_ERR_RELOADREQUIRED  = [[Um recarregamento ( /reload ) pode ser necess\195\161rio para que os cliques funcionem]];
