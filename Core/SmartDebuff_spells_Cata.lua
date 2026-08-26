--@do-not-package@
--[[
List dispels: https://warcraft.wiki.gg/wiki/Magic_(dispel_type)
Class Dispels : https://www.wowhead.com/cata/spells/abilities/druid?filter=109;38;0
Talents dispels: https://www.wowhead.com/cata/spells/talents?filter=109;38;0
Class Active Talents: https://www.wowhead.com/cata/fr/spells/talents/druid?filter=50;2;0
https://wago.tools/db2/SpellDispelType

Tests your spells:
https://www.wowhead.com/spell=526
https://www.wowhead.com/cata/spell=2870

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

SMARTDEBUFF_SPELLS_VERSION = "Cataclysm";
SMARTDEBUFF_MACROTEXT = true;

-- Debuff spell IDs (for L button)
SMARTDEBUFF_CLASS_DISPELS_LIST_ID = {
  ["DRUID"]  = {
    { -- Remove Corruption (1+)
      Spell_ID = 2782,
      Spell_List = {SMARTDEBUFF_CURSE, SMARTDEBUFF_POISON},
      Improved_Talent = 88423, -- Nature's Cure, will be changed to spell in DF (4-9)
      Improved_Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_CURSE, SMARTDEBUFF_POISON},
    },
  },

  ["PALADIN"] = {
    { -- Cleanse (1+)
      Spell_ID = 4987,
      Spell_List = {SMARTDEBUFF_DISEASE, SMARTDEBUFF_POISON},
      Improved_Talent = 53551, -- Sacred Cleansing (4-9)
      Improved_Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_DISEASE, SMARTDEBUFF_POISON},
    },
  },

  ["PRIEST"] = {
    { -- Dispel Magic, will be named Purify (1-4)
      Spell_ID = 527,
      Spell_List = {SMARTDEBUFF_MAGIC},
    },
  },

  ["SHAMAN"] = {
    { -- Cleanse Spirit (3+)
      Spell_ID = 51886,
      Spell_List = {SMARTDEBUFF_CURSE},
      Improved_Talent = 77130, -- Improved Cleanse Spirit, will be changed to spell in DF (4-9)
      Improved_Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_CURSE},
    },
  },

  ["MAGE"] = {
    { -- Remove Curse
      Spell_ID = 475,
      Spell_List = {SMARTDEBUFF_CURSE},
    },
  },

  ["WARLOCK"] = {
    { -- Singe Magic (4+), pet (imp)
      Spell_ID = 89808,
      Spell_List = {SMARTDEBUFF_MAGIC},
      Spell_Type = "petaction",
    },
    -- 19505 - Devour Magic, pet Felhunter (2-3), only enemies since
  },
}

-- Possible buttons : R, M, AL
SMARTDEBUFF_CLASS_SKILLS_LIST_ID = {
  ["DRUID"]  = {
    { Spell_ID = 774,   Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Rejuvenation (1+)
    -- 8946 - Cure Poison (1-3)
    -- 2893 - Abolish Poison (1-3)
  },
  ["PALADIN"]  = {
    { Spell_ID = 20066, Button = "R", Types = {SMARTDEBUFF_CHARMED} }, -- Repentance (1+)
    { Spell_ID = 1022,  Button = "M", Types = {SMARTDEBUFF_UTIL} }, --  Blessing of protection (1+)
    { Spell_ID = 19750, Button = "AL", Types = {SMARTDEBUFF_HEAL} }, --  Flash of light (1+)
  },
  ["PRIEST"]  = {
    { Spell_ID = 528,   Button = "R", Types = {SMARTDEBUFF_DISEASE} }, -- Cure Disease, will be changed to Dispel Magic (1-4)
    { Spell_ID = 64044,   Button = "M", Types = {SMARTDEBUFF_CHARMED} }, -- Psychic horror (3+)
    { Spell_ID = 2061,   Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Flash heal (1+)
    { Spell_ID = 139,   Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Renew (1+)
    { Spell_ID = 17,    Button = "AM", Types = {SMARTDEBUFF_UTIL} }, -- Power word shield (1+)
    { Spell_ID = 73325, Button = "AR", Types = {SMARTDEBUFF_UTIL} }, -- Leap of Faith (4+)
    -- 552 - Abolish Disease (1-3)
  },
  ["SHAMAN"]  = {
    { Spell_ID = 51514, Button = "R", Types = {SMARTDEBUFF_CHARMED} }, -- Hex (3+)
    { Spell_ID = 974,   Button = "M", Types = {SMARTDEBUFF_UTIL} }, -- Earth shield (1+)
    { Spell_ID = 331,  Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Healing wave (1-4)
    { Spell_ID = 8004,  Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Healing surge (1+)
    -- 2870 - Cure Disease (1-2)
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
    { Spell_ID = 5232, Spell_Type = "item", Button = "R", Types = {SMARTDEBUFF_UTIL} }, -- Soulstone (1+)
    { Spell_ID = 5697,  Button = "M", Types = {SMARTDEBUFF_UTIL} }, -- Unending Breath (1+)
  },
  ["WARRIOR"]  = {
    { Spell_ID = 3411,  Button = "R", Types = {SMARTDEBUFF_UTIL} }, -- Intervene (2+)
  },
}

SMARTDEBUFF_OVERRIDE_PICKUP_LIST_ID = {}

SMARTDEBUFF_DISABLED_SOUNDS = "\
Artifact forge: Gold trait\
Artifact forge: Refund end\
Artifact forge: Trait available\
Artifact forge: Relic place\
Ashran player looted\
Follower Level Up\
Lightning\
Lightning 2\
Lightning 3\
Pet Level Up\
Spell\
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
    -- DEATH KNIGHT
    [55095]  = SMARTDEBUFF_DISEASE,  -- Frost Fever
    [55078]  = SMARTDEBUFF_DISEASE,  -- Blood Plague

    -- DRUID
    [8921]   = SMARTDEBUFF_MAGIC,    -- Moonfire
    [93402]  = SMARTDEBUFF_MAGIC,    -- Sunfire
    [5570]   = SMARTDEBUFF_MAGIC,    -- Insect Swarm
    [1079]   = SMARTDEBUFF_BLEEDING, -- Rip
    [1822]   = SMARTDEBUFF_BLEEDING, -- Rake
    [339]    = SMARTDEBUFF_MAGIC,    -- Entangling Roots

    -- HUNTER
    [1978]   = SMARTDEBUFF_POISON,   -- Serpent Sting
    [3355]   = SMARTDEBUFF_MAGIC,    -- Freezing Trap
    [213691] = SMARTDEBUFF_MAGIC,    -- Scatter Shot

    -- MAGE
    [118]    = SMARTDEBUFF_MAGIC,    -- Polymorph
    [122]    = SMARTDEBUFF_MAGIC,    -- Frost Nova
    [31661]  = SMARTDEBUFF_MAGIC,    -- Dragon's Breath
    [2139]   = SMARTDEBUFF_MAGIC,    -- Counterspell
    [82691]  = SMARTDEBUFF_MAGIC,    -- Ring of Frost
    [12654]  = SMARTDEBUFF_MAGIC,    -- Ignite
    [2120]   = SMARTDEBUFF_MAGIC,    -- Flamestrike

    -- PALADIN
    [853]    = SMARTDEBUFF_MAGIC,    -- Hammer of Justice
    [20066]  = SMARTDEBUFF_MAGIC,    -- Repentance
    [197277] = SMARTDEBUFF_MAGIC,    -- Judgment

    -- PRIEST
    [605]    = SMARTDEBUFF_MAGIC,    -- Mind Control
    [8122]   = SMARTDEBUFF_MAGIC,    -- Psychic Scream
    [15487]  = SMARTDEBUFF_MAGIC,    -- Silence
    [589]    = SMARTDEBUFF_MAGIC,    -- Shadow Word: Pain
    [34914]  = SMARTDEBUFF_MAGIC,    -- Vampiric Touch

    -- ROGUE
    [2818]   = SMARTDEBUFF_POISON,   -- Deadly Poison
    [3409]   = SMARTDEBUFF_POISON,   -- Crippling Poison
    [5760]   = SMARTDEBUFF_POISON,   -- Mind-Numbing Poison
    [703]    = SMARTDEBUFF_BLEEDING, -- Garrote
    [1943]   = SMARTDEBUFF_BLEEDING, -- Rupture

    -- SHAMAN
    [51514]  = SMARTDEBUFF_MAGIC,    -- Hex
    [188389] = SMARTDEBUFF_MAGIC,    -- Flame Shock

    -- WARLOCK
    [5782]   = SMARTDEBUFF_MAGIC,    -- Fear
    [6358]   = SMARTDEBUFF_MAGIC,    -- Seduction
    [30283]  = SMARTDEBUFF_MAGIC,    -- Shadowfury
    [702]    = SMARTDEBUFF_CURSE,    -- Curse of Weakness
    [1714]   = SMARTDEBUFF_CURSE,    -- Curse of Tongues
    [980]    = SMARTDEBUFF_CURSE,    -- Agony
    [172]    = SMARTDEBUFF_MAGIC,    -- Corruption
    [30108]  = SMARTDEBUFF_MAGIC,    -- Unstable Affliction
    [48181]  = SMARTDEBUFF_MAGIC,    -- Haunt

    -- WARRIOR
    [115767] = SMARTDEBUFF_BLEEDING, -- Deep Wounds
    [94009]  = SMARTDEBUFF_BLEEDING, -- Rend
  }
}