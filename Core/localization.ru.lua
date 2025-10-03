-------------------------------------------------------------------------------
-- Russian localization (ChatGPT)
-------------------------------------------------------------------------------

if (GetLocale() ~= "ruRU") then return end

SMARTDEBUFF_UPGRADED = "SmartDebuff обновлен: "..SMARTDEBUFF_VERSION;

-- Creatures
SMARTDEBUFF_HUMANOID  = BATTLE_PET_NAME_1;
SMARTDEBUFF_DEMON     = PET_TYPE_DEMON;
SMARTDEBUFF_BEAST     = BATTLE_PET_NAME_8;
SMARTDEBUFF_ELEMENTAL = BATTLE_PET_NAME_7;
SMARTDEBUFF_IMP       = "Бес";
SMARTDEBUFF_FELHUNTER = "Охотник Скверны";
SMARTDEBUFF_DOOMGUARD = "Страж ужаса";

-- Classes
SMARTDEBUFF_CLASSES = {["HPET"] = "Питомец Охотника", ["WPET"] = "Питомец Чернокнижника", ["DPET"] = "Питомец Рыцаря Смерти"};
for _, class in ipairs(CLASS_SORT_ORDER) do SMARTDEBUFF_CLASSES[class] = LOCALIZED_CLASS_NAMES_MALE[class] end;


-- Bindings
BINDING_NAME_SMARTDEBUFF =  SMARTDEBUFF_TITLE.." Настройки";

SMARTDEBUFF_KEY_L = "Л";
SMARTDEBUFF_KEY_R = "П";
SMARTDEBUFF_KEY_M = "С";
SMARTDEBUFF_KEYS = {["L"]  = "Левая (Л)",
                    ["R"]  = "Правая (П)",
                    ["M"]  = "Средняя (С)",
                    ["SL"] = "Shift левая",
                    ["SR"] = "Shift правая",
                    ["SM"] = "Shift средняя",
                    ["AL"] = "Alt левая",
                    ["AR"] = "Alt правая",
                    ["AM"] = "Alt средняя",
                    ["CL"] = "Ctrl левая",
                    ["CR"] = "Ctrl правая",
                    ["CM"] = "Ctrl средняя"
                    };


-- Messages
SMARTDEBUFF_MSG_LOADED         = "загружен";
SMARTDEBUFF_MSG_SDB            = "Меню настроек SmartDebuff";

-- Frame text
SMARTDEBUFF_FT_MODES           = "Клавиши / Режимы";
SMARTDEBUFF_FT_MODENORMAL      = "Норм";
SMARTDEBUFF_FT_MODETARGET      = "Цель";


-- Options frame text
SMARTDEBUFF_OFT                = "Показать/Скрыть настройки SmartDebuff";
SMARTDEBUFF_OFT_HUNTERPETS     = "Питомец Охотника";
SMARTDEBUFF_OFT_WARLOCKPETS    = "Питомец Чернокнижника";
SMARTDEBUFF_OFT_DEATHKNIGHTPETS= "Питомец Рыцаря Смерти";
SMARTDEBUFF_OFT_HP             = "Здоровье";
SMARTDEBUFF_OFT_MANA           = "Мана";
SMARTDEBUFF_OFT_HPTEXT         = "%";
SMARTDEBUFF_OFT_INVERT         = "Инвертировать";
SMARTDEBUFF_OFT_CLASSVIEW      = "Сортировка по классу";
SMARTDEBUFF_OFT_CLASSCOLOR     = "Цвета классов";
SMARTDEBUFF_OFT_SHOWLR         = "Показать Л / П / С";
SMARTDEBUFF_OFT_HEADERS        = "Заголовки";
SMARTDEBUFF_OFT_GROUPNR        = "Номер группы";
SMARTDEBUFF_OFT_SOUND          = "Звук";
SMARTDEBUFF_OFT_TOOLTIP        = "Подсказка";
SMARTDEBUFF_OFT_TARGETMODE     = "Режим цели";
SMARTDEBUFF_OFT_HEALRANGE      = "Радиус исцеления";
SMARTDEBUFF_OFT_SHOWAGGRO      = "Агро";
SMARTDEBUFF_OFT_VERTICAL       = "Вертикальное расположение";
SMARTDEBUFF_OFT_VERTICALUP     = "Вертикально вверх";
SMARTDEBUFF_OFT_HEADERROW      = "Строка заголовка";
SMARTDEBUFF_OFT_BACKDROP       = "Фон";
SMARTDEBUFF_OFT_SHOWGRADIENT   = "Градиент";
SMARTDEBUFF_OFT_INFOFRAME      = "Информационная рамка";
SMARTDEBUFF_OFT_AUTOHIDE       = "Автоматическое скрытие";
SMARTDEBUFF_OFT_COLUMNS        = "Столбцы";
SMARTDEBUFF_OFT_INTERVAL       = "Интервал";
SMARTDEBUFF_OFT_FONTSIZE       = "Размер шрифта";
SMARTDEBUFF_OFT_WIDTH          = "Ширина";
SMARTDEBUFF_OFT_HEIGHT         = "Высота";
SMARTDEBUFF_OFT_BARHEIGHT      = "Высота полосы";
SMARTDEBUFF_OFT_OPACITYNORMAL  = "Прозрачность в радиусе";
SMARTDEBUFF_OFT_OPACITYOOR     = "Прозрачность вне радиуса";
SMARTDEBUFF_OFT_OPACITYDEBUFF  = "Прозрачность дебаффов";
SMARTDEBUFF_OFT_NOTREMOVABLE   = "Защищенные дебаффы";
SMARTDEBUFF_OFT_VEHICLE        = "Транспорт";
SMARTDEBUFF_OFT_SHOWRAIDICON   = "Иконки рейда";
SMARTDEBUFF_OFT_SHOWROLEICON   = "Иконки роли (танк/хил)";
SMARTDEBUFF_OFT_SHOWROLEDPSICON = "Иконки роли (дпс)";
SMARTDEBUFF_OFT_SHOWSPELLICON  = "Иконка заклинания";
SMARTDEBUFF_OFT_INFOROW        = "Информационная строка";
SMARTDEBUFF_OFT_GLOBALSAVE     = "Сохранить";
SMARTDEBUFF_OFT_GLOBALLOAD     = "Загрузить";
SMARTDEBUFF_OFT_RESET          = "Сброс";
SMARTDEBUFF_OFT_ROLE           = "Роль";
SMARTDEBUFF_OFT_ADVANCHORS     = "Настроить привязки";
SMARTDEBUFF_OFT_ICONSIZE       = "Размер иконок";
SMARTDEBUFF_OFT_COLORSETUP     = "Настроить цвета";
SMARTDEBUFF_OFT_SPACEX         = "Отступ по X";
SMARTDEBUFF_OFT_SPACEY         = "Отступ по Y";
SMARTDEBUFF_OFT_TESTMODE       = "Тест. реж.";
SMARTDEBUFF_OFT_STOPCAST       = "Прерывание заклинания";
SMARTDEBUFF_OFT_IGNOREDEBUFF   = "Игнорировать дебаффы";
SMARTDEBUFF_OFT_CHATNOTIF      = "Уведомления в чате";
SMARTDEBUFF_OFT_RESET_KEYS     = "Сбросить заклинания SmartDebuff по умолчанию?\n\nЭто действие необходимо, если вы считаете, что не все дебаффы определяются корректно.";
SMARTDEBUFF_AOFT_SORTBYCLASS   = "Порядок классов";
SMARTDEBUFF_NRDT_TITLE         = "Неснимаемые дебаффы";
SMARTDEBUFF_SG_TITLE           = "Отслеживаемые заклинания (HoT)";
SMARTDEBUFF_S_TITLE            = "Звук оповещения о дебаффе";


-- Tooltip text
SMARTDEBUFF_TT                 = "Перетащите заголовок с Shift-Левой кнопкой мыши: Перемещает рамку\n|cff20d2ff- Кнопка S -|r\nЛевый клик: Показать по классу, роли или группе\nShift-Левый клик: Цвета классов\nAlt-Левый клик: Выделение Л/П/С\nПравый клик: Фон";
SMARTDEBUFF_TT_TARGETMODE      = "В обычном режиме |cff20d2ffЛевый клик|r рассеивает с цели...\n \nВ режиме цели |cff20d2ffЛевый клик|r выбирает цель,\nрассеивайте с |cff20d2ffAlt-Кликом|r\nи |cff20d2ffПравый клик|r применяет самое быстрое исцеляющее заклинание.|r.";
SMARTDEBUFF_TT_NOTREMOVABLE    = "Показывает критические дебаффы,\nкоторые нельзя рассеять.";
SMARTDEBUFF_TT_HP              = "Показывает реальные очки здоровья\nюнита.";
SMARTDEBUFF_TT_MANA            = "Показывает реальную полосу маны\nюнита.";
SMARTDEBUFF_TT_HPTEXT          = "Показывает реальные очки здоровья/маны\nв процентах от юнита в виде текста.";
SMARTDEBUFF_TT_INVERT          = "Показывает очки здоровья\nи полосу маны инвертированными.";
SMARTDEBUFF_TT_CLASSVIEW       = "Показывает кнопки юнитов,\nотсортированные по классу.";
SMARTDEBUFF_TT_CLASSCOLOR      = "Показывает кнопки юнитов в\nсоответствующих цветах классов.";
SMARTDEBUFF_TT_SHOWLR          = "Показывает соответствующую кнопку мыши (Л/П/С),\nесли у юнита есть дебафф.";
SMARTDEBUFF_TT_HEADERS         = "Показывает номер группы / класс / роль\nв качестве заголовка.";
SMARTDEBUFF_TT_GROUPNR         = "Показывает номер группы\nперед именем юнита.";
SMARTDEBUFF_TT_SOUND           = "Воспроизводит звук, если юнит\nполучает дебафф.";
SMARTDEBUFF_TT_TOOLTIP         = "Показывает подсказку\nтолько вне боя.";
SMARTDEBUFF_TT_HEALRANGE       = "Показывает красную рамку,\nесли ваше заклинание вне радиуса.";
SMARTDEBUFF_TT_SHOWAGGRO       = "Показывает, какой\nюнит имеет агро.";
SMARTDEBUFF_TT_VERTICAL        = "Показывает юнитов,\nрасположенных вертикально.";
SMARTDEBUFF_TT_VERTICALUP      = "Показывает юнитов\nснизу вверх.";
SMARTDEBUFF_TT_HEADERROW       = "Показывает строку заголовка,\nвключая кнопки меню.";
SMARTDEBUFF_TT_BACKDROP        = "Показывает черную\nфоновую рамку.";
SMARTDEBUFF_TT_SHOWGRADIENT    = "Показывает кнопки юнитов\nс цветовым градиентом.";
SMARTDEBUFF_TT_INFOFRAME       = "Показывает сводную рамку\nтолько в конфигурации группы или рейда.";
SMARTDEBUFF_TT_AUTOHIDE        = "Автоматически скрывает кнопки\nюнитов, если вы вне боя\nи ни у кого нет дебаффов.";
SMARTDEBUFF_TT_VEHICLE         = "Также показывает транспорт\nюнита как отдельную кнопку.";
SMARTDEBUFF_TT_SHOWRAIDICON    = "Показывает иконку рейда\nюнита.";
SMARTDEBUFF_TT_SHOWROLEICON    = "Показывает иконку роли танков / хилов.\n(если нет иконки рейда)";
SMARTDEBUFF_TT_SHOWROLEDPSICON    = "Показывает иконку роли дпс.\n(если нет иконки рейда)";
SMARTDEBUFF_TT_SHOWSPELLICON   = "Показывает иконку HoT\nна юните.";
SMARTDEBUFF_TT_INFOROW         = "Показывает краткую информационную строку (только в рейде):\nИгроки/Мертвые/АФК/Оффлайн\nЗдоровье/Мана\nИгрок готов\n(только в рейде)";
SMARTDEBUFF_TT_GLOBALSAVE      = "Настройки сохранены в глобальном сохранении.";
SMARTDEBUFF_TT_GLOBALLOAD      = "Настройки загружены из глобального сохранения.";
SMARTDEBUFF_TT_ROLE            = "Показывает кнопки юнитов\nпо порядку ролей.";
SMARTDEBUFF_TT_ADVANCHORS      = "Показывает и использует расширенную\nконфигурацию точек привязки\nдля рамки дебаффов.";
SMARTDEBUFF_TT_STOPCAST        = "Немедленно прерывает текущее\nприменение или поддержание заклинания,\nчтобы применить указанное заклинание.\n(Только для заклинаний рассеивания)";
SMARTDEBUFF_TT_IGNOREDEBUFF    = "Игнорирует дебафф на юните,\nесли ваше заклинание рассеивания на перезарядке.";
SMARTDEBUFF_TT_CHATNOTIF       = "Показывает уведомления в чате при загрузке";

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
SMARTDEBUFF_TT_DROP            = "Перетащить";
SMARTDEBUFF_TT_DROPINFO        = "Перетащите сюда заклинание/предмет/макрос из вашей книги/инвентаря.\n|cff00ff00Левый клик для определения функции цели.\nShift-Левый клик для определения функции меню";
SMARTDEBUFF_TT_SPELLACTIONS    = "Клик по заклинанию:\n Левый для взятия\n Shift-Левый для клонирования\n Правый для удаления";
SMARTDEBUFF_TT_ITEMACTIONS     = "Клик по предмету:\n Левый для взятия\n Shift-Левый для клонирования\n Правый для удаления";
SMARTDEBUFF_TT_MACROACTIONS    = "Клик по макросу:\n Левый для взятия\n Shift-Левый для клонирования\n Правый для удаления";
SMARTDEBUFF_TT_TARGET          = "Цель";
SMARTDEBUFF_TT_TARGETINFO      = "Выбирает указанный юнит\nв качестве текущей цели.";
SMARTDEBUFF_TT_PETACTION       = "Действие питомца";
SMARTDEBUFF_TT_NOTFOUND        = "Ошибка: Заклинание не найдено";
SMARTDEBUFF_TT_MISSINGINFO     = "Проверьте вашу специализацию / таланты / питомца.";
SMARTDEBUFF_TT_NOTMOVABLE      = "Невозможно переместить с вашей специализацией";
SMARTDEBUFF_TT_TARGETACTIONS   = "Клик мыши:\n Правый для удаления";
SMARTDEBUFF_TT_PETACTIONS      = "Действие питомца:\nУдаление невозможно!";
SMARTDEBUFF_TT_MENU            = "Меню";
SMARTDEBUFF_TT_MENUINFO        = "Открывает меню опций юнита.";
SMARTDEBUFF_TT_PICKMENU        = "Клик мыши:\n Правый для удаления";
SMARTDEBUFF_TT_DROPABBLE       = "Клик мыши:\n Левый для перетаскивания\n Правый для отпускания";
SMARTDEBUFF_TT_DROPREPLACE     = "Клик мыши:\n Левый для замены\n Правый для отпускания";
SMARTDEBUFF_TT_DROPEXCHANGE    = "Клик мыши:\n Левый для обмена\n Правый для отпускания";
SMARTDEBUFF_TT_CANTDROP        = "Клик мыши:\n Правый для отпускания";

--Tooltips added by Semi#1287
SMARTDEBUFF_TT_OPTIONS          = "|cff20d2ff- Кнопка O -|r\nЛевый клик: Открыть настройки\nПравый клик: Изменить горячие клавиши";
SMARTDEBUFF_OFT_CLASSSORT       = "Список сортировки классов";
SMARTDEBUFF_TT_CLASSSORT 	      = "Нажмите, чтобы изменить порядок классов";
SMARTDEBUFF_OFT_NOTREMOVABLE_LIST = "Список защищенных дебаффов";
SMARTDEBUFF_TT_NOTREMOVABLE_LIST 	= "Нажмите, чтобы изменить список";
SMARTDEBUFF_OFT_SKILLS          = "Горячие клавиши мыши";
SMARTDEBUFF_TT_SKILLS           = "Нажмите, чтобы изменить горячие клавиши\n(Клик Л/П/С, с Alt/Shift/Ctrl)";
SMARTDEBUFF_TT_RESET_SKILLS     = "Сбрасывает горячие клавиши для вашего класса";
SMARTDEBUFF_OFT_SHOWDEBUFFGUARD	= "Список отслеживаемых заклинаний";
SMARTDEBUFF_TT_SHOWDEBUFFGUARD  = "Нажмите, чтобы изменить\nсписок отслеживаемых заклинаний";
SMARTDEBUFF_TT_SOUNDLIST        = "Нажмите, чтобы выбрать звук.\n(Правый клик только для прослушивания)";

-- Tooltip support
SMARTDEBUFF_FUBAR_TT           = "\nЛевый клик: Открыть настройки\nShift-Левый клик: Вкл/Выкл";
SMARTDEBUFF_BROKER_TT          = "Левый клик: Открыть настройки\nПравый клик: Вкл/Выкл";

SMARTDEBUFF_ERR_RELOADREQUIRED  = [[Для работы кликов может потребоваться перезагрузка ( /reload )]];
