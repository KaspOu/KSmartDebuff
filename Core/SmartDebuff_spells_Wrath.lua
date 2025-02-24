--@do-not-package@
--[[
List dispels: https://warcraft.wiki.gg/wiki/Magic_(dispel_type)
Class Dispels : https://www.wowhead.com/wotlk/spells/abilities/druid?filter=109;38;0
Talents dispels: https://www.wowhead.com/wotlk/spells/talents?filter=109;38;0
https://wago.tools/db2/SpellDispelType

Tests your spells:
https://www.wowhead.com/spell=526
https://www.wowhead.com/wotlk/spell=2870

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

SMARTDEBUFF_SPELLS_VERSION = "WotLK";
SMARTDEBUFF_MACROTEXT = true;

-- Debuff spell IDs (for L button)
SMARTDEBUFF_CLASS_DISPELS_LIST_ID = {
  ["DRUID"]  = {
    { -- Remove Corruption (1+)
      Spell_ID = 2782,
      Spell_List = {SMARTDEBUFF_CURSE},
    },
  },

  ["PALADIN"] = {
    { -- Cleanse (1+)
      Spell_ID = 4987,
      Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_DISEASE, SMARTDEBUFF_POISON},
    },
    { -- Purify, under level 40? (1-3)
      Spell_ID = 1152,
      Spell_List = {SMARTDEBUFF_DISEASE, SMARTDEBUFF_POISON},
    },
  },

  ["PRIEST"] = {
    { -- Dispel Magic, will be named Purify (1-4)
      Spell_ID = 527,
      Spell_List = {SMARTDEBUFF_MAGIC},
    },
    -- { -- Cure Disease, will be changed to Dispel Magic (1-4)
    --   Spell_ID = 528,
    --   Spell_List = {SMARTDEBUFF_DISEASE},
    -- },
  },

  ["SHAMAN"] = {
    { -- Cleanse Spirit (3+)
      Spell_ID = 51886,
      Spell_List = {SMARTDEBUFF_CURSE, SMARTDEBUFF_DISEASE, SMARTDEBUFF_POISON},
    },
    { -- Cure Toxins, under level 40, was Cure Poison (3)
      Spell_ID = 526,
      Spell_List = {SMARTDEBUFF_DISEASE, SMARTDEBUFF_POISON},
    },
  },

  ["MAGE"] = {
    { -- Remove Curse
      Spell_ID = 475,
      Spell_List = {SMARTDEBUFF_CURSE},
    },
  },

  ["WARLOCK"] = {
    -- Devour Magic, pet Felhunter All ranks from 7 to 1 (2-3)
    { Spell_ID = 67518, Spell_List = {SMARTDEBUFF_MAGIC}, Spell_Type = "petaction", },
    { Spell_ID = 48011, Spell_List = {SMARTDEBUFF_MAGIC}, Spell_Type = "petaction", },
    { Spell_ID = 27277, Spell_List = {SMARTDEBUFF_MAGIC}, Spell_Type = "petaction", },
    { Spell_ID = 27276, Spell_List = {SMARTDEBUFF_MAGIC}, Spell_Type = "petaction", },
    { Spell_ID = 19736, Spell_List = {SMARTDEBUFF_MAGIC}, Spell_Type = "petaction", },
    { Spell_ID = 19734, Spell_List = {SMARTDEBUFF_MAGIC}, Spell_Type = "petaction", },
    { Spell_ID = 19731, Spell_List = {SMARTDEBUFF_MAGIC}, Spell_Type = "petaction", },
    { Spell_ID = 19505, Spell_List = {SMARTDEBUFF_MAGIC}, Spell_Type = "petaction", },
  },
}

-- Possible buttons : R, M, AL
SMARTDEBUFF_CLASS_SKILLS_LIST_ID = {
  ["DRUID"]  = {
    { Spell_ID = 8946,   Button = "R", Types = {SMARTDEBUFF_POISON} }, -- Cure Poison (1-3)
    { Spell_ID = 2893,   Button = "R", Types = {SMARTDEBUFF_POISON} }, -- Abolish Poison (1-3)
    { Spell_ID = 774,   Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Rejuvenation (1+)
  },
  ["PALADIN"]  = {
    { Spell_ID = 20066, Button = "R", Types = {SMARTDEBUFF_CHARMED} }, -- Repentance (1+)
    { Spell_ID = 1022,  Button = "M", Types = {SMARTDEBUFF_UTIL} }, --  Blessing of protection (1+)
    { Spell_ID = 19750, Button = "AL", Types = {SMARTDEBUFF_HEAL} }, --  Flash of light (1+)
  },
  ["PRIEST"]  = {
    { Spell_ID = 528,   Button = "R", Types = {SMARTDEBUFF_DISEASE} }, -- Cure Disease, will be changed to Dispel Magic (1-4)
    { Spell_ID = 552,   Button = "R", Types = {SMARTDEBUFF_DISEASE} }, -- Abolish Disease (1-3)
    { Spell_ID = 64044,   Button = "M", Types = {SMARTDEBUFF_CHARMED} }, -- Psychic horror (3+)
    { Spell_ID = 2061,   Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Flash heal (1+)
    { Spell_ID = 139,   Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Renew (1+)
    { Spell_ID = 17,    Button = "AM", Types = {SMARTDEBUFF_UTIL} }, -- Power word shield (1+)
  },
  ["SHAMAN"]  = {
    { Spell_ID = 51514, Button = "R", Types = {SMARTDEBUFF_CHARMED} }, -- Hex (3+)
    { Spell_ID = 974,   Button = "M", Types = {SMARTDEBUFF_UTIL} }, -- Earth shield (1+)
    { Spell_ID = 331,  Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Healing wave (1-4)
    { Spell_ID = 8004,  Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Healing surge (1+)
  },
  
  ["DEATHKNIGHT"]  = {
    { Spell_ID = 45524, Button = "R", Types = {SMARTDEBUFF_CHARMED} }, -- Chains of ice (3+) 
    { Spell_ID = 47541, Button = "M", Types = {SMARTDEBUFF_HEAL} }, -- Death Coil (3+)   
  },
  ["HUNTER"]  = {
    { Spell_ID = 34477, Button = "M", Types = {SMARTDEBUFF_MISDIRECT} }, -- Misdirection (2+)
  }, 
  ["MAGE"]  = {
    { Spell_ID = 118,   Button = "R", Types = {SMARTDEBUFF_CHARMED} }, -- Polymorph (1+)
    { Spell_ID = 130,   Button = "M", Types = {SMARTDEBUFF_UTIL} }, -- Slow fall (1+)
  }, 
  ["ROGUE"]  = {
    { Spell_ID = 2094,  Button = "R", Types = {SMARTDEBUFF_CHARMED} }, -- Blind (1+)
    { Spell_ID = 57934, Button = "M", Types = {SMARTDEBUFF_MISDIRECT} }, -- Tricks of the Trade (3+)
  },
  ["WARLOCK"]  = {
    { Spell_ID = 20707,  Button = "R", Types = {SMARTDEBUFF_UTIL} }, -- Soulstone (1+)
  },
  ["WARRIOR"]  = {
    { Spell_ID = 3411,  Button = "R", Types = {SMARTDEBUFF_UTIL} }, -- Intervene (2+)
  },
}

SMARTDEBUFF_OVERRIDE_PICKUP_LIST_ID = {}

SMARTDEBUFF_DISABLED_SOUNDS = "\
Diiing\
Follower Level Up\
Lightning\
Lightning 2\
Lightning 3\
Pet Level Up\
";