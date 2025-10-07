-------------------------------------------------------------------------------
-- Chinese localization (Taiwan)
-------------------------------------------------------------------------------

if (GetLocale() ~= "zhCN" and GetLocale() ~= "zhTW") then return end

SMARTDEBUFF_FONT = "Fonts\\ARKai_T.TTF"

SMARTDEBUFF_UPGRADED = "SmartDebuff 已更新: "..SMARTDEBUFF_VERSION;


-- Creatures
SMARTDEBUFF_HUMANOID  = BATTLE_PET_NAME_1;
SMARTDEBUFF_DEMON     = PET_TYPE_DEMON;
SMARTDEBUFF_BEAST     = BATTLE_PET_NAME_8;
SMARTDEBUFF_ELEMENTAL = BATTLE_PET_NAME_7;
SMARTDEBUFF_IMP       = "小鬼";
SMARTDEBUFF_FELHUNTER = "地獄犬";
SMARTDEBUFF_DOOMGUARD = "惡魔守衛";

-- Classes
SMARTDEBUFF_CLASSES = {["HPET"] = "獵人寵物", ["WPET"] = "術士寵物", ["DPET"] = "死亡騎士寵物"};
for _, class in ipairs(CLASS_SORT_ORDER) do SMARTDEBUFF_CLASSES[class] = LOCALIZED_CLASS_NAMES_MALE[class] end;


-- Bindings
BINDING_NAME_SMARTDEBUFF =  SMARTDEBUFF_TITLE.." 選項";

SMARTDEBUFF_KEY_L = "左";
SMARTDEBUFF_KEY_R = "右";
SMARTDEBUFF_KEY_M = "中";
SMARTDEBUFF_KEYS = {["L"]  = "左",
                    ["R"]  = "右",
                    ["M"]  = "中",
                    ["SL"] = "Shift 左",
                    ["SR"] = "Shift 右",
                    ["SM"] = "Shift 中",
                    ["AL"] = "Alt 左",
                    ["AR"] = "Alt 右",
                    ["AM"] = "Alt 中",
                    ["CL"] = "Ctrl 左",
                    ["CR"] = "Ctrl 右",
                    ["CM"] = "Ctrl 中"
                    };


-- Messages
SMARTDEBUFF_MSG_LOADED         = "已加載";
SMARTDEBUFF_MSG_SDB            = "SmartDebuff 選項框體";

-- Frame text
SMARTDEBUFF_FT_MODES           = "按鍵/模式";
SMARTDEBUFF_FT_MODENORMAL      = "普通";
SMARTDEBUFF_FT_MODETARGET      = "目標";


-- Options frame text
SMARTDEBUFF_OFT                = "顯示/隱藏選項框體";
SMARTDEBUFF_OFT_HUNTERPETS     = "獵人寵物";
SMARTDEBUFF_OFT_WARLOCKPETS    = "術士寵物";
SMARTDEBUFF_OFT_DEATHKNIGHTPETS= "死亡騎士寵物";
SMARTDEBUFF_OFT_HP             = "生命";
SMARTDEBUFF_OFT_MANA           = "魔法";
SMARTDEBUFF_OFT_HPTEXT         = "%";
SMARTDEBUFF_OFT_INVERT         = "反轉";
SMARTDEBUFF_OFT_CLASSVIEW      = "職業視圖";
SMARTDEBUFF_OFT_CLASSCOLOR     = "職業顏色";
SMARTDEBUFF_OFT_SHOWLR         = "左 / 右 / 中";
SMARTDEBUFF_OFT_HEADERS        = "標題";
SMARTDEBUFF_OFT_GROUPNR        = "組號";
SMARTDEBUFF_OFT_SOUND          = "聲音";
SMARTDEBUFF_OFT_TOOLTIP        = "提示";
SMARTDEBUFF_OFT_TARGETMODE     = "目標模式";
SMARTDEBUFF_OFT_HEALRANGE      = "法術距離";
SMARTDEBUFF_OFT_SHOWAGGRO      = "戰斗";
SMARTDEBUFF_OFT_VERTICAL       = "垂直排列";
SMARTDEBUFF_OFT_VERTICALUP     = "垂直向上";
SMARTDEBUFF_OFT_HEADERROW      = "標題條";
SMARTDEBUFF_OFT_BACKDROP       = "背景";
SMARTDEBUFF_OFT_SHOWGRADIENT   = "漸變";
SMARTDEBUFF_OFT_INFOFRAME      = "摘要框體";
SMARTDEBUFF_OFT_AUTOHIDE       = "自動隱藏";
SMARTDEBUFF_OFT_COLUMNS        = "列";
SMARTDEBUFF_OFT_INTERVAL       = "間隔";
SMARTDEBUFF_OFT_FONTSIZE       = "字體大小";
SMARTDEBUFF_OFT_WIDTH          = "寬";
SMARTDEBUFF_OFT_HEIGHT         = "高";
SMARTDEBUFF_OFT_BARHEIGHT      = "格子高";
SMARTDEBUFF_OFT_COLOR_LEFT     = "減益\n左"
SMARTDEBUFF_OFT_COLOR_RIGHT    = "減益\n右"
SMARTDEBUFF_OFT_COLOR_MIDDLE   = "減益\n中"
SMARTDEBUFF_OFT_COLOR_NOTREM   = "無法驅散\n減益"
SMARTDEBUFF_OFT_COLOR_UNIT     = "單位\n按鈕"
SMARTDEBUFF_OFT_COLOR_BACKDROP = "背景\n點擊我"
SMARTDEBUFF_OFT_OPACITYNORMAL  = "距離內透明度";
SMARTDEBUFF_OFT_OPACITYOOR     = "距離外透明度";
SMARTDEBUFF_OFT_OPACITYDEBUFF  = "debuff透明度";
SMARTDEBUFF_OFT_NOTREMOVABLE   = "Debuff保護";
SMARTDEBUFF_OFT_VEHICLE        = "載具";  -- ChatGPT
SMARTDEBUFF_OFT_SHOWRAIDICON   = "團隊圖標";  -- ChatGPT
SMARTDEBUFF_OFT_SHOWROLEICON   = "職責圖標 (坦克/治療)";  -- ChatGPT
SMARTDEBUFF_OFT_SHOWROLEDPSICON = "職責圖標 (輸出)";  -- ChatGPT
SMARTDEBUFF_OFT_SHOWSPELLICON  = "法術圖標";  -- ChatGPT
SMARTDEBUFF_OFT_INFOROW        = "資訊欄";  -- ChatGPT
SMARTDEBUFF_OFT_GLOBALSAVE     = "全局保存";  -- ChatGPT
SMARTDEBUFF_OFT_GLOBALLOAD     = "全局載入";  -- ChatGPT
SMARTDEBUFF_OFT_RESET          = "重置";  -- ChatGPT
SMARTDEBUFF_OFT_ROLE           = "職責";  -- ChatGPT
SMARTDEBUFF_OFT_ADVANCHORS     = "設定錨點";  -- ChatGPT
SMARTDEBUFF_OFT_ICONSIZE       = "圖標大小";  -- ChatGPT
SMARTDEBUFF_OFT_COLORSETUP     = "設定顏色";  -- ChatGPT
SMARTDEBUFF_OFT_SPACEX         = "X軸間距";  -- ChatGPT
SMARTDEBUFF_OFT_SPACEY         = "Y軸間距";  -- ChatGPT
SMARTDEBUFF_OFT_TESTMODE       = "測試模式";  -- ChatGPT
SMARTDEBUFF_OFT_STOPCAST       = "中斷施法";  -- ChatGPT
SMARTDEBUFF_OFT_IGNOREDEBUFF   = "忽略減益";  -- ChatGPT
SMARTDEBUFF_OFT_CHATNOTIF      = "聊天通知";  -- ChatGPT
SMARTDEBUFF_OFT_RESET_KEYS     = "重置 SmartDebuff 法術為預設值？\n\n如果您覺得所有減益效果都未正確偵測，則需要執行此操作。";  -- ChatGPT
SMARTDEBUFF_AOFT_SORTBYCLASS   = "按職業排序";
SMARTDEBUFF_NRDT_TITLE         = "不可驅散的Debuffs";
SMARTDEBUFF_SG_TITLE           = "追蹤法術 (HoT)";  -- ChatGPT
SMARTDEBUFF_S_TITLE            = "減益警報音效";  -- ChatGPT


-- Tooltip text
SMARTDEBUFF_TT                 = "Shift-左拖動: 移動框體\n|cff20d2ff- S 按鈕 -|r\n左點擊: 按職業顯示\nShift-左點擊: 職業顏色\nAlt-左點擊: 高亮 左/右/中\n右點擊: 背景";
SMARTDEBUFF_TT_TARGETMODE      = "在目標模式\n|cff20d2ff左點擊|r選擇單位\n|cff20d2ff右點擊|r釋放最快的治療法術。\n|cff20d2ffAlt-左/右/中點擊|r驅除debuff.";
SMARTDEBUFF_TT_NOTREMOVABLE    = "顯示重大 debuff\n即便是無法驅除.";
SMARTDEBUFF_TT_HP              = "顯示真實生命";
SMARTDEBUFF_TT_MANA            = "顯示真實魔法";
SMARTDEBUFF_TT_HPTEXT          = "以文字顯示單位真實生命/魔法百分比。";  -- ChatGPT
SMARTDEBUFF_TT_INVERT          = "反轉顯示生命魔法";
SMARTDEBUFF_TT_CLASSVIEW       = "按職業顯示單位按鈕";
SMARTDEBUFF_TT_CLASSCOLOR      = "單位按鈕上顯示職業顏色";
SMARTDEBUFF_TT_SHOWLR          = "有debuff時\n顯示對應的按鈕 (左/右/中), ";
SMARTDEBUFF_TT_HEADERS         = "顯示職業名稱\n作為行標題";
SMARTDEBUFF_TT_GROUPNR         = "顯示小組編號\n在單位名字前";
SMARTDEBUFF_TT_SOUND           = "播放聲音, 當\n有單位獲得debuff.";
SMARTDEBUFF_TT_TOOLTIP         = "顯示提示信息,\n不在戰斗中時";
SMARTDEBUFF_TT_HEALRANGE       = "顯示紅色邊框,\n如果你的法術超出距離";
SMARTDEBUFF_TT_SHOWAGGRO       = "顯示那個\n單位在戰斗中";
SMARTDEBUFF_TT_VERTICAL        = "顯示單位\n垂直排列";
SMARTDEBUFF_TT_VERTICALUP      = "顯示單位\n從下至上";
SMARTDEBUFF_TT_HEADERROW       = "顯示標題條,\n包括菜單按鈕";
SMARTDEBUFF_TT_BACKDROP        = "顯示黑色\n背景框體.";
SMARTDEBUFF_TT_SHOWGRADIENT    = "顯示單位按鈕\n使用彩色漸變效果";
SMARTDEBUFF_TT_INFOFRAME       = "顯示摘要框體,\n只在隊伍或團隊中時";
SMARTDEBUFF_TT_AUTOHIDE        = "自動隱藏單位按鈕\n在非戰斗狀態 \n且無人有debuff時";
SMARTDEBUFF_TT_VEHICLE         = "也將單位載具顯示為獨立按鈕。";  -- ChatGPT
SMARTDEBUFF_TT_SHOWRAIDICON    = "顯示單位團隊圖標。";  -- ChatGPT
SMARTDEBUFF_TT_SHOWROLEICON    = "顯示坦克/治療職責圖標。\n(如果沒有團隊圖標)";  -- ChatGPT
SMARTDEBUFF_TT_SHOWROLEDPSICON    = "顯示輸出職責圖標。\n(如果沒有團隊圖標)";  -- ChatGPT
SMARTDEBUFF_TT_SHOWSPELLICON   = "在單位上顯示持續治療 (HoT) 圖標。";  -- ChatGPT
SMARTDEBUFF_TT_INFOROW         = "顯示簡潔資訊欄 (僅限團隊)：\n玩家/死亡/暫離/離線\n生命/魔法\n玩家準備就緒\n(僅限團隊)";  -- ChatGPT
SMARTDEBUFF_TT_GLOBALSAVE      = "設定已保存至全局存檔。";  -- ChatGPT
SMARTDEBUFF_TT_GLOBALLOAD      = "設定已從全局存檔載入。";  -- ChatGPT
SMARTDEBUFF_TT_ROLE            = "按職責順序顯示單位按鈕。";  -- ChatGPT
SMARTDEBUFF_TT_ADVANCHORS      = "顯示並使用進階錨點設定\n用於減益框體。";  -- ChatGPT
SMARTDEBUFF_TT_STOPCAST        = "立即中斷當前施法或引導\n以施放指定法術。\n(僅限驅散法術)";  -- ChatGPT
SMARTDEBUFF_TT_IGNOREDEBUFF    = "如果您的驅散法術正在冷卻中，\n則忽略單位上的減益效果。";  -- ChatGPT
SMARTDEBUFF_TT_CHATNOTIF       = "載入時顯示聊天通知";  -- ChatGPT

SMARTDEBUFF_TT_COLUMNS         = "列";  -- ChatGPT
SMARTDEBUFF_TT_INTERVAL        = "間隔";  -- ChatGPT
SMARTDEBUFF_TT_FONTSIZE        = "字體大小";  -- ChatGPT
SMARTDEBUFF_TT_WIDTH           = "寬度";  -- ChatGPT
SMARTDEBUFF_TT_HEIGHT          = "高度";  -- ChatGPT
SMARTDEBUFF_TT_BARHEIGHT       = "條高";  -- ChatGPT
SMARTDEBUFF_TT_OPACITYNORMAL   = "範圍內透明度";  -- ChatGPT
SMARTDEBUFF_TT_OPACITYOOR      = "範圍外透明度";  -- ChatGPT
SMARTDEBUFF_TT_OPACITYDEBUFF   = "減益透明度";  -- ChatGPT

-- Tooltip text key bindings
SMARTDEBUFF_TT_DROP            = "釋放";
SMARTDEBUFF_TT_DROPINFO        = "從您的法術書/物品欄拖曳法術/物品/巨集至此。\n|cff00ff00左鍵點擊以定義目標功能。\nShift-左鍵點擊以定義選單功能";
SMARTDEBUFF_TT_SPELLACTIONS    = "法術點擊:\n左 拾取\nShift-左 復制\n右 刪除";
SMARTDEBUFF_TT_ITEMACTIONS     = "物品點擊:\n左 拾取\nShift-左 復制\n右 刪除";
SMARTDEBUFF_TT_MACROACTIONS    = "宏 點擊:\n左 拾取\nShift-左 復制\n右 刪除";
SMARTDEBUFF_TT_TARGET          = "目標";
SMARTDEBUFF_TT_TARGETINFO      = "選擇指定單位\n作為當前目標.";
SMARTDEBUFF_TT_PETACTION       = "寵物行動";  -- ChatGPT
SMARTDEBUFF_TT_NOTFOUND        = "錯誤：找不到法術";  -- ChatGPT
SMARTDEBUFF_TT_MISSINGINFO     = "檢查您的專精 / 天賦 / 寵物。";  -- ChatGPT
SMARTDEBUFF_TT_NOTMOVABLE      = "無法使用您的專精移動";  -- ChatGPT
SMARTDEBUFF_TT_TARGETACTIONS   = "滑鼠點擊：\n 右鍵刪除";  -- ChatGPT
SMARTDEBUFF_TT_PETACTIONS      = "寵物行動:\n不能刪除!";
SMARTDEBUFF_TT_MENU            = "選單";  -- ChatGPT
SMARTDEBUFF_TT_MENUINFO        = "開啟單位選項選單。";  -- ChatGPT
SMARTDEBUFF_TT_PICKMENU        = "滑鼠點擊：\n 右鍵刪除";  -- ChatGPT
SMARTDEBUFF_TT_DROPABBLE       = "滑鼠點擊：\n 左鍵拖曳\n 右鍵釋放";  -- ChatGPT
SMARTDEBUFF_TT_DROPREPLACE     = "滑鼠點擊：\n 左鍵替換\n 右鍵釋放";  -- ChatGPT
SMARTDEBUFF_TT_DROPEXCHANGE    = "滑鼠點擊：\n 左鍵交換\n 右鍵釋放";  -- ChatGPT
SMARTDEBUFF_TT_CANTDROP        = "滑鼠點擊：\n 右鍵釋放";  -- ChatGPT

-- SMARTDEBUFF_INFO_READY         = "玩家：\n生命 %：\n魔法 %：\n死亡：\n暫離：\n離線：\n準備就緒：";  -- ChatGPT
-- SMARTDEBUFF_INFO               = "玩家：\n生命 %：\n魔法 %：\n死亡：\n暫離：\n離線";  -- ChatGPT

--Tooltips added by Semi#1287
SMARTDEBUFF_TT_OPTIONS          = "|cff20d2ff- O 按鈕 -|r\n左鍵點擊：開啟選項\n右鍵點擊：修改快捷鍵";  -- ChatGPT
SMARTDEBUFF_OFT_CLASSSORT       = "職業排序列表";  -- ChatGPT
SMARTDEBUFF_TT_CLASSSORT 	      = "點擊以修改職業順序";  -- ChatGPT
SMARTDEBUFF_OFT_NOTREMOVABLE_LIST = "不可移除 Debuff 列表";  -- ChatGPT
SMARTDEBUFF_TT_NOTREMOVABLE_LIST 	= "點擊編輯列表";  -- ChatGPT
SMARTDEBUFF_OFT_SKILLS          = "滑鼠快捷鍵";  -- ChatGPT
SMARTDEBUFF_TT_SKILLS           = "點擊以修改快捷鍵\n(左/右/中鍵點擊，搭配 Alt/Shift/Ctrl)";  -- ChatGPT
SMARTDEBUFF_TT_RESET_SKILLS     = "重置您的職業快捷鍵";  -- ChatGPT
SMARTDEBUFF_OFT_SHOWDEBUFFGUARD	= "法術守護列表";  -- ChatGPT
SMARTDEBUFF_TT_SHOWDEBUFFGUARD  = "點擊以修改\n追蹤法術列表";  -- ChatGPT
SMARTDEBUFF_TT_SOUNDLIST        = "點擊以選擇音效。\n(右鍵僅供試聽)";  -- ChatGPT

-- Tooltip support
SMARTDEBUFF_FUBAR_TT           = "\n左點擊: 打開選項\nShift-左點擊: On/Off";
SMARTDEBUFF_BROKER_TT          = "左鍵點擊：開啟選項\n右鍵點擊：開啟/關閉";  -- ChatGPT

SMARTDEBUFF_ERR_RELOADREQUIRED  = [[可能需要重新載入 ( /reload ) 才能使點擊功能生效]];  -- ChatGPT

-- izayoi 2009-5-30