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
    { Spell_ID = 5697,  Button = "M", Types = {SMARTDEBUFF_UTIL} }, -- Unending Breath (1+)
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

SMARTDEBUFF_DISABLED_TEXTURES = "\
Skull 2\
Cleanse\
Air\
Fire\
Fireball\
Potion\
Runes\
Sha\
Storm\
Web\
";

SMARTDEBUFF_DEBUFFS_LIST = {
  -- Generic / Outside instances / PvP
  [0] = {
    __name = PVP,
    __type = SETTINGS_DEFAULTS,
    __ext = "",
    -- DEATH KNIGHT
    [55095]  = SMARTDEBUFF_DISEASE,  -- Frost Fever
    [55078]  = SMARTDEBUFF_DISEASE,  -- Blood Plague

    -- DRUID
    [48463]  = SMARTDEBUFF_MAGIC,    -- Moonfire
    [48468]  = SMARTDEBUFF_MAGIC,    -- Insect Swarm
    [49800]  = SMARTDEBUFF_BLEEDING, -- Rip
    [48574]  = SMARTDEBUFF_BLEEDING, -- Rake
    [339]    = SMARTDEBUFF_MAGIC,    -- Entangling Roots

    -- HUNTER
    [49001]  = SMARTDEBUFF_POISON,   -- Serpent Sting
    [14309]  = SMARTDEBUFF_MAGIC,    -- Freezing Trap Effect
    [19503]  = SMARTDEBUFF_MAGIC,    -- Scatter Shot
    [49012]  = SMARTDEBUFF_MAGIC,    -- Wyvern Sting
    [34490]  = SMARTDEBUFF_MAGIC,    -- Silencing Shot

    -- MAGE
    [12826]  = SMARTDEBUFF_MAGIC,    -- Polymorph
    [42917]  = SMARTDEBUFF_MAGIC,    -- Frost Nova
    [33395]  = SMARTDEBUFF_MAGIC,    -- Freeze
    [31661]  = SMARTDEBUFF_MAGIC,    -- Dragon's Breath
    [44572]  = SMARTDEBUFF_MAGIC,    -- Deep Freeze
    [18469]  = SMARTDEBUFF_MAGIC,    -- Improved Counterspell

    -- PALADIN
    [10308]  = SMARTDEBUFF_MAGIC,    -- Hammer of Justice
    [20066]  = SMARTDEBUFF_MAGIC,    -- Repentance

    -- PRIEST
    [8122]   = SMARTDEBUFF_MAGIC,    -- Psychic Scream
    [605]    = SMARTDEBUFF_MAGIC,    -- Mind Control
    [15487]  = SMARTDEBUFF_MAGIC,    -- Silence
    [64044]  = SMARTDEBUFF_MAGIC,    -- Psychic Horror
    [9484]   = SMARTDEBUFF_MAGIC,    -- Shackle Undead

    -- ROGUE
    [2094]   = SMARTDEBUFF_MAGIC,    -- Blind
    [6770]   = SMARTDEBUFF_MAGIC,    -- Sap
    [1833]   = SMARTDEBUFF_MAGIC,    -- Cheap Shot
    [8643]   = SMARTDEBUFF_MAGIC,    -- Kidney Shot
    [1776]   = SMARTDEBUFF_MAGIC,    -- Gouge
    [1330]   = SMARTDEBUFF_MAGIC,    -- Garrote - Silence

    -- SHAMAN
    [51514]  = SMARTDEBUFF_MAGIC,    -- Hex

    -- WARLOCK
    [5782]   = SMARTDEBUFF_MAGIC,    -- Fear
    [47860]  = SMARTDEBUFF_MAGIC,    -- Death Coil
    [6358]   = SMARTDEBUFF_MAGIC,    -- Seduction
    [5484]   = SMARTDEBUFF_MAGIC,    -- Howl of Terror
    [30283]  = SMARTDEBUFF_MAGIC,    -- Shadowfury
    [31117]  = SMARTDEBUFF_MAGIC,    -- Unstable Affliction Silence

    -- WARRIOR
    [5246]   = SMARTDEBUFF_MAGIC,    -- Intimidating Shout
    [12809]  = SMARTDEBUFF_MAGIC,    -- Concussion Blow
    [20253]  = SMARTDEBUFF_MAGIC,    -- Intercept Stun
    [7922]   = SMARTDEBUFF_MAGIC,    -- Charge Stun
  }
}