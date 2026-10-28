--@do-not-package@
--[[
List dispels: https://warcraft.wiki.gg/wiki/Magic_(dispel_type)
Class Dispels : https://www.wowhead.com/classic/spells/abilities/druid?filter=109;38;0
Talents dispels: https://www.wowhead.com/classic/spells/talents?filter=109;38;0
https://wago.tools/db2/SpellDispelType

https://foreverdb.net/dungeons
https://www.wowhead.com/forever/guides/dungeons

Tests your spells:
https://www.wowhead.com/forever/spell=3604

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

  SMARTDEBUFF_SPELLS_VERSION = "Forever";
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
      { -- Purify (1-3)
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
      { -- Cure Poison, will be changed to Cure Toxins wotk (1-2)
        Spell_ID = 526,
        Spell_List = {SMARTDEBUFF_POISON},
      },
      -- { -- Cure Disease (1-2)
      --   Spell_ID = 2870,
      --   Spell_List = {SMARTDEBUFF_DISEASE},
      -- },
    },

    ["MAGE"] = {
      { -- Remove Greater Curse (SoD)
        Spell_ID = 412113,
        Spell_List = {SMARTDEBUFF_CURSE, SMARTDEBUFF_MAGIC},
        OnlyIfUsable = true,
      },
      { -- Remove Curse
        Spell_ID = 475,
        Spell_List = {SMARTDEBUFF_CURSE},
      },
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
      { Spell_ID = 17,    Button = "M", Types = {SMARTDEBUFF_UTIL} }, -- Power word shield (1+)
      { Spell_ID = 2061,   Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Flash heal (1+)
      { Spell_ID = 139,   Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Renew (1+)
      -- 23859 - NPC Dispel Magic
      -- 28133 - NPC Cure Disease
    },
    ["SHAMAN"]  = {
      { Spell_ID = 2870,   Button = "R", Types = {SMARTDEBUFF_DISEASE} }, -- Cure Disease (1-2)
      { Spell_ID = 974,   Button = "M", Types = {SMARTDEBUFF_UTIL} }, -- Earth shield (1+)
      { Spell_ID = 331,  Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Healing wave (1-4)
      { Spell_ID = 8004,  Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Healing surge (1+)
    },

    ["MAGE"]  = {
      { Spell_ID = 118,   Button = "R", Types = {SMARTDEBUFF_CHARMED} }, -- Polymorph (1+)
      { Spell_ID = 130,   Button = "M", Types = {SMARTDEBUFF_UTIL} }, -- Slow fall (1+)
    },
    ["ROGUE"]  = {
      { Spell_ID = 2094,  Button = "R", Types = {SMARTDEBUFF_CHARMED} }, -- Blind (1+)
    },
    ["WARLOCK"]  = {
      { Spell_ID = 20707,  Button = "R", Types = {SMARTDEBUFF_UTIL} }, -- Soulstone (1+)
      { Spell_ID = 5697,  Button = "M", Types = {SMARTDEBUFF_UTIL} }, -- Unending Breath (1+)
      -- 19476 - NPC Dispel Magic
    },
    ["WARRIOR"]  = {
      { Spell_ID = 3411,  Button = "R", Types = {SMARTDEBUFF_UTIL} }, -- Intervene (1+)
    },
}

SMARTDEBUFF_OVERRIDE_PICKUP_LIST_ID = {}


  SMARTDEBUFF_DEBUFFS_LIST = {
    -- 249 - Onyxia /Raid
    -- 90 - Gnomeregan  24-34?

    
    [-2981] = { -- 60
      __name = "Hyjal Summit",
      __name_frFR = "Sommet d’Hyjal",
      __type = MAP_LEGEND_RAID,
      __ext = "",
    },
    [-3052] = { -- 60
      __name = "Barrow Deeps",
      __name_frFR = "Les profondeurs des Saisons",
      __type = MAP_LEGEND_RAID,
      __ext = "",
    },
    [-3001] = { -- 58 to 60
      __name = "Shaper's Terrace",
      __name_frFR = "La terrasse du Façonneur",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
    },
    [-2994] = { -- 48 to 53
      __name = "Alcaz Prison",
      __name_frFR = "Prison d'Alcaz",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
    },
    [-7] = { -- 55 to 60
      __name = "Blackmaw Hold",
      __name_frFR = "Repaire des Noiregueules",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
    },
    [-8] = { -- 40 to 45
      __name = "Krol'dok Stronghold",
      __name_frFR = "Bastion Krol’dok",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
    },
    [-9] = { -- 35 to 40
      __name = "Sunken City",
      __name_frFR = "La cité Submergée",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
    },
    

    [289] = { -- 58 to 60
      __name = "Scholomance",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [2818]  = SMARTDEBUFF_POISON,   -- deadly-poison
      [9034] = SMARTDEBUFF_MAGIC,    -- immolate
      [20800]  = SMARTDEBUFF_MAGIC,   -- immolate
      [29212] = SMARTDEBUFF_POISON,    -- cripple
      [1224125] = SMARTDEBUFF_MAGIC,    -- silence
      [18327] = SMARTDEBUFF_MAGIC,    -- silence
      [26580] = SMARTDEBUFF_MAGIC,    -- fear
      [12096] = SMARTDEBUFF_MAGIC,    -- fear
      [12542] = SMARTDEBUFF_MAGIC,    -- fear
      [15530] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [17503] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [16799] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [15531] = SMARTDEBUFF_MAGIC,    -- frost-nova
      [14907] = SMARTDEBUFF_MAGIC,     -- Frost Nova
      [11639] = SMARTDEBUFF_MAGIC,    -- shadow-word-pain
      [7645] = SMARTDEBUFF_MAGIC,    -- dominate-mind
      [14515] = SMARTDEBUFF_MAGIC,    -- dominate-mind
      [19776] = SMARTDEBUFF_MAGIC,    -- shadow-word-pain
      [12889] = SMARTDEBUFF_CURSE,    -- curse-of-tongues
      [8994] = SMARTDEBUFF_MAGIC,    -- banish
      [18763] = SMARTDEBUFF_MAGIC,    -- freeze
      [15499] = SMARTDEBUFF_MAGIC,    -- frost-shock
      [7964] = SMARTDEBUFF_MAGIC, -- smoke-bomb

    },
    [329] = { -- 58 to 60
      __name = "Stratholm",
      __name_frFR = "Stratholme",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [21007] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [12741] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [18267] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [14518] = SMARTDEBUFF_MAGIC,    -- crusader-strike
      [29212] = SMARTDEBUFF_POISON,    -- cripple
      [1224125] = SMARTDEBUFF_MAGIC,    -- silence
      [18327] = SMARTDEBUFF_MAGIC,    -- silence
      [26580] = SMARTDEBUFF_MAGIC,    -- fear
      [12096] = SMARTDEBUFF_MAGIC,    -- fear
      [12542] = SMARTDEBUFF_MAGIC,    -- fear
      [15530] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [17503] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [16799] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [15531] = SMARTDEBUFF_MAGIC,    -- frost-nova
      [14907] = SMARTDEBUFF_MAGIC,    -- frost-nova
      [12889] = SMARTDEBUFF_CURSE,    -- curse-of-tongues
      [13338] = SMARTDEBUFF_CURSE,    -- curse-of-tongues
      [17293] = SMARTDEBUFF_MAGIC,    -- burning-winds
      [16867] = SMARTDEBUFF_CURSE,    -- banshee-curse
      [15499] = SMARTDEBUFF_MAGIC,    -- frost-shock
      [7964] = SMARTDEBUFF_MAGIC, -- smoke-bomb
    },
    [229] = { -- 55 to 60
      __name = "Blackrock Spire",
      __name_frFR = "Pic de Rochenoire",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [9034] = SMARTDEBUFF_MAGIC,    -- immolate
      [20800]  = SMARTDEBUFF_MAGIC,   -- immolate
      [8282] = SMARTDEBUFF_CURSE,    -- curse-of-blood
      [15530] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [17503] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [16799] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [15531] = SMARTDEBUFF_MAGIC,    -- frost-nova
      [14907] = SMARTDEBUFF_MAGIC,     -- Frost Nova
      [11639] = SMARTDEBUFF_MAGIC,    -- shadow-word-pain
      [15548] = SMARTDEBUFF_MAGIC,    -- thunderclap
    },
    [429] = { -- 54 to 60
      __name = "Dire Maul",
      __name_frFR = "Hache-Tripes",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [5137] = SMARTDEBUFF_CURSE,    -- call-of-the-grave
      [8399] = SMARTDEBUFF_MAGIC,    -- sleep
      [29212] = SMARTDEBUFF_POISON,    -- cripple
      [15530] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [17503] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [16799] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [15531] = SMARTDEBUFF_MAGIC,    -- frost-nova
      [14907] = SMARTDEBUFF_MAGIC,     -- Frost Nova
      [11639] = SMARTDEBUFF_MAGIC,    -- shadow-word-pain
      [7645] = SMARTDEBUFF_MAGIC,    -- dominate-mind
      [14515] = SMARTDEBUFF_MAGIC,    -- dominate-mind
      [12889] = SMARTDEBUFF_CURSE,    -- curse-of-tongues
      [13338] = SMARTDEBUFF_CURSE,    -- curse-of-tongues
      [8994] = SMARTDEBUFF_MAGIC,    -- banish
      [12096] = SMARTDEBUFF_MAGIC,    -- fear
      [12542] = SMARTDEBUFF_MAGIC,    -- fear
      [20800]  = SMARTDEBUFF_MAGIC,   -- immolate
    },
    [230] = { -- 52 to 60
      __name = "Blackrock Depths",
      __name_frFR = "Profondeurs de Rochenoire",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [9034] = SMARTDEBUFF_MAGIC,    -- immolate
      [20800]  = SMARTDEBUFF_MAGIC,   -- immolate
      [21007] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [12741] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [18267] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [8282] = SMARTDEBUFF_CURSE,    -- curse-of-blood
      [15530] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [17503] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [16799] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [15531] = SMARTDEBUFF_MAGIC,    -- frost-nova
      [14907] = SMARTDEBUFF_MAGIC,     -- Frost Nova
      [11639] = SMARTDEBUFF_MAGIC,    -- shadow-word-pain
      [15548] = SMARTDEBUFF_MAGIC,    -- thunderclap
      [12889] = SMARTDEBUFF_CURSE,    -- curse-of-tongues
      [13338] = SMARTDEBUFF_CURSE,    -- curse-of-tongues
      [8994] = SMARTDEBUFF_MAGIC,    -- banish
      [15499] = SMARTDEBUFF_MAGIC,    -- frost-shock
    },
    [109] = { -- 50 to 60
      __name = "Sunken Temple",
      __name_frFR = "Temple d'Atal'Hakkar",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [1714] = SMARTDEBUFF_CURSE, -- Curse of Tongues
    },
    [349] = { -- 46 to 55
      __name = "Maraudon",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [2818]  = SMARTDEBUFF_POISON,   -- deadly-poison
      [7964] = SMARTDEBUFF_MAGIC, -- smoke-bomb
      [21687] = SMARTDEBUFF_POISON, -- toxic-volley
      [12747] = SMARTDEBUFF_CURSE, -- entangling-roots
    },
    [209] = { -- 44 to 54
      __name = "Zul'Farrak",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [11836] = SMARTDEBUFF_MAGIC,   -- freeze-solid
      [8600]  = SMARTDEBUFF_DISEASE, -- fevered-plague
      [1294626] = SMARTDEBUFF_CURSE,  -- Theka's Last Breath
      [12741] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [18267] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [20800]  = SMARTDEBUFF_MAGIC,   -- immolate
    },
    [70] = { -- 41 to 51
      __name = "Uldaman",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [2818]  = SMARTDEBUFF_POISON,   -- deadly-poison
      [9482]  = SMARTDEBUFF_MAGIC,  -- amplify-flames
      [3356]  = SMARTDEBUFF_MAGIC,  -- flame-lash
      [8053]  = SMARTDEBUFF_MAGIC,  -- flame-shock
      [11892] = SMARTDEBUFF_CURSE,  -- shrink
      [18327] = SMARTDEBUFF_MAGIC,    -- silence
    },
    [129] = { -- 37 to 46
      __name = "Razorfen Downs",
      __name_frFR = "Souilles de Tranchebauge",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [12255] = SMARTDEBUFF_CURSE,    -- curse-of-tutenkash
      [12946] = SMARTDEBUFF_DISEASE,    -- putrid-stench
      [15530] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [16799] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [17503] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [15531] = SMARTDEBUFF_MAGIC,    -- frost-nova
      [11639] = SMARTDEBUFF_MAGIC,    -- shadow-word-pain
      [7645] = SMARTDEBUFF_MAGIC,    -- dominate-mind
      [14515] = SMARTDEBUFF_MAGIC,    -- dominate-mind
      [18327] = SMARTDEBUFF_MAGIC,    -- silence
    },
    [189] = { -- 30 to 38
      __name = "Scarlet Monastery",
      __name_frFR = "Monastère écarlate",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [9034] = SMARTDEBUFF_MAGIC,    -- immolate
      [20800]  = SMARTDEBUFF_MAGIC,   -- immolate
      [5137] = SMARTDEBUFF_CURSE,    -- call-of-the-grave
      [9373] = SMARTDEBUFF_MAGIC,    -- soul-siphon
      [7399] = SMARTDEBUFF_MAGIC,    -- terrify
      [21007] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [12741] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [18267] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [3815] = SMARTDEBUFF_POISON,    -- poison-cloud
      [8399] = SMARTDEBUFF_MAGIC,    -- sleep
      [853] = SMARTDEBUFF_MAGIC,    -- hammer-of-justice
      [14518] = SMARTDEBUFF_MAGIC,    -- crusader-strike
      [8282] = SMARTDEBUFF_CURSE,    -- curse-of-blood
      [26580] = SMARTDEBUFF_MAGIC,    -- fear
      [12096] = SMARTDEBUFF_MAGIC,    -- fear
      [12542] = SMARTDEBUFF_MAGIC,    -- fear
      [15530] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [17503] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [16799] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [15531] = SMARTDEBUFF_MAGIC,    -- frost-nova
      [11639] = SMARTDEBUFF_MAGIC,    -- shadow-word-pain
      [19776] = SMARTDEBUFF_MAGIC,    -- shadow-word-pain
      [14515] = SMARTDEBUFF_MAGIC,    -- dominate-mind
    },
    [47] = { -- 29 to 38
      __name = "Razorfen Kraul",
      __name_frFR = "Kraal de Tranchebauge",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [14515] = SMARTDEBUFF_MAGIC,    -- dominate-mind
      [15531] = SMARTDEBUFF_MAGIC,    -- frost-nova
      [11639] = SMARTDEBUFF_MAGIC,    -- shadow-word-pain
      [8281] = SMARTDEBUFF_MAGIC,    -- sonic-burst
      [15548] = SMARTDEBUFF_MAGIC,    -- thunderclap
      [15530] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [17503] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [16799] = SMARTDEBUFF_MAGIC,    -- frostbolt
    },
    [2959] = { -- 28 to 33
      __name = "City of Dalaran",
      __name_frFR = "Cité de Dalaran",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [1240869] = SMARTDEBUFF_MAGIC,    -- manamorph
      [1224125] = SMARTDEBUFF_MAGIC,    -- silence -- EVERYWHERE
      [1240738] = SMARTDEBUFF_MAGIC,    -- drain-vitality
      [1303598] = SMARTDEBUFF_MAGIC,    -- mass-polymorph
      [1304473] = SMARTDEBUFF_CURSE,    -- curse-of-thorns
    },
    [48] = { -- 24 to 32
      __name = "Blackfathom Deeps",
      __name_frFR = "Profondeurs de Brassenoire",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [14907] = SMARTDEBUFF_MAGIC,     -- Frost Nova
      [700] = SMARTDEBUFF_MAGIC,     -- Sleep
      [8399] = SMARTDEBUFF_MAGIC,     -- Sleep
      [246] = SMARTDEBUFF_MAGIC,     -- Slow
      [435169] = SMARTDEBUFF_POISON, -- Poison Cloud
      [3815] = SMARTDEBUFF_POISON, -- Poison Cloud
      [15530] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [17503] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [16799] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [12741] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [18267] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [15499] = SMARTDEBUFF_MAGIC,    -- frost-shock
    },
    [33] = { -- 20 to 30
      __name = "Shadowfang Keep",
      __name_frFR = "Donjon d’Ombrecroc",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [853] = SMARTDEBUFF_MAGIC,     -- Hammer of Justice
      [122] = SMARTDEBUFF_MAGIC,     -- Frost Nova
    },
    [34] = { -- 20 to 29?
      __name = "Stormwind Stockade",
      __name_frFR = "La Prison",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [7964] = SMARTDEBUFF_MAGIC, -- smoke-bomb
    },
    [2998] = { -- 24 to 29
      __name = "Excavation Site: Wetlands",
      __name_frFR = "Excavations",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [3427] = SMARTDEBUFF_DISEASE,    -- infected-wound
      [12054]  = SMARTDEBUFF_BLEEDING,   -- rend
      [15588] = SMARTDEBUFF_MAGIC,    -- thunderclap
    },
    [43] = { -- 15 to 24
      __name = "Wailing Caverns",
      __name_frFR = "Cavernes des Lamentations",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [700]  = SMARTDEBUFF_MAGIC, -- sleep
      [8040] = SMARTDEBUFF_MAGIC, -- druid's-slumber
      [7967] = SMARTDEBUFF_MAGIC, -- naralex's-nightmare
      [7399] = SMARTDEBUFF_MAGIC, -- terrify
      [15548] = SMARTDEBUFF_MAGIC,    -- thunderclap
    },
    [2999] = { -- 15 to 20
      __name = "Ruins of Lordaeron",
      __name_frFR = "Ruines de Lordaeron",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [3358] = SMARTDEBUFF_POISON,    -- leech-poison
      [1220855] = SMARTDEBUFF_MAGIC,    -- frost-nova
      [1266011] = SMARTDEBUFF_MAGIC,    -- life-drain
    },
    [3065] = { -- 13 to 18
      __name = "The Hall of Thanes",
      __name_frFR = "La salle des Thanes",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [1292602]  = SMARTDEBUFF_CURSE,   -- Anvilmar's Curse
      [1293228]  = SMARTDEBUFF_MAGIC,   -- combust
      [26070]  = SMARTDEBUFF_MAGIC,   -- fear
      [12054]  = SMARTDEBUFF_BLEEDING,   -- rend
    },
    [389] = { -- 13 to 16?
      __name = "Ragefire Chasm",
      __name_frFR = "Gouffre de Ragefeu",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [21007] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [12741] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [18267] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [20800]  = SMARTDEBUFF_MAGIC,   -- immolate
      [2818]  = SMARTDEBUFF_POISON,   -- deadly-poison
    },
    [36] = { -- 15 to 22?
      __name = "Deadmines",
      __name_frFR = "Les Mortemines",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "",
      [7399] = SMARTDEBUFF_MAGIC,    -- terrify
      [5208] = SMARTDEBUFF_POISON,    -- poisoned-harpoon
    },
  
    -- Generic / Outside instances / PvP
    [0] = {
      __name = PVP,
      __type = SETTINGS_DEFAULTS,
      __ext = "",

      -- PNJ
      [12054]   = SMARTDEBUFF_BLEEDING, -- rend
      [26070]  = SMARTDEBUFF_MAGIC,   -- fear
      [12542] = SMARTDEBUFF_MAGIC,    -- fear
      [3427] = SMARTDEBUFF_DISEASE,    -- infected-wound
      [1304473] = SMARTDEBUFF_CURSE,    -- curse-of-thorns
      [7399] = SMARTDEBUFF_MAGIC,    -- terrify
      [21007] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [12741] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [18267] = SMARTDEBUFF_CURSE,    -- curse-of-weakness
      [8399] = SMARTDEBUFF_MAGIC,    -- sleep
      [14518] = SMARTDEBUFF_MAGIC,    -- crusader-strike
      [15530] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [17503] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [16799] = SMARTDEBUFF_MAGIC,    -- frostbolt
      [15531] = SMARTDEBUFF_MAGIC,    -- frost-nova
      [14907] = SMARTDEBUFF_MAGIC,     -- Frost Nova
      [11639] = SMARTDEBUFF_MAGIC,    -- shadow-word-pain
      [19776] = SMARTDEBUFF_MAGIC,    -- shadow-word-pain
      [15548] = SMARTDEBUFF_MAGIC,    -- thunderclap
      [14515] = SMARTDEBUFF_MAGIC,    -- dominate-mind
      [13338] = SMARTDEBUFF_CURSE,    -- curse-of-tongues
      [15499] = SMARTDEBUFF_MAGIC,    -- frost-shock

      -- DEATH KNIGHT

      -- DEMON HUNTER

      -- DRUID
      [1079]   = SMARTDEBUFF_BLEEDING, -- Rip
      [339]    = SMARTDEBUFF_MAGIC,    -- Entangling Roots
      [1822]   = SMARTDEBUFF_BLEEDING, -- Rake

      -- EVOKER

      -- HUNTER
      [3355]   = SMARTDEBUFF_MAGIC,    -- Freezing Trap
      [1978]   = SMARTDEBUFF_POISON,   -- Serpent Sting

      -- MAGE
      [118]    = SMARTDEBUFF_MAGIC,    -- Polymorph
      [122]    = SMARTDEBUFF_MAGIC,    -- Frost Nova
      [2139]   = SMARTDEBUFF_MAGIC,    -- Counterspell / Silence
      [2120]   = SMARTDEBUFF_MAGIC,    -- Flamestrike

      -- MONK

      -- PALADIN
      [853]    = SMARTDEBUFF_MAGIC,    -- Hammer of Justice
      [20066]  = SMARTDEBUFF_MAGIC,    -- Repentance

      -- PRIEST
      [605]    = SMARTDEBUFF_MAGIC,    -- Mind Control
      [8122]   = SMARTDEBUFF_MAGIC,    -- Psychic Scream
      [15487]  = SMARTDEBUFF_MAGIC,    -- Silence
      [589]    = SMARTDEBUFF_MAGIC,    -- Shadow Word: Pain

      -- ROGUE
      [2818]   = SMARTDEBUFF_POISON,   -- Deadly Poison
      [3408]   = SMARTDEBUFF_POISON,   -- Crippling Poison
      [5760]   = SMARTDEBUFF_POISON,   -- Mind-Numbing Poison
      [703]    = SMARTDEBUFF_BLEEDING, -- Garrote
      [1943]   = SMARTDEBUFF_BLEEDING, -- Rupture
      [3409]   = SMARTDEBUFF_POISON,   -- Crippling Poison
      [8680]   = SMARTDEBUFF_POISON,   -- Wound Poison

      -- SHAMAN

      -- WARLOCK
      [5782]   = SMARTDEBUFF_MAGIC,    -- Fear
      [6358]   = SMARTDEBUFF_MAGIC,    -- Seduction
      [702]    = SMARTDEBUFF_CURSE,    -- Curse of Weakness
      [1714]   = SMARTDEBUFF_CURSE,    -- Curse of Tongues
      [980]    = SMARTDEBUFF_CURSE,    -- Agony
      [172]    = SMARTDEBUFF_MAGIC,    -- Corruption

      -- WARRIOR
    }

    -- [531] = {
    --   __name = "Ahn'Qiraj",
    --   __type = MAP_LEGEND_RAID,
    --   __ext = "",
    --   [1224125] = SMARTDEBUFF_MAGIC,    -- silence
    --   [18327] = SMARTDEBUFF_MAGIC,    -- silence
    --   [26580] = SMARTDEBUFF_MAGIC,    -- fear
    --   [12096] = SMARTDEBUFF_MAGIC,    -- fear
    --   [12542] = SMARTDEBUFF_MAGIC,    -- fear
    --   [25812] = SMARTDEBUFF_POISON,    -- toxic-volley
    --   [25991] = SMARTDEBUFF_POISON,    -- poison-bolt-volley
    --   [26180] = SMARTDEBUFF_POISON,    -- wyvern-sting
    -- },
    -- [409] = {
    --   __name = "Molten Core",
    --   __name_frFR = "",
    --   __type = MAP_LEGEND_RAID,
    --   __ext = "",
    --   [11639] = SMARTDEBUFF_MAGIC,    -- shadow-word-pain
    --   [19776] = SMARTDEBUFF_MAGIC,    -- shadow-word-pain
    --   [7645] = SMARTDEBUFF_MAGIC,    -- dominate-mind
    --   [14515] = SMARTDEBUFF_MAGIC,    -- dominate-mind
    --   [19659] = SMARTDEBUFF_MAGIC,    -- ignite-mana
    --   [19713] = SMARTDEBUFF_CURSE,    -- shazzrahs-curse
    --   [19496] = SMARTDEBUFF_MAGIC,    -- magma-shackles
    --   [19716] = SMARTDEBUFF_CURSE,    -- gehennas-curse
    --   [19408] = SMARTDEBUFF_MAGIC,    -- panic
    --   [19703] = SMARTDEBUFF_CURSE,    -- lucifrons-curse
    --   [19702] = SMARTDEBUFF_MAGIC,    -- impending-doom
      -- [20800]  = SMARTDEBUFF_MAGIC,   -- immolate
    -- },
    -- [469] = {
    --   __name = "Blackwing Lair",
    --   __type = MAP_LEGEND_RAID,
    --   __ext = "",
    --   [14515] = SMARTDEBUFF_MAGIC,    -- dominate-mind
    --   [22687] = SMARTDEBUFF_CURSE,    -- Veil of Shadow
    --   [15548] = SMARTDEBUFF_MAGIC,    -- thunderclap
    -- },
    -- [533] = {
    --   __name = "Naxxramas",
    --   __type = MAP_LEGEND_RAID,
    --   __ext = "",
    --   [29212] = SMARTDEBUFF_POISON,    -- cripple
    --   [1224125] = SMARTDEBUFF_MAGIC,    -- silence
    --   [18327] = SMARTDEBUFF_MAGIC,    -- silence
    --   [26580] = SMARTDEBUFF_MAGIC,    -- fear
    --   [12096] = SMARTDEBUFF_MAGIC,    -- fear
    --   [12542] = SMARTDEBUFF_MAGIC,    -- fear
    --   [25991] = SMARTDEBUFF_POISON,    -- poison-bolt-volley
    --   [15548] = SMARTDEBUFF_MAGIC,    -- thunderclap
    --   [14907] = SMARTDEBUFF_MAGIC,     -- Frost Nova
    -- },
    -- [2856] = {
    --   __name = "Scarlet Enclave",
    --   __name_frFR = "Enclave",
    --   __type = MAP_LEGEND_RAID,
    --   __ext = "",
    --   [14518] = SMARTDEBUFF_MAGIC,    -- crusader-strike
    -- },
  }