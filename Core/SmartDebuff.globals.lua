-------------------------------------------------------------------------------
-- Globals
-------------------------------------------------------------------------------

SMARTDEBUFF_VERSION       = "v"..C_AddOns.GetAddOnMetadata("SmartDebuff", "Version"); -- "v10.0.202"
SMARTDEBUFF_VERSIONNR     = tonumber(gsub(SMARTDEBUFF_VERSION, "%D", ""), 10); -- "100202"
SMARTDEBUFF_BREAKINGVERSION = 102602;
SMARTDEBUFF_TITLE         = "SmartDebuff";
SMARTDEBUFF_HEADERS        = {"SmartDebuff", "martDebuff"}
SMARTDEBUFF_SUBTITLE      = "Debuff support";
SMARTDEBUFF_DESC          = "Supports you to cast debuff spells on friendly units";
SMARTDEBUFF_VERS_TITLE    = SMARTDEBUFF_TITLE .. " " .. SMARTDEBUFF_VERSION;
SMARTDEBUFF_OPTIONS_TITLE = SMARTDEBUFF_VERS_TITLE .. " Options";

SMARTDEBUFF_IS_RETAIL = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE);
SMARTDEBUFF_MACROTEXT = false;
SMARTDEBUFF_KEYFORCLICK = GetCVar("ActionButtonUseKeyDown") == "0" and "AnyUp" or "AnyDown"

BINDING_HEADER_SMARTDEBUFF = SMARTDEBUFF_TITLE;
BINDING_NAME_SMARTDEBUFF =  SMARTDEBUFF_TITLE.." options";
SMARTDEBUFF_BOOK_TYPE_SPELL = "spell";

--@do-not-package@
-- Development icons
local devVer = "|TInterface/PVPFrame/Icons/prestige-icon-8-3:16|t"
SMARTDEBUFF_OPTIONS_TITLE = SMARTDEBUFF_VERS_TITLE ..devVer.. " Options"
SMARTDEBUFF_HEADERS = { SMARTDEBUFF_HEADERS[1]..devVer, SMARTDEBUFF_HEADERS[2]..devVer }
--@end-do-not-package@


-- wowversion, wowbuild, wowdate, wowtocversion = GetBuildInfo()
SMARTDEBUFF_BACKDROP_OPTIONS = {
  bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
  tile = true,
  tileSize = 8,
  edge = true,
  edgeSize = 8,
  insets = {left = 2, right = 2, top = 2, bottom = 2},
};
SMARTDEBUFF_BACKDROP_TOOLTIP = {
  bgFile = "Interface\\Tooltips\\UI-Tooltip-Border",
  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
  tile = true,
  tileSize = 4,
  edge = true,
  edgeSize = 4,
  insets = {left = 1, right = 1, top = 1, bottom = 1},
};

SMARTDEBUFF_TTC_R = 1.0;
SMARTDEBUFF_TTC_G = 0.82;
SMARTDEBUFF_TTC_B = 0.0;
SMARTDEBUFF_TTC_A = 1.0;

SMARTDEBUFF_OF_HEIGHT = 500;
SMARTDEBUFF_OF_WIDTH = 500;

-- Debuff types
SMARTDEBUFF_DISEASE = "Disease";
SMARTDEBUFF_MAGIC   = "Magic";
SMARTDEBUFF_POISON  = "Poison";
SMARTDEBUFF_CURSE   = "Curse";
SMARTDEBUFF_CHARMED = "Mind Control";
SMARTDEBUFF_BLEEDING   = "Bleeding"; -- Not a really debuff type

SMARTDEBUFF_HEAL    = "Heal";
SMARTDEBUFF_UTIL    = "Utility";
SMARTDEBUFF_MISDIRECT = "Threat redirect";

SMARTDEBUFF_FRIENDLY_CAST = "Fallback"

SMARTDEBUFF_WARLOCK_CMD_DEMON = 119898;
SMARTDEBUFF_HUNTERSMARK_ICONID = 132212; -- spell 1130

--@do-not-package@
--[[
List dispels: https://warcraft.wiki.gg/wiki/Magic_(dispel_type)
ALL Dispels : https://www.wowhead.com/spells?filter=109;38;0
Class Dispels only: https://www.wowhead.com/spells/specialization?filter=109;38;0
Talents dispels: https://www.wowhead.com/spells/talents?filter=109;38;0
https://wago.tools/db2/SpellDispelType

SMARTDEBUFF_CLASS_DISPELS_LIST_ID
  Format: [ClassName] = { { Spell_ID, Spell_List, OnlyIfUsable?, Improved_Talent?, Improved_Spell_List?, } }
  Priority: first active spell > first inactive talent > first item

SMARTDEBUFF_CLASS_SKILLS_LIST_ID
  Format: [ClassName] = { Spell_ID, Button, Types }
  You can declare multiple lines with the same Button,
  first spell will only be overloaded if the following spell is active
  Priority: last active > first item

SMARTDEBUFF_OVERRIDE_PICKUP_LIST_ID
  Format: [pickupType] = { [pickupID] = {overridenPickupType, overridenPickupID }, }
]]--
--@end-do-not-package@

-- Overriden vars in SmartDebuff_spells[_Project].lua
SMARTDEBUFF_SPELLS_VERSION = ""
SMARTDEBUFF_CLASS_DISPELS_LIST_ID = {}
SMARTDEBUFF_CLASS_SKILLS_LIST_ID = {}
SMARTDEBUFF_OVERRIDE_PICKUP_LIST_ID = {}
--

-- Global Ordered Keys List
SMARTDEBUFF_ORDER_KEYS = {"L", "R", "M", "SL", "SR", "SM", "AL", "AR", "AM", "CL", "CR", "CM"};

-- Effects ignore list
SMARTDEBUFF_DEBUFFSKIP_NAME = { };
SMARTDEBUFF_DEBUFFSKIP_ID = {
  [ 1] = 15822, --Dreamless Sleep
	[ 2] = 24360, --Greater Dreamless Sleep
	[ 3] = 28504, --Major Dreamless Sleep
	[ 4] = 2096,  --Mind Vision
	[ 5] = 28169, --Mutating Injection
  [ 6] = 710,   --Banish
  [ 7] = 4511,  --Phase Shift
  [ 8] = 30451, --Arcane Blast
  [ 9] = 30108, --Unstable Affliction
  [10] = 13810, --Frost Trap Aura
  [11] = 30108, --Unstable Affliction
  [12] = 19372, --Ancient Hysteria
  [13] = 19659, --Ignite Mana
  [14] = 16567, --Tainted Mind
  [15] = 28732, --Widow's Embrace
  [16] = 24306, --Delusions of Jin'do
  [17] = 15487, --Silence
  [18] = 1714,  --Curse of Tongues
  [19] = 29904, --Sonic Burst
  [20] = 19496, --Magma Shackles
  [21] = 33787, --Cripple
  [22] = 26072, --Dust Cloud
  [23] = 30633, --Thunderclap
};

-- Global ignore list
SMARTDEBUFF_DEBUFFSKIPLIST = { };
SMARTDEBUFF_DEBUFFSKIPLIST_ID = {1,2,3,4,5,6,7,8,9,10};

-- Class ignore list
SMARTDEBUFF_DEBUFFCLASSSKIPLIST = { };
SMARTDEBUFF_DEBUFFCLASSSKIPLIST_ID = {
	["WARRIOR"] = {12,13,14,15,16};
	["ROGUE"]   = {12,13,14,15,16,17,18,19};
	["HUNTER"]  = {16,20};
	["MAGE"]    = {16,20,21,22,23};
	["WARLOCK"] = {16,21,22,23};
	["DRUID"]   = {16,22,23};
	["PRIEST"]  = {16,21,22,23};
	["PALADIN"] = {16,22};
	["SHAMAN"]  = {16,22};
	["DEATHKNIGHT"] = {16,22};
	["MONK"] = {16,22};
	["DEMONHUNTER"] = {16,22};
	["EVOKER"] = {16,22};
};

--[[
Prowl 5215
Stealth 1784
Shadowmeld 20580
Invisibility 66
Lesser Invisibility 7870
]]--


SMARTDEBUFF_NOTREMOVABLE_ID = {
  39837, --Impaling Spine (Naj'entus)
  40239, --Incinerate (Teron)
  --40243, --Crushing Shadows (Teron)
  42005, --Bloodboil (Gurtogg)
  40604, --Fel Rage (Gurtogg)
  41001, --Fatal Attraction (Mother Shahraz)
  40860, --Vile Beam (Mother Shahraz)
  41485, --Deadly Poison (Veras Darkshadow, Illidari Council)
  40932, --Agonizing Flames (Illidan)
  41917, --Parasitic Shadowfiend (Illidan)
  40585, --Dark Barrage (Illidan)
  31249, --Icebolt (Winterchill)
  31340, --Rain of Fire (Azgalor)
  31944, --Doomfire (Archimonde)
  45141, --Burn (Brutallus)
  46008, --Negative Energy (Muru)
  38235, --Water Tomb (Hydross)
  38049, --Watery Grave (Morogrim)
};

-- https://wowpedia.fandom.com/wiki/API_PlaySoundFile
SMARTDEBUFF_SOUNDS = {
  {"Alarm Clock 1", 567436},
  {"Alarm Clock 2", 567399},
  {"Alarm Clock 3", 567458},
  {"Anti Holy", 568986},
  {"Artifact forge: Gold trait", 1489541},
  {"Artifact forge: Refund end", 1600379},
  {"Artifact forge: Trait available", 1272545},
  {"Artifact forge: Relic place", 1272543},
  {"Ashran player looted", 1053672},
  {"Auction House", 567482},
  {"Bell Alliance", 566564},
  {"Bell Horde", 565853},
  {"Bell Karazhan", 566254},
  {"Bell Night Elf", 566558},
  {"Bell Tribal", 566027},
  {"Cartoon FX", 566543},
  {"Cheer", 567283},
  {"Diiing", 554922},
  {"Explosion", 566982},
  {"Fel Nova", 568582},
  {"Fel Portal", 569215},
  {"Follower Level Up", 1068310},
  {"Friend Join", 567518},
  {"Glyph: Minor Create", 567487},
  {"Glyph: Minor Destroy", 567447},
  {"Gong Troll", 565564},
  {"Humm", 569518},
  {"Level Up", 567431},
  {"Lightning", 2182425},
  {"Lightning 2", 2182424},
  {"Lightning 3", 2182423},
  {"Loot Chime", 567435},
  {"Magic Click", 567455},
  {"Mellow Bells", 568154},
  {"Murloc", 556000},
  {"Pet Level Up", 642841},
  {"Put down Gems", 567574},
  {"Pick up Gems", 567568},
  {"Pick up Wand", 567544},
  {"QuestFailed", 567459},
  {"RaidWarning", 567397},
  {"Ready Check", 567478},
  {"Reputation Level Up", 568016},
  {"Rubber Ducky", 566121},
  {"Shing", 566240},
  {"Short Circuit", 568975},
  {"Simon Chime", 566076},
  {"Simon Tick", 568232},
  {"Spell", 4614157},
  {"SpiritWolf", 569026},
  {"Sunflower", 567374},
  {"Teleport", 569735},
  {"War Drums", 567275},
  {"Wham", 566946},
  {"Whisper Ping", 567421},
};
SMARTDEBUFF_DISABLED_SOUNDS = "";

SMARTDEBUFF_SOUNDS_DEFAULT = 567447 -- Glyph: Minor Destroy