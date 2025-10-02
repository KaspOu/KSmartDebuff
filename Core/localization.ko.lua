-------------------------------------------------------------------------------
-- Korean localization (ChatGPT)
-------------------------------------------------------------------------------

if (GetLocale() ~= "koKR") then return end

SMARTDEBUFF_FONT = "Fonts\\2002.TTF"

SMARTDEBUFF_UPGRADED = "SmartDebuff 업데이트됨: "..SMARTDEBUFF_VERSION;

-- Creatures
SMARTDEBUFF_HUMANOID  = BATTLE_PET_NAME_1;
SMARTDEBUFF_DEMON     = PET_TYPE_DEMON;
SMARTDEBUFF_BEAST     = BATTLE_PET_NAME_8;
SMARTDEBUFF_ELEMENTAL = BATTLE_PET_NAME_7;
SMARTDEBUFF_IMP       = "임프";
SMARTDEBUFF_FELHUNTER = "지옥사냥개";
SMARTDEBUFF_DOOMGUARD = "파멸의 수호병";

-- Classes
SMARTDEBUFF_CLASSES = {["HPET"] = "사냥꾼 야수", ["WPET"] = "흑마법사 소환수", ["DPET"] = "악마사냥꾼 소환수"};
for _, class in ipairs(CLASS_SORT_ORDER) do SMARTDEBUFF_CLASSES[class] = LOCALIZED_CLASS_NAMES_MALE[class] end;


-- Bindings
BINDING_NAME_SMARTDEBUFF =  SMARTDEBUFF_TITLE.." 옵션";

SMARTDEBUFF_KEY_L = "좌";
SMARTDEBUFF_KEY_R = "우";
SMARTDEBUFF_KEY_M = "중";
SMARTDEBUFF_KEYS = {["L"]  = "좌",
                    ["R"]  = "우",
                    ["M"]  = "중",
                    ["SL"] = "Shift 좌",
                    ["SR"] = "Shift 우",
                    ["SM"] = "Shift 중",
                    ["AL"] = "Alt 좌",
                    ["AR"] = "Alt 우",
                    ["AM"] = "Alt 중",
                    ["CL"] = "Ctrl 좌",
                    ["CR"] = "Ctrl 우",
                    ["CM"] = "Ctrl 중"
                    };


-- Messages
SMARTDEBUFF_MSG_LOADED         = "불러옴";
SMARTDEBUFF_MSG_SDB            = "SmartDebuff 옵션 메뉴";

-- Frame text
SMARTDEBUFF_FT_MODES           = "키 / 모드";
SMARTDEBUFF_FT_MODENORMAL      = "일반";
SMARTDEBUFF_FT_MODETARGET      = "대상";


-- Options frame text
SMARTDEBUFF_OFT                = "SmartDebuff 옵션 표시/숨기기";
SMARTDEBUFF_OFT_HUNTERPETS     = "사냥꾼 야수";
SMARTDEBUFF_OFT_WARLOCKPETS    = "흑마법사 소환수";
SMARTDEBUFF_OFT_DEATHKNIGHTPETS= "죽음의 기사 소환수";
SMARTDEBUFF_OFT_HP             = "생명력";
SMARTDEBUFF_OFT_MANA           = "마나";
SMARTDEBUFF_OFT_HPTEXT         = "%";
SMARTDEBUFF_OFT_INVERT         = "반전";
SMARTDEBUFF_OFT_CLASSVIEW      = "직업별 정렬";
SMARTDEBUFF_OFT_CLASSCOLOR     = "직업 색상";
SMARTDEBUFF_OFT_SHOWLR         = "좌 / 우 / 중 표시";
SMARTDEBUFF_OFT_HEADERS        = "머리글";
SMARTDEBUFF_OFT_GROUPNR        = "그룹 번호";
SMARTDEBUFF_OFT_SOUND          = "소리";
SMARTDEBUFF_OFT_TOOLTIP        = "툴팁";
SMARTDEBUFF_OFT_TARGETMODE     = "대상 모드";
SMARTDEBUFF_OFT_HEALRANGE      = "치유 사거리";
SMARTDEBUFF_OFT_SHOWAGGRO      = "어그로";
SMARTDEBUFF_OFT_VERTICAL       = "세로 정렬";
SMARTDEBUFF_OFT_VERTICALUP     = "위로 세로 정렬";
SMARTDEBUFF_OFT_HEADERROW      = "제목 표시줄";
SMARTDEBUFF_OFT_BACKDROP       = "배경";
SMARTDEBUFF_OFT_SHOWGRADIENT   = "그라데이션 표시";
SMARTDEBUFF_OFT_INFOFRAME      = "정보 프레임";
SMARTDEBUFF_OFT_AUTOHIDE       = "자동 숨기기";
SMARTDEBUFF_OFT_COLUMNS        = "열";
SMARTDEBUFF_OFT_INTERVAL       = "간격";
SMARTDEBUFF_OFT_FONTSIZE       = "글꼴 크기";
SMARTDEBUFF_OFT_WIDTH          = "너비";
SMARTDEBUFF_OFT_HEIGHT         = "높이";
SMARTDEBUFF_OFT_BARHEIGHT      = "막대 높이";
SMARTDEBUFF_OFT_COLOR_LEFT     = "디버프\n좌"
SMARTDEBUFF_OFT_COLOR_RIGHT    = "디버프\n우"
SMARTDEBUFF_OFT_COLOR_MIDDLE   = "디버프\n중"
SMARTDEBUFF_OFT_COLOR_NOTREM   = "해제 불가\n디버프"
SMARTDEBUFF_OFT_COLOR_UNIT     = "유닛\n버튼"
SMARTDEBUFF_OFT_COLOR_BACKDROP = "배경\n클릭"
SMARTDEBUFF_OFT_OPACITYNORMAL  = "사거리 내 투명도";
SMARTDEBUFF_OFT_OPACITYOOR     = "사거리 밖 투명도";
SMARTDEBUFF_OFT_OPACITYDEBUFF  = "디버프 투명도";
SMARTDEBUFF_OFT_NOTREMOVABLE   = "해제 불가 디버프";
SMARTDEBUFF_OFT_VEHICLE        = "탈것";
SMARTDEBUFF_OFT_SHOWRAIDICON   = "공격대 아이콘 표시";
SMARTDEBUFF_OFT_SHOWROLEICON   = "역할 아이콘 표시 (탱/힐)";
SMARTDEBUFF_OFT_SHOWROLEDPSICON = "역할 아이콘 표시 (딜)";
SMARTDEBUFF_OFT_SHOWSPELLICON  = "주문 아이콘 표시";
SMARTDEBUFF_OFT_INFOROW        = "정보 행";
SMARTDEBUFF_OFT_GLOBALSAVE     = "저장";
SMARTDEBUFF_OFT_GLOBALLOAD     = "불러오기";
SMARTDEBUFF_OFT_RESET          = "초기화";
SMARTDEBUFF_OFT_ROLE           = "역할";
SMARTDEBUFF_OFT_ADVANCHORS     = "고급 앵커 설정";
SMARTDEBUFF_OFT_ICONSIZE       = "아이콘 크기";
SMARTDEBUFF_OFT_COLORSETUP     = "색상 설정";
SMARTDEBUFF_OFT_SPACEX         = "X 간격";
SMARTDEBUFF_OFT_SPACEY         = "Y 간격";
SMARTDEBUFF_OFT_TESTMODE       = "테스트 모드";
SMARTDEBUFF_OFT_STOPCAST       = "주문 시전 중단";
SMARTDEBUFF_OFT_IGNOREDEBUFF   = "디버프 무시";
SMARTDEBUFF_OFT_CHATNOTIF      = "채팅 알림";
SMARTDEBUFF_OFT_RESET_KEYS     = "SmartDebuff 주문을 기본값으로 재설정하시겠습니까?\n\n모든 디버프가 올바르게 감지되지 않는다고 생각되면 이 작업이 필요합니다.";
SMARTDEBUFF_AOFT_SORTBYCLASS   = "직업 정렬 순서";
SMARTDEBUFF_NRDT_TITLE         = "해제 불가 디버프";
SMARTDEBUFF_SG_TITLE           = "추적 중인 주문 (HoT)";
SMARTDEBUFF_S_TITLE            = "디버프 경고음";


-- Tooltip text
SMARTDEBUFF_TT                 = "Shift-좌클릭으로 제목을 드래그: 프레임 이동\n|cff20d2ff- S 버튼 -|r\n좌클릭: 직업, 역할 또는 그룹별로 표시\nShift-좌클릭: 직업 색상\nAlt-좌클릭: 좌/우/중 강조\n우클릭: 배경";
SMARTDEBUFF_TT_TARGETMODE      = "일반 모드에서 |cff20d2ff좌클릭|r은 유닛을 해제합니다...\n \n대상 모드에서 |cff20d2ff좌클릭|r은 유닛을 선택하고,\n|cff20d2ffAlt-클릭|r으로 해제하며\n|cff20d2ff우클릭|r은 가장 빠른 치유 주문을 시전합니다.|r.";
SMARTDEBUFF_TT_NOTREMOVABLE    = "해제할 수 없는\n치명적인 디버프를 표시합니다.";
SMARTDEBUFF_TT_HP              = "유닛의 실제\n생명력을 표시합니다.";
SMARTDEBUFF_TT_MANA            = "유닛의 실제\n마나 바를 표시합니다.";
SMARTDEBUFF_TT_HPTEXT          = "유닛의 실제 생명력/마나를\n백분율 텍스트로 표시합니다.";
SMARTDEBUFF_TT_INVERT          = "생명력과 마나 바를\n반전하여 표시합니다.";
SMARTDEBUFF_TT_CLASSVIEW       = "직업별로 정렬된\n유닛 버튼을 표시합니다.";
SMARTDEBUFF_TT_CLASSCOLOR      = "각 직업 색상으로\n유닛 버튼을 표시합니다.";
SMARTDEBUFF_TT_SHOWLR          = "유닛에 디버프가 있을 경우\n해당 마우스 버튼 (좌/우/중)을 표시합니다.";
SMARTDEBUFF_TT_HEADERS         = "그룹 번호 / 직업 / 역할을\n머리글로 표시합니다.";
SMARTDEBUFF_TT_GROUPNR         = "유닛 이름 앞에\n그룹 번호를 표시합니다.";
SMARTDEBUFF_TT_SOUND           = "유닛이 디버프를 받으면\n소리를 재생합니다.";
SMARTDEBUFF_TT_TOOLTIP         = "전투 중이 아닐 때만\n툴팁을 표시합니다.";
SMARTDEBUFF_TT_HEALRANGE       = "주문 사거리 밖일 경우\n빨간색 테두리를 표시합니다.";
SMARTDEBUFF_TT_SHOWAGGRO       = "어떤 유닛이\n어그로를 가지고 있는지 표시합니다.";
SMARTDEBUFF_TT_VERTICAL        = "유닛을 세로로\n정렬하여 표시합니다.";
SMARTDEBUFF_TT_VERTICALUP      = "유닛을 아래에서 위로\n정렬하여 표시합니다.";
SMARTDEBUFF_TT_HEADERROW       = "메뉴 버튼을 포함한\n머리글 행을 표시합니다.";
SMARTDEBUFF_TT_BACKDROP        = "검은색 배경\n프레임을 표시합니다.";
SMARTDEBUFF_TT_SHOWGRADIENT    = "색상 그라데이션이 있는\n유닛 버튼을 표시합니다.";
SMARTDEBUFF_TT_INFOFRAME       = "그룹 또는 공격대 설정에서만\n요약 프레임을 표시합니다.";
SMARTDEBUFF_TT_AUTOHIDE        = "전투 중이 아니고\n아무도 디버프가 없을 경우\n유닛 버튼을 자동으로 숨깁니다.";
SMARTDEBUFF_TT_VEHICLE         = "유닛의 탈것도 별도의\n버튼으로 표시합니다.";
SMARTDEBUFF_TT_SHOWRAIDICON    = "유닛의 공격대\n아이콘을 표시합니다.";
SMARTDEBUFF_TT_SHOWROLEICON    = "탱커/힐러 역할 아이콘을 표시합니다.\n(공격대 아이콘이 없을 경우)";
SMARTDEBUFF_TT_SHOWROLEDPSICON    = "딜러 역할 아이콘을 표시합니다.\n(공격대 아이콘이 없을 경우)";
SMARTDEBUFF_TT_SHOWSPELLICON   = "유닛에 HoT\n아이콘을 표시합니다.";
SMARTDEBUFF_TT_INFOROW         = "간결한 정보 바를 표시합니다 (공격대에서만):\n플레이어/사망/자리 비움/오프라인\n생명력/마나\n준비된 플레이어\n(공격대에서만)";
SMARTDEBUFF_TT_GLOBALSAVE      = "설정이 전역 저장소에 저장되었습니다.";
SMARTDEBUFF_TT_GLOBALLOAD      = "설정이 전역 저장소에서 불러와졌습니다.";
SMARTDEBUFF_TT_ROLE            = "역할 순서대로\n유닛 버튼을 표시합니다.";
SMARTDEBUFF_TT_ADVANCHORS      = "디버프 프레임의\n고급 앵커 설정을 표시하고 사용합니다.";
SMARTDEBUFF_TT_STOPCAST        = "현재 시전 중이거나 정신 집중 중인\n주문을 즉시 중단하고\n설정된 주문을 시전합니다.\n(해제 주문에만 해당)";
SMARTDEBUFF_TT_IGNOREDEBUFF    = "해제 주문이 재사용 대기 중일 경우\n유닛의 디버프를 무시합니다.";
SMARTDEBUFF_TT_CHATNOTIF       = "불러올 때 채팅 알림을 표시합니다.";

--SMARTDEBUFF_TT_COLUMNS         = "열";
--SMARTDEBUFF_TT_INTERVAL        = "간격";
--SMARTDEBUFF_TT_FONTSIZE        = "글꼴 크기";
--SMARTDEBUFF_TT_WIDTH           = "너비";
--SMARTDEBUFF_TT_HEIGHT          = "높이";
--SMARTDEBUFF_TT_BARHEIGHT       = "막대 높이";
--SMARTDEBUFF_TT_OPACITYNORMAL   = "사거리 내 투명도";
--SMARTDEBUFF_TT_OPACITYOOR      = "사거리 밖 투명도";
--SMARTDEBUFF_TT_OPACITYDEBUFF   = "디버프 투명도";

-- Tooltip text key bindings
SMARTDEBUFF_TT_DROP            = "놓기";
SMARTDEBUFF_TT_DROPINFO        = "주문/아이템/매크로를 주문책/가방에서 여기로 드래그하세요.\n|cff00ff00좌클릭으로 대상 기능을 설정합니다.\nShift-좌클릭으로 메뉴 기능을 설정합니다.";
SMARTDEBUFF_TT_SPELLACTIONS    = "주문 클릭:\n 좌클릭: 가져오기\n Shift-좌클릭: 복제\n 우클릭: 삭제";
SMARTDEBUFF_TT_ITEMACTIONS     = "아이템 클릭:\n 좌클릭: 가져오기\n Shift-좌클릭: 복제\n 우클릭: 삭제";
SMARTDEBUFF_TT_MACROACTIONS    = "매크로 클릭:\n 좌클릭: 가져오기\n Shift-좌클릭: 복제\n 우클릭: 삭제";
SMARTDEBUFF_TT_TARGET          = "대상";
SMARTDEBUFF_TT_TARGETINFO      = "지정된 유닛을\n현재 대상으로 선택합니다.";
SMARTDEBUFF_TT_PETACTION       = "야수 행동";
SMARTDEBUFF_TT_NOTFOUND        = "오류: 주문을 찾을 수 없습니다";
SMARTDEBUFF_TT_MISSINGINFO     = "전문화 / 특성 / 야수를 확인하세요.";
SMARTDEBUFF_TT_NOTMOVABLE      = "전문화로 이동할 수 없습니다.";
SMARTDEBUFF_TT_TARGETACTIONS   = "마우스 클릭:\n 우클릭: 삭제";
SMARTDEBUFF_TT_PETACTIONS      = "야수 행동:\n삭제할 수 없습니다!";
SMARTDEBUFF_TT_MENU            = "메뉴";
SMARTDEBUFF_TT_MENUINFO        = "유닛 옵션 메뉴를 엽니다.";
SMARTDEBUFF_TT_PICKMENU        = "마우스 클릭:\n 우클릭: 삭제";
SMARTDEBUFF_TT_DROPABBLE       = "마우스 클릭:\n 좌클릭: 놓기\n 우클릭: 해제";
SMARTDEBUFF_TT_DROPREPLACE     = "마우스 클릭:\n 좌클릭: 교체\n 우클릭: 해제";
SMARTDEBUFF_TT_DROPEXCHANGE    = "마우스 클릭:\n 좌클릭: 교환\n 우클릭: 해제";
SMARTDEBUFF_TT_CANTDROP        = "마우스 클릭:\n 우클릭: 해제";

SMARTDEBUFF_INFO_READY         = "플레이어:\n생명력 %:\n마나 %:\n사망:\n자리 비움:\n오프라인:\n준비됨:";
SMARTDEBUFF_INFO               = "플레이어:\n생명력 %:\n마나 %:\n사망:\n자리 비움:\n오프라인";

--Tooltips added by Semi#1287
SMARTDEBUFF_TT_OPTIONS          = "|cff20d2ff- O 버튼 -|r\n좌클릭: 옵션 열기\n우클릭: 단축키 수정";
SMARTDEBUFF_OFT_CLASSSORT       = "직업 정렬 목록";
SMARTDEBUFF_TT_CLASSSORT 	      = "클릭하여 직업 순서 변경";
SMARTDEBUFF_OFT_NOTREMOVABLE_LIST = "해제 불가 디버프 목록";
SMARTDEBUFF_TT_NOTREMOVABLE_LIST 	= "클릭하여 목록 수정";
SMARTDEBUFF_OFT_SKILLS          = "마우스 단축키";
SMARTDEBUFF_TT_SKILLS           = "클릭하여 단축키 수정\n(좌/우/중 클릭, Alt/Shift/Ctrl 포함)";
SMARTDEBUFF_TT_RESET_SKILLS     = "현재 직업의 단축키를 초기화합니다.";
SMARTDEBUFF_OFT_SHOWDEBUFFGUARD	= "주문 추적 목록";
SMARTDEBUFF_TT_SHOWDEBUFFGUARD  = "클릭하여 추적할\n주문 목록 수정";
SMARTDEBUFF_TT_SOUNDLIST        = "클릭하여 소리 선택.\n(우클릭: 미리 듣기)";

-- Tooltip support
SMARTDEBUFF_FUBAR_TT           = "\n좌클릭: 옵션 열기\nShift-좌클릭: 켜기/끄기";
SMARTDEBUFF_BROKER_TT          = "좌클릭: 옵션 열기\n우클릭: 켜기/끄기";

SMARTDEBUFF_ERR_RELOADREQUIRED  = [[클릭 기능을 사용하려면 재접속 (/reload)이 필요할 수 있습니다.]];
