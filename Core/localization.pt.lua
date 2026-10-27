-------------------------------------------------------------------------------
-- Portuguese localization (ChatGPT)
-------------------------------------------------------------------------------
if KD_Settings and KD_Settings.ForceEnglish then return end;

SMARTDEBUFF_UPGRADED = "KDecurse atualizado: "..SMARTDEBUFF_VERSION;


-- Creatures
SMARTDEBUFF_HUMANOID  = BATTLE_PET_NAME_1;
SMARTDEBUFF_DEMON     = PET_TYPE_DEMON;
SMARTDEBUFF_BEAST     = BATTLE_PET_NAME_8;
SMARTDEBUFF_ELEMENTAL = BATTLE_PET_NAME_7;
SMARTDEBUFF_IMP       = "Diabrete";
SMARTDEBUFF_FELHUNTER = "Caçador Corrompido";
SMARTDEBUFF_DOOMGUARD = "Guarda Vil";

-- Classes
SMARTDEBUFF_CLASSES = {["HPET"] = "Mascote de Caçador", ["WPET"] = "Mascote de Bruxo", ["DPET"] = "Mascote de Caçador de Demônios"};
for _, class in ipairs(CLASS_SORT_ORDER) do SMARTDEBUFF_CLASSES[class] = LOCALIZED_CLASS_NAMES_MALE[class] end;


-- Bindings
BINDING_NAME_SMARTDEBUFF =  SMARTDEBUFF_TITLE.." Opçôes";

if not SMARTDEBUFF_Options.ForceLR then
    SMARTDEBUFF_KEY_L = "E";
    SMARTDEBUFF_KEY_R = "D";
    SMARTDEBUFF_KEY_M = "M";
end
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
SMARTDEBUFF_MSG_SDB            = "Menu de opçôes KDecurse";

-- Frame text
SMARTDEBUFF_FT_MODES           = "Teclas / Modos";
SMARTDEBUFF_FT_MODENORMAL      = "Norm";
SMARTDEBUFF_FT_MODETARGET      = "Alvo";


-- Options frame text
SMARTDEBUFF_OFT                = "Mostrar/Ocultar opçôes KDecurse";
SMARTDEBUFF_OFT_HUNTERPETS     = "Mascotes de Caçador";
SMARTDEBUFF_OFT_WARLOCKPETS    = "Mascotes de Bruxo";
SMARTDEBUFF_OFT_DEATHKNIGHTPETS= "Mascotes de Cavaleiro da Morte";
SMARTDEBUFF_OFT_HP             = "Vida";
SMARTDEBUFF_OFT_MANA           = "Mana";
SMARTDEBUFF_OFT_HPTEXT         = "%";
SMARTDEBUFF_OFT_INVERT         = "Inverter";
SMARTDEBUFF_OFT_SORT           = "Ordenar"
SMARTDEBUFF_OFT_CLASSVIEW      = "Ordenar por Classe";
SMARTDEBUFF_OFT_CLASSCOLOR     = "Cores de Classe";
SMARTDEBUFF_OFT_SHOWLR         = "Mostrar E / D / M";
SMARTDEBUFF_OFT_FORCELR        = "Forçar para L / R / M"
SMARTDEBUFF_OFT_HEADERS        = "Cabeçalhos";
SMARTDEBUFF_OFT_GROUPNR        = "Número do Grupo";
SMARTDEBUFF_OFT_SOUND          = "Som";
SMARTDEBUFF_OFT_TOOLTIP        = "Dica de Ferramenta";
SMARTDEBUFF_OFT_TARGETMODE     = "Modo Alvo";
SMARTDEBUFF_OFT_HEALRANGE      = "Alcance de Cura";
SMARTDEBUFF_OFT_SHOWAGGRO      = "Ameaça";
SMARTDEBUFF_OFT_VERTICAL       = "Disposiçôo Vertical";
SMARTDEBUFF_OFT_VERTICALUP     = "Vertical para Cima";
SMARTDEBUFF_OFT_HEADERROW      = "Barra de Título";
SMARTDEBUFF_OFT_BACKDROP       = "Plano de Fundo";
SMARTDEBUFF_OFT_SHOWGRADIENT   = "Gradiente";
SMARTDEBUFF_OFT_INFOFRAME      = "Quadro de Informaçôes";
SMARTDEBUFF_OFT_AUTOHIDE       = "Ocultar Automaticamente";
SMARTDEBUFF_OFT_COLUMNS        = "Colunas";
SMARTDEBUFF_OFT_COLTEXTURE     = "Textura de penalidade"
SMARTDEBUFF_OFT_COLTEXTURE     = "Textura"
SMARTDEBUFF_OFT_INTERVAL       = "Intervalo";
SMARTDEBUFF_OFT_FONTSIZE       = "Tamanho da Fonte";
SMARTDEBUFF_OFT_WIDTH          = "Largura";
SMARTDEBUFF_OFT_HEIGHT         = "Altura";
SMARTDEBUFF_OFT_BARHEIGHT      = "Altura da Barra";
SMARTDEBUFF_OFT_COLOR_LEFT     = "Debuff\nEsquerda"
SMARTDEBUFF_OFT_COLOR_RIGHT    = "Debuff\nDireita"
SMARTDEBUFF_OFT_COLOR_MIDDLE   = "Debuff\nMeio"
SMARTDEBUFF_OFT_COLOR_NOTREM   = "Debuff\nNôo\nRemovível"
SMARTDEBUFF_OFT_COLOR_UNIT     = "Botão\nde Unidade"
SMARTDEBUFF_OFT_COLOR_BACKDROP = "Plano de\nFundo\nClique-me"
SMARTDEBUFF_OFT_OPACITYNORMAL  = "Opacidade no alcance";
SMARTDEBUFF_OFT_OPACITYOOR     = "Opacidade fora do alcance";
SMARTDEBUFF_OFT_OPACITYDEBUFF  = "Opacidade dos debuffs";
SMARTDEBUFF_OFT_NOTREMOVABLE   = "Debuffs Protegidos";
SMARTDEBUFF_OFT_DEBUFFTOOLTIP  = "Dica de Ferramenta de Debuff";
SMARTDEBUFF_OFT_AURASPELLIDS   = "IDs de Feitiços de Aura";
SMARTDEBUFF_OFT_VEHICLE        = "Veículos";
SMARTDEBUFF_OFT_SHOWRAIDICON   = "ícones de Raide";
SMARTDEBUFF_OFT_SHOWROLEICON   = "ícones de Funçôo (tank/cura)";
SMARTDEBUFF_OFT_SHOWROLEDPSICON = "ícones de Funçôo (dps)";
SMARTDEBUFF_OFT_SHOWSPELLICON  = "ícones de Feitiços";
SMARTDEBUFF_OFT_INFOROW        = "Barra de Informaçôes";
SMARTDEBUFF_OFT_GLOBALSAVE     = "Salvar";
SMARTDEBUFF_OFT_GLOBALLOAD     = "Carregar";
SMARTDEBUFF_OFT_RESET          = "Redefinir";
SMARTDEBUFF_OFT_ROLE           = "Funçôo";
SMARTDEBUFF_OFT_ADVANCHORS     = "Configurar âncoras";
SMARTDEBUFF_OFT_ICONSIZE       = "Tamanho dos ícones";
SMARTDEBUFF_OFT_COLORSETUP     = "Configurar Cores";
SMARTDEBUFF_OFT_GRIDSETUP      = "Configurar grade";
SMARTDEBUFF_OFT_SPACEX         = "Espaçamento X";
SMARTDEBUFF_OFT_SPACEY         = "Espaçamento Y";
SMARTDEBUFF_OFT_TESTMODE       = "Modo Teste";
SMARTDEBUFF_OFT_STOPCAST       = "Interromper Feitiço";
SMARTDEBUFF_OFT_IGNOREDEBUFF   = "Ignorar em recarga";
SMARTDEBUFF_OFT_CHATNOTIF      = "Notificaçôes de Chat";
SMARTDEBUFF_OFT_ADDONCOMPARTMENT = "Compartimento de addons";
SMARTDEBUFF_OFT_RESET_KEYS     = "Redefinir os feitiços do KDecurse para o padrão?\n\nEsta açôo é necessária se você sentir que nem todos os debuffs estão sendo detectados corretamente.";
SMARTDEBUFF_AOFT_SORTBYCLASS   = "Ordem das Classes";
SMARTDEBUFF_NRDT_TITLE         = "Debuffs Nôo Removíveis";
SMARTDEBUFF_SG_TITLE           = "Feitiços (HoT) Monitorados";
SMARTDEBUFF_S_TITLE            = "Som de Alerta de Debuff";


-- Tooltip text
SMARTDEBUFF_TT                 = "Arraste o título com Shift-Clique Esquerdo: Move o quadro\n|cff20d2ff- Botão K -|r\nClique Esquerdo: Mostrar por classe, funçôo ou grupo\nShift-Clique Esquerdo: Cores de classe\nAlt-Clique Esquerdo: Destacar E/D/M\nClique Direito: Plano de Fundo";
SMARTDEBUFF_TT_TARGETMODE      = "No modo normal, |cff20d2ffClique Esquerdo|r remove o debuff da unidade...\n \nNo modo alvo, |cff20d2ffClique Esquerdo|r seleciona a unidade,\nremova o debuff com |cff20d2ffAlt-Clique|r\ne |cff20d2ffClique Direito|r lança o feitiço de cura mais rápido.|r.";
SMARTDEBUFF_TT_NOTREMOVABLE    = "Mostra debuffs críticos\nque nôo são removíveis.";
SMARTDEBUFF_TT_DEBUFFTOOLTIP   = "Mostra a descrição do debuff\nquando o mouse passa por cima.";
SMARTDEBUFF_TT_AURASPELLIDS    = "|cffffffffBlizzard:|r Mostra o ID do feitiço das auras\n(buffs e debuffs) nas dicas de ferramenta.";
SMARTDEBUFF_TT_HP              = "Mostra os pontos de vida\nreais da unidade.";
SMARTDEBUFF_TT_MANA            = "Mostra a barra de mana\nreal da unidade.";
SMARTDEBUFF_TT_HPTEXT          = "Mostra os pontos de vida/mana\nreais em porcentagem da\nunidade em texto.";
SMARTDEBUFF_TT_INVERT          = "Mostra os pontos de vida\ne a barra de mana invertidos.";
SMARTDEBUFF_TT_CLASSVIEW       = "Mostra os botães de unidade\nordenados por classe.";
SMARTDEBUFF_TT_CLASSCOLOR      = "Mostra os botães de unidade nas\nsuas respectivas cores de classe.";
SMARTDEBUFF_TT_SHOWLR          = "Mostra o botão do mouse correspondente (E/D/M)\nse uma unidade tiver um debuff.";
SMARTDEBUFF_TT_HEADERS         = "Mostra o número do grupo / classe / funçôo\ncomo cabeçalho.";
SMARTDEBUFF_TT_GROUPNR         = "Mostra o número do grupo\nna frente do nome da unidade.";
SMARTDEBUFF_TT_SOUND           = "Toca um som se uma\nunidade receber um debuff.";
SMARTDEBUFF_TT_TOOLTIP         = "Mostra a dica de ferramenta\nsomente fora de combate.";
SMARTDEBUFF_TT_HEALRANGE       = "Mostra uma borda vermelha\nse seu feitiço estiver fora de alcance.";
SMARTDEBUFF_TT_SHOWAGGRO       = "Mostra qual\nunidade tem o aggro.";
SMARTDEBUFF_TT_VERTICAL        = "Mostra as unidades\ndispostas verticalmente.";
SMARTDEBUFF_TT_VERTICALUP      = "Mostra as unidades\nde baixo para cima.";
SMARTDEBUFF_TT_HEADERROW       = "Mostra a linha do cabeçalho,\nincluindo os botães de menu.";
SMARTDEBUFF_TT_BACKDROP        = "Mostra um quadro\nde plano de fundo preto.";
SMARTDEBUFF_TT_SHOWGRADIENT    = "Mostra os botães de unidade\ncom um gradiente de cor.";
SMARTDEBUFF_TT_INFOFRAME       = "Mostra o quadro de informaçôes\nsomente em configuraçôo de grupo ou raide.";
SMARTDEBUFF_TT_AUTOHIDE        = "Oculta automaticamente os botães\nde unidade se você estiver fora de combate\ne ninguém tiver um debuff.";
SMARTDEBUFF_TT_VEHICLE         = "Também mostra o veículo\nde uma unidade como um botão separado.";
SMARTDEBUFF_TT_SHOWRAIDICON    = "Mostra o ícone de raide\nda unidade.";
SMARTDEBUFF_TT_SHOWROLEICON    = "Mostra o ícone de funçôo de tanks / curas.\n(se nôo houver ícone de raide)";
SMARTDEBUFF_TT_SHOWROLEDPSICON    = "Mostra o ícone de funçôo de dps.\n(se nôo houver ícone de raide)";
SMARTDEBUFF_TT_SHOWSPELLICON   = "Mostra os ícones de HoT\nnas unidades.";
SMARTDEBUFF_TT_INFOROW         = "Mostra uma barra de informaçôes concisa (somente em raide):\nJogadores/Mortos/AFK/Offline\nVida/Mana\nJogador pronto\n(somente em raide)";
SMARTDEBUFF_TT_GLOBALSAVE      = "Configuraçôes salvas no salvamento global.";
SMARTDEBUFF_TT_GLOBALLOAD      = "Configuraçôes carregadas do salvamento global.";
SMARTDEBUFF_TT_ROLE            = "Mostra os botães de unidade\npor ordem de funçôo.";
SMARTDEBUFF_TT_ADVANCHORS      = "Mostra e usa a configuraçôo\navançada dos pontos de âncora\npara o quadro de debuff.";
SMARTDEBUFF_TT_STOPCAST        = "Interrompe imediatamente o\nlançamento ou canalizaçôo em\nandamento para lançar o feitiço definido.\n(Somente para feitiços de remoçôo)";
SMARTDEBUFF_TT_IGNOREDEBUFF    = "Ignora o debuff na unidade\nse seu feitiço de remoçôo estiver em tempo de recarga";
SMARTDEBUFF_TT_CHATNOTIF       = "Mostra notificaçôes de chat ao carregar";
SMARTDEBUFF_TT_ADDONCOMPARTMENT = "Exibir no compartimento de addons (canto superior direito)"
SMARTDEBUFF_TT_RELOADREQUIRED   = "É necessário recarregar (digite /reload)"
SMARTDEBUFF_TT_DISABLED_VERSION  = "Esta opção não está disponível nesta versão do WoW."
SMARTDEBUFF_TT_DISABLED_BLIZZARD = "Esta opção não está mais disponível devido às limitações da Blizzard."
SMARTDEBUFF_TT_COLTEXTURE       = "Definir a textura do ícone\n(use o Modo de teste para visualizar)\n"

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
SMARTDEBUFF_TT_DROPINFO        = "Arraste aqui um feitiço/item/macro do seu livro/inventário.\n|cff00ff00Clique Esquerdo para definir a funçôo de alvo.\nShift-Clique Esquerdo para definir a funçôo de menu";
SMARTDEBUFF_TT_SPELLACTIONS    = "Clique no feitiço:\n Esquerdo para pegar\n Shift-Esquerdo para clonar\n Direito para excluir";
SMARTDEBUFF_TT_ITEMACTIONS     = "Clique no item:\n Esquerdo para pegar\n Shift-Esquerdo para clonar\n Direito para excluir";
SMARTDEBUFF_TT_MACROACTIONS    = "Clique na macro:\n Esquerdo para pegar\n Shift-Esquerdo para clonar\n Direito para excluir";
SMARTDEBUFF_TT_TARGET          = "Alvo";
SMARTDEBUFF_TT_TARGETINFO      = "Seleciona a unidade especificada\ncomo alvo atual.";
SMARTDEBUFF_TT_PETACTION       = "Açôo de Mascote";
SMARTDEBUFF_TT_NOTFOUND        = "Erro: Feitiço nôo encontrado";
SMARTDEBUFF_TT_MISSINGINFO     = "Verifique sua Especializaçôo / Talento / Mascote.";
SMARTDEBUFF_TT_NOTMOVABLE      = "Impossível mover com sua Especializaçôo";
SMARTDEBUFF_TT_TARGETACTIONS   = "Clique do mouse:\n Direito para excluir";
SMARTDEBUFF_TT_PETACTIONS      = "Açôo de Mascote:\nExclusão impossível!";
SMARTDEBUFF_TT_MENU            = "Menu";
SMARTDEBUFF_TT_MENUINFO        = "Abre o menu de opçôes da unidade.";
SMARTDEBUFF_TT_PICKMENU        = "Clique do mouse:\n Direito para excluir";
SMARTDEBUFF_TT_DROPABBLE       = "Clique do mouse:\n Esquerdo para soltar\n Direito para liberar";
SMARTDEBUFF_TT_DROPREPLACE     = "Clique do mouse:\n Esquerdo para substituir\n Direito para liberar";
SMARTDEBUFF_TT_DROPEXCHANGE    = "Clique do mouse:\n Esquerdo para trocar\n Direito para liberar";
SMARTDEBUFF_TT_CANTDROP        = "Clique do mouse:\n Direito para liberar";

SMARTDEBUFF_INFO_READY         = "Jogadores:\nPV %:\nMana %:\nMortos:\nAFK:\nOffline:\nProntos:";
SMARTDEBUFF_INFO               = "Jogadores:\nPV %:\nMana %:\nMortos:\nAFK:\nOffline";

--Tooltips added by Semi#1287
SMARTDEBUFF_TT_OPTIONS          = "|cff20d2ff- Botão O -|r\nClique Esquerdo: Abrir opçôes\nClique Direito: Editar atalhos";
SMARTDEBUFF_OFT_CLASSSORT       = "Lista de Ordem das Classes";
SMARTDEBUFF_TT_CLASSSORT 	      = "Clique para modificar a ordem das classes";
SMARTDEBUFF_OFT_NOTREMOVABLE_LIST = "Lista de Debuffs Protegidos";
SMARTDEBUFF_TT_NOTREMOVABLE_LIST 	= "Clique para modificar a lista";
SMARTDEBUFF_OFT_SKILLS          = "Atalhos do Mouse";
SMARTDEBUFF_TT_SKILLS           = "Clique para modificar os atalhos\n(Clique E/D/M, com Alt/Shift/Ctrl)";
SMARTDEBUFF_TT_RESET_SKILLS     = "Redefine os atalhos para sua classe";
SMARTDEBUFF_OFT_SHOWDEBUFFGUARD	= "Lista de Monitoramento de Feitiços";
SMARTDEBUFF_TT_SHOWDEBUFFGUARD  = "Clique para modificar\na lista de feitiços a monitorar";
SMARTDEBUFF_TT_SOUNDLIST        = "Clique para selecionar o som.\n(Clique Direito para apenas ouvir)";

-- Tooltip support
SMARTDEBUFF_FUBAR_TT           = "\nClique Esquerdo: Abrir opçôes\nShift-Clique Esquerdo: Ligar/Desligar";
SMARTDEBUFF_BROKER_TT          = "Clique Esquerdo: Abrir opçôes\nClique Direito: Ligar/Desligar";

SMARTDEBUFF_ERR_RELOADREQUIRED  = [[Um recarregamento ( /reload ) pode ser necessário para que os cliques funcionem]];
