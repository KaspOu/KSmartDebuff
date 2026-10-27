-------------------------------------------------------------------------------
-- Spanish localization
-------------------------------------------------------------------------------

SMARTDEBUFF_UPGRADED = "KDecurse actualizado: "..SMARTDEBUFF_VERSION;

-- Creatures
SMARTDEBUFF_HUMANOID  = BATTLE_PET_NAME_1;
SMARTDEBUFF_DEMON     = PET_TYPE_DEMON;
SMARTDEBUFF_BEAST     = BATTLE_PET_NAME_8;
SMARTDEBUFF_ELEMENTAL = BATTLE_PET_NAME_7;
SMARTDEBUFF_IMP       = "Diablillo";
SMARTDEBUFF_FELHUNTER = "Manáfago";
SMARTDEBUFF_DOOMGUARD = "Guardia apocalíptico";

-- Classes
SMARTDEBUFF_CLASSES = {["HPET"] = "Mascota de cazador", ["WPET"] = "Mascota de Brujo", ["DPET"] = "Mascota de Caballero de la Muerte"};
for _, class in ipairs(CLASS_SORT_ORDER) do SMARTDEBUFF_CLASSES[class] = LOCALIZED_CLASS_NAMES_MALE[class] end;

-- Bindings
BINDING_NAME_SMARTDEBUFF =  SMARTDEBUFF_TITLE.." Opciones";
if not SMARTDEBUFF_Options.ForceLR then
    SMARTDEBUFF_KEY_L = "I";
    SMARTDEBUFF_KEY_R = "D";
    SMARTDEBUFF_KEY_M = "M";
end
SMARTDEBUFF_KEYS = {["L"]  = "Izquierda (I)",
                    ["R"]  = "Derecha (D)",
                    ["M"]  = "Medio (M)",
                    ["SL"] = "Shift izquierda",
                    ["SR"] = "Shift derecha",
                    ["SM"] = "Shift medio",
                    ["AL"] = "Alt izquierda",
                    ["AR"] = "Alt derecha",
                    ["AM"] = "Alt medio",
                    ["CL"] = "Ctrl izquierda",
                    ["CR"] = "Ctrl derecha",
                    ["CM"] = "Ctrl medio"
                    };


-- Messages
SMARTDEBUFF_MSG_LOADED         = "cargado";
SMARTDEBUFF_MSG_SDB            = "Marco de opciones de KDecurse";

-- Frame text
SMARTDEBUFF_FT_MODES           = "Teclas/Modos";
SMARTDEBUFF_FT_MODENORMAL      = "Norm";
SMARTDEBUFF_FT_MODETARGET      = "Objet";


-- Options frame text
SMARTDEBUFF_OFT                = "Mostrar/ocultar Marco de opciones de KDecurse";
SMARTDEBUFF_OFT_HUNTERPETS     = "Mascotas de cazador";
SMARTDEBUFF_OFT_WARLOCKPETS    = "Mascotas de brujo";
SMARTDEBUFF_OFT_DEATHKNIGHTPETS= "Mascotas de Caballero de la Muerte";
SMARTDEBUFF_OFT_HP             = "Vida";
SMARTDEBUFF_OFT_MANA           = "Maná";
SMARTDEBUFF_OFT_HPTEXT         = "%";
SMARTDEBUFF_OFT_INVERT         = "Invertir";
SMARTDEBUFF_OFT_SORT           = "Ordenar"
SMARTDEBUFF_OFT_CLASSVIEW      = "Ver clases";
SMARTDEBUFF_OFT_CLASSCOLOR     = "Colores de clases";
SMARTDEBUFF_OFT_SHOWLR         = "I / D / M";
SMARTDEBUFF_OFT_FORCELR        = "Forzar a L / R / M"
SMARTDEBUFF_OFT_HEADERS        = "Encabezados";
SMARTDEBUFF_OFT_GROUPNR        = "Nú de grupo";
SMARTDEBUFF_OFT_SOUND          = "Sonido";
SMARTDEBUFF_OFT_TOOLTIP        = "Ayuda visual";
SMARTDEBUFF_OFT_TARGETMODE     = "Modo objetivo";
SMARTDEBUFF_OFT_HEALRANGE      = "Rango de cura";
SMARTDEBUFF_OFT_SHOWAGGRO      = "Aggro";
SMARTDEBUFF_OFT_VERTICAL       = "Orden vertical";
SMARTDEBUFF_OFT_VERTICALUP     = "Vertical arriba";
SMARTDEBUFF_OFT_HEADERROW      = "Encabezado de fila, con botones";
SMARTDEBUFF_OFT_BACKDROP       = "Mostrar fondo";
SMARTDEBUFF_OFT_SHOWGRADIENT   = "Gradiente";
SMARTDEBUFF_OFT_INFOFRAME      = "Mostrar marco de sumario";
SMARTDEBUFF_OFT_AUTOHIDE       = "Auto ocultar";
SMARTDEBUFF_OFT_COLUMNS        = "Columnas";
SMARTDEBUFF_OFT_COLTEXTURE     = "Textura de perjuicio"
SMARTDEBUFF_OFT_COLTEXTURE     = "Textura"
SMARTDEBUFF_OFT_INTERVAL       = "Intervalo";
SMARTDEBUFF_OFT_FONTSIZE       = "Tamaño de fuente";
SMARTDEBUFF_OFT_WIDTH          = "Ancho";
SMARTDEBUFF_OFT_HEIGHT         = "Alto";
SMARTDEBUFF_OFT_BARHEIGHT      = "Barra alto";
SMARTDEBUFF_OFT_COLOR_LEFT     = "Perjuicio\nIzquierda"
SMARTDEBUFF_OFT_COLOR_RIGHT    = "Perjuicio\nDerecha"
SMARTDEBUFF_OFT_COLOR_MIDDLE   = "Perjuicio\nMedio"
SMARTDEBUFF_OFT_COLOR_NOTREM   = "Perjuicio\nNo\nDisipable"
SMARTDEBUFF_OFT_COLOR_UNIT     = "Botón\nde\nUnidad"
SMARTDEBUFF_OFT_COLOR_BACKDROP = "Fondo\nHaz clic"
SMARTDEBUFF_OFT_OPACITYNORMAL  = "Opacidad en rango";
SMARTDEBUFF_OFT_OPACITYOOR     = "Opacidad fuera de rango";
SMARTDEBUFF_OFT_OPACITYDEBUFF  = "Opacidad al quitar debuff";
SMARTDEBUFF_OFT_NOTREMOVABLE   = "Protección de Debuffs";
SMARTDEBUFF_OFT_DEBUFFTOOLTIP  = "Descripción emergente de debuffs";
SMARTDEBUFF_OFT_AURASPELLIDS   = "ID de hechizo de auras";
SMARTDEBUFF_OFT_VEHICLE        = "Vehículo";
SMARTDEBUFF_OFT_SHOWRAIDICON   = "Banda signo";
SMARTDEBUFF_OFT_SHOWROLEICON   = "Iconos de rol (tanq/san)"; -- ChatGPT
SMARTDEBUFF_OFT_SHOWROLEDPSICON = "Iconos de rol (dps)"; -- ChatGPT
SMARTDEBUFF_OFT_SHOWSPELLICON  = "Iconos de hechizos"; -- ChatGPT
SMARTDEBUFF_OFT_INFOROW        = "Barra de información"; -- ChatGPT
SMARTDEBUFF_OFT_GLOBALSAVE     = "Guardar"; -- ChatGPT
SMARTDEBUFF_OFT_GLOBALLOAD     = "Cargar"; -- ChatGPT
SMARTDEBUFF_OFT_RESET          = "Reiniciar"; -- ChatGPT
SMARTDEBUFF_OFT_ROLE           = "Rol"; -- ChatGPT
SMARTDEBUFF_OFT_ADVANCHORS     = "Configurar anclajes"; -- ChatGPT
SMARTDEBUFF_OFT_ICONSIZE       = "Tamaño de iconos"; -- ChatGPT
SMARTDEBUFF_OFT_COLORSETUP     = "Configurar colores"; -- ChatGPT
SMARTDEBUFF_OFT_GRIDSETUP      = "Configurar cuadrícula";
SMARTDEBUFF_OFT_SPACEX         = "Espaciado X"; -- ChatGPT
SMARTDEBUFF_OFT_SPACEY         = "Espaciado Y"; -- ChatGPT
SMARTDEBUFF_OFT_TESTMODE       = "Modo prueba"; -- ChatGPT
SMARTDEBUFF_OFT_STOPCAST       = "Interrumpir lanzamiento"; -- ChatGPT
SMARTDEBUFF_OFT_IGNOREDEBUFF   = "Ignorar en reutilización"; -- ChatGPT
SMARTDEBUFF_OFT_CHATNOTIF      = "Notificaciones de chat"; -- ChatGPT
SMARTDEBUFF_OFT_RESET_KEYS     = "Reiniciar hechizos de KDecurse a los valores predeterminados?\n\nEsta acción es necesaria si sientes que no todos los perjuicios se detectan correctamente."; -- ChatGPT
SMARTDEBUFF_AOFT_SORTBYCLASS   = "Ordenar por orden de clase";
SMARTDEBUFF_NRDT_TITLE         = "Debuffs irremovibles";
SMARTDEBUFF_SG_TITLE           = "Hechizos (HoT) seguidos"; -- ChatGPT
SMARTDEBUFF_S_TITLE            = "Debuff alarma tono";


-- Tooltip text
SMARTDEBUFF_TT                 = "Mayúsculas-arrastrar izquierdo: Mover marco\n|cff20d2ff- K botón -|r\nClick Izquierdo: Mostrar por clases\nMayúscuals-Click Izquierdo: Colores de clase\nAlt-Click izquierdo: Destacar I/D/M\nClick derecho: Fondo";
SMARTDEBUFF_TT_TARGETMODE      = "En modo objetivo |cff20d2ffClick izquierdo|r selecciona la unidad\ny |cff20d2ffClick derecho|r lanza el hechizo más rápido de curación.\nUsar |cff20d2ffAlt-Click derecho/izquierdo|r para debuff.";
SMARTDEBUFF_TT_NOTREMOVABLE    = "Muestra debuffs críticos\nque no son removibles.";
SMARTDEBUFF_TT_DEBUFFTOOLTIP   = "Muestra la descripción emergente de los debuffs\nal pasar el ratón por encima.";
SMARTDEBUFF_TT_AURASPELLIDS    = "|cffffffffBlizzard:|r Muestra la ID de hechizo de las auras\n(buff y debuff) en la descripción emergente.";
SMARTDEBUFF_TT_HP              = "Muestra los puntos de salud\nactuales de la unidad.";
SMARTDEBUFF_TT_MANA            = "Muestra la cantidad de mana\nactual de la unidad.";
SMARTDEBUFF_TT_HPTEXT          = "Muestra la cantidad de hp/mana\nactual como porcentaje de\nla unidad en texto.";
SMARTDEBUFF_TT_INVERT          = "Muestra los puntos de salud\ny el mana de forma invertida.";
SMARTDEBUFF_TT_CLASSVIEW       = "Muestra los botones de unidad\nordenados por clase.";
SMARTDEBUFF_TT_CLASSCOLOR      = "Muestra los botones de unidad en\nlos colores correspondientes a su clase.";
SMARTDEBUFF_TT_SHOWLR          = "Muestra el botón del mouse correspondiente\n(I/D/M), si una unidad tiene un debuff.";
SMARTDEBUFF_TT_HEADERS         = "Muestra el nombre de la clase\ncomo fila de encabezado.";
SMARTDEBUFF_TT_GROUPNR         = "Muestra el número de grupo\nfrente al nombre de la unidad.";
SMARTDEBUFF_TT_SOUND           = "Reproduce un sonido, si una\nunidad recibe un debuff.";
SMARTDEBUFF_TT_TOOLTIP         = "Muestra la descripción emergente,\nsolo fuera de combate.";
SMARTDEBUFF_TT_HEALRANGE       = "Muestra un borde rojo,\nsi tu hechizo está fuera de alcance.";
SMARTDEBUFF_TT_SHOWAGGRO       = "Muestra qué\nunidad tiene aggro.";
SMARTDEBUFF_TT_VERTICAL        = "Muestra las unidades\norganizadas verticalmente.";
SMARTDEBUFF_TT_VERTICALUP      = "Muestra las unidades\nde abajo hacia arriba.";
SMARTDEBUFF_TT_HEADERROW       = "Muestra la fila de encabezado,\nincluyendo los botones de menú.";
SMARTDEBUFF_TT_BACKDROP        = "Muestra un marco de\nfondo negro.";
SMARTDEBUFF_TT_SHOWGRADIENT    = "Muestra los botones de unidad\ncon gradiente de color.";
SMARTDEBUFF_TT_INFOFRAME       = "Muestra el marco de resumen,\nsolo en configuración de grupo o raid.";
SMARTDEBUFF_TT_AUTOHIDE        = "Oculta automáticamente los botones de unidad,\nsi estás fuera de combate y\nnadie tiene un debuff.";
SMARTDEBUFF_TT_VEHICLE         = "Muestra además el vehículo de\nla unidad como su propio botón.";
SMARTDEBUFF_TT_SHOWRAIDICON    = "Muestra el icono de raid\nde la unidad.";
SMARTDEBUFF_TT_SHOWROLEICON    = "Muestra el icono de rol de tanques / sanadores.\n(si no hay icono de banda)"; -- ChatGPT
SMARTDEBUFF_TT_SHOWROLEDPSICON = "Muestra el icono de rol de dps.\n(si no hay icono de banda)"; -- ChatGPT
SMARTDEBUFF_TT_SHOWSPELLICON   = "Muestra los iconos de HoT\nen la unidad."; -- ChatGPT
SMARTDEBUFF_TT_INFOROW         = "Muestra una barra de información concisa (solo en banda):\nJugadores/Muertos/AFK/Desconectados\nVida/Maná\nJugador listo\n(solo en banda)"; -- ChatGPT
SMARTDEBUFF_TT_GLOBALSAVE      = "Configuración guardada en la configuración global."; -- ChatGPT
SMARTDEBUFF_TT_GLOBALLOAD      = "Configuración cargada desde la configuración global."; -- ChatGPT
SMARTDEBUFF_TT_ROLE            = "Muestra los botones de unidad\npor orden de rol."; -- ChatGPT
SMARTDEBUFF_TT_ADVANCHORS      = "Muestra y usa la configuración\navanzada de puntos de anclaje\npara el marco de perjuicios."; -- ChatGPT
SMARTDEBUFF_TT_STOPCAST        = "Interrumpe inmediatamente el\nlanzamiento o canalización en\ncurso para lanzar el hechizo definido.\n(Solo para hechizos de disipación)"; -- ChatGPT
SMARTDEBUFF_TT_IGNOREDEBUFF    = "Ignora el perjuicio en la unidad\nsi tu hechizo de disipación está en tiempo de reutilización"; -- ChatGPT
SMARTDEBUFF_TT_CHATNOTIF       = "Muestra notificaciones de chat al cargar"; -- ChatGPT
SMARTDEBUFF_TT_RELOADREQUIRED   = "Se requiere recargar la interfaz (escribe /reload)"
SMARTDEBUFF_TT_DISABLED_VERSION  = "Esta opción no está disponible en esta versión de WoW."
SMARTDEBUFF_TT_DISABLED_BLIZZARD = "Esta opción ya no está disponible debido a las limitaciones de Blizzard."
SMARTDEBUFF_TT_COLTEXTURE       = "Establecer la textura del icono\n(usa el modo de prueba para previsualizar)\n"

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
SMARTDEBUFF_TT_DROP            = "Soltar"; -- ChatGPT
SMARTDEBUFF_TT_DROPINFO        = "Arrastra aquí un hechizo/objeto/macro de tu libro/inventario.\n|cff00ff00Clic izquierdo para establecer la función de objetivo.\nShift-Clic izquierdo para establecer la función de menú"; -- ChatGPT
SMARTDEBUFF_TT_SPELLACTIONS    = "Clic en el hechizo:\n Izquierdo para recoger\n Shift-Izquierdo para clonar\n Derecho para eliminar"; -- ChatGPT
SMARTDEBUFF_TT_ITEMACTIONS     = "Clic en el objeto:\n Izquierdo para recoger\n Shift-Izquierdo para clonar\n Derecho para eliminar"; -- ChatGPT
SMARTDEBUFF_TT_MACROACTIONS    = "Clic en la macro:\n Izquierdo para recoger\n Shift-Izquierdo para clonar\n Derecho para eliminar"; -- ChatGPT
SMARTDEBUFF_TT_TARGET          = "Objetivo"; -- ChatGPT
SMARTDEBUFF_TT_TARGETINFO      = "Selecciona la unidad especificada\ncomo objetivo actual."; -- ChatGPT
SMARTDEBUFF_TT_PETACTION       = "Acción de mascota"; -- ChatGPT
SMARTDEBUFF_TT_NOTFOUND        = "Error: Hechizo no encontrado"; -- ChatGPT
SMARTDEBUFF_TT_MISSINGINFO     = "Verifica tu Especialización / Talento / Mascota."; -- ChatGPT
SMARTDEBUFF_TT_NOTMOVABLE      = "Imposible de mover con tu Especialización"; -- ChatGPT
SMARTDEBUFF_TT_TARGETACTIONS   = "Clic del ratón:\n Derecho para eliminar"; -- ChatGPT
SMARTDEBUFF_TT_PETACTIONS      = "Acción de mascota:\n¡Imposible eliminar!"; -- ChatGPT
SMARTDEBUFF_TT_MENU            = "Menú"; -- ChatGPT
SMARTDEBUFF_TT_MENUINFO        = "Abre el menú de opciones de la unidad."; -- ChatGPT
SMARTDEBUFF_TT_PICKMENU        = "Clic del ratón:\n Derecho para eliminar"; -- ChatGPT
SMARTDEBUFF_TT_DROPABBLE       = "Clic del ratón:\n Izquierdo para soltar\n Derecho para liberar"; -- ChatGPT
SMARTDEBUFF_TT_DROPREPLACE     = "Clic del ratón:\n Izquierdo para reemplazar\n Derecho para liberar"; -- ChatGPT
SMARTDEBUFF_TT_DROPEXCHANGE    = "Clic del ratón:\n Izquierdo para intercambiar\n Derecho para liberar"; -- ChatGPT
SMARTDEBUFF_TT_CANTDROP        = "Clic del ratón:\n Derecho para liberar"; -- ChatGPT

--Tooltips added by Semi#1287
SMARTDEBUFF_TT_OPTIONS          = "|cff20d2ff- Botón O -|r\nClic izquierdo: Abrir opciones\nClic derecho: Editar atajos"; -- ChatGPT
SMARTDEBUFF_OFT_CLASSSORT       = "Lista de ordenación de clases"; -- ChatGPT
SMARTDEBUFF_TT_CLASSSORT 	      = "Clic para editar el orden de las clases"; -- ChatGPT
SMARTDEBUFF_OFT_NOTREMOVABLE_LIST = "Lista de perjuicios protegidos"; -- ChatGPT
SMARTDEBUFF_TT_NOTREMOVABLE_LIST 	= "Clic para editar la lista"; -- ChatGPT
SMARTDEBUFF_OFT_SKILLS          = "Atajos de ratón"; -- ChatGPT
SMARTDEBUFF_TT_SKILLS           = "Clic para editar los atajos\n(Clic I/D/M, con Alt/Shift/Ctrl)"; -- ChatGPT
SMARTDEBUFF_TT_RESET_SKILLS     = "Reinicia los atajos para tu clase"; -- ChatGPT
SMARTDEBUFF_OFT_SHOWDEBUFFGUARD	= "Lista de seguimiento de hechizos"; -- ChatGPT
SMARTDEBUFF_TT_SHOWDEBUFFGUARD  = "Clic para editar\nla lista de hechizos a seguir"; -- ChatGPT
SMARTDEBUFF_TT_SOUNDLIST        = "Clic para seleccionar el sonido.\n(Clic derecho solo para escuchar)"; -- ChatGPT

SMARTDEBUFF_INFO_READY         = "Jugadores:\nVida %:\nManá %:\nMuertos:\nAFK:\nDesc.:\nListos:";
SMARTDEBUFF_INFO               = "Jugadores:\nVida %:\nManá %:\nMuertos:\nAFK:\nDesc.";

-- Tooltip support
SMARTDEBUFF_FUBAR_TT           = "\nClick izquierdo: Abrir opciones\nMayúsulas-Click izquierdo: On/Off"; -- ChatGPT
SMARTDEBUFF_BROKER_TT          = "\nClick izquierdo: Abrir opciones\nClick derecho: On/Off"; -- ChatGPT

SMARTDEBUFF_ERR_RELOADREQUIRED  = [[Una recarga ( /reload ) podría ser necesaria para que los clics funcionen]]; -- ChatGPT
