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

Vérifier :

  Moine :
    Passage heal > tank/dps, Détoxification même nom/id différent, l'id n'est pas mis à jour... (spellUpgrade)
  Prêtre :
    Purifier la maladie (213634), détecté par erreur pour la spé Sacré (GetSpellInfo)
    Bonne détection du talent Purify si amélioré ou pas (spé Sacré / Discipline)
  Druide :
    Délivrance de la corruption > Soins naturels
    Soins naturels améliorés ou non
    Soins naturels : ne pas tenter de pickup/drop le base id (qui est Délivrance de la corruption..)
    Déplacement/drop de Charge de la nature en spé Ours/Chat/Chouette/Cerf
  Evocateur :
    Détection dans le bon sens Expunge > Naturalize
  Démoniste :
    Changement de pet (imp)
    Bon fonctionnement des actionpet
    Drop de Commandement démoniaque Brûle-Magie depuis les sorts
    Déplacement/drop de Brûle-Magie

  Autre : Mauvaise détection des sorts, mais car mauvais Spell_ID: Réversion (Evocateur), Voile mortel (DK)

]]--
--@end-do-not-package@

SMARTDEBUFF_SPELLS_VERSION = "Midnight";
SMARTDEBUFF_MACROTEXT = true;

local v = select(4, GetBuildInfo())
if v < 110000 then
  SMARTDEBUFF_SPELLS_VERSION = "Dragonflight"
elseif v < 120000 then
  SMARTDEBUFF_SPELLS_VERSION = "The War Within"
end

-- Debuff spell IDs (for L button) - first known
SMARTDEBUFF_CLASS_DISPELS_LIST_ID = {
  ["DRUID"]  = {
    { -- Nature's Cure, was talent for Remove Corruption (10+)
      Spell_ID = 88423,
      Spell_List = {SMARTDEBUFF_MAGIC},
      Improved_Talent = 392378,
      Improved_Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_CURSE, SMARTDEBUFF_POISON},
    },
    { -- Remove Corruption (1+)
      Spell_ID = 2782,
      Spell_List = {SMARTDEBUFF_CURSE, SMARTDEBUFF_POISON},
    },
  },

  ["EVOKER"] = {
    { -- Naturalize (10+)
      Spell_ID = 360823,
      Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_POISON},
    },
    { -- Expunge (10+)
      Spell_ID = 365585,
      Spell_List = {SMARTDEBUFF_POISON},
    },
    -- Cauterizing Flame set on R
  },


  ["MONK"] = {
    { -- Detox
      Spell_ID = 115450,
      Spell_List = {SMARTDEBUFF_MAGIC},
      Improved_Talent = 388874,
      Improved_Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_DISEASE, SMARTDEBUFF_POISON},
    },
    { -- Detox (again) (10+)
      Spell_ID = 218164,
      Spell_List = {SMARTDEBUFF_DISEASE, SMARTDEBUFF_POISON},
    },
  },

  ["PALADIN"] = {
    { -- Cleanse (1+)
      Spell_ID = 4987,
      Spell_List = {SMARTDEBUFF_MAGIC},
      Improved_Talent = 393024,
      Improved_Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_DISEASE, SMARTDEBUFF_POISON},
    },
    { -- Cleanse Toxins (10+)
      Spell_ID = 213644,
      Spell_List = {SMARTDEBUFF_DISEASE, SMARTDEBUFF_POISON},
    },
  },

  ["PRIEST"] = {
    { -- Purify, was named Dispel Magic (4+)
      Spell_ID = 527,
      Spell_List = {SMARTDEBUFF_MAGIC},
      Improved_Talent = 390632,
      Improved_Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_DISEASE},
    },
    { -- Purify Disease (10+)
      Spell_ID = 213634,
      Spell_List = {SMARTDEBUFF_DISEASE},
    },
    -- Dispel Magic (528) only enemies, was a Cure Disease (4+)
  },

  ["SHAMAN"] = {
    { -- Purify Spirit, was talent for Cleanse Spirit (10+)
      Spell_ID = 77130,
      Spell_List = {SMARTDEBUFF_MAGIC},
      Improved_Talent = 383016,
      Improved_Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_CURSE},
    },
    { -- Cleanse Spirit (3+)
      Spell_ID = 51886,
      Spell_List = {SMARTDEBUFF_CURSE},
    },
  },

  ["MAGE"] = {
    { -- Remove Curse (1+)
      Spell_ID = 475,
      Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_CURSE},
    },
  },

  ["HUNTER"] = {
    { -- FeignDeath
      Spell_ID = 5384,
      Spell_List = {},
      Improved_Talent = 459517,
      Improved_Spell_List = {SMARTDEBUFF_DISEASE, SMARTDEBUFF_POISON},
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

  -- ["DEMONHUNTER"] = {
  --   -- Consume Magic only enemies
  -- },
}

-- Possible buttons : R, M, AL - last known
SMARTDEBUFF_CLASS_SKILLS_LIST_ID = {
  ["DRUID"]  = {
    { Spell_ID = 102401, Button = "R", Types = {SMARTDEBUFF_UTIL} }, -- Wild charge (5+)
    { Spell_ID = 102693, Button = "M", Types = {SMARTDEBUFF_HEAL} }, -- Grove Guardians (10+)
    { Spell_ID = 774,   Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Rejuvenation (1+)
    -- 8946 - Cure Poison (1-3)
    -- 2893 - Abolish Poison (1-3)
  },
  ["EVOKER"]  = {
    { Spell_ID = 374251, Button = "R", Types = {SMARTDEBUFF_CURSE, SMARTDEBUFF_POISON, SMARTDEBUFF_DISEASE, SMARTDEBUFF_BLEEDING} }, -- Cauterizing flame (10+)
    { Spell_ID = 360995, Button = "M", Types = {SMARTDEBUFF_UTIL} }, -- Verdant embrace (10+)
    { Spell_ID = 361469, Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Living flame (10+)
  },
  ["MONK"]  = {
    { Spell_ID = 115078, Button = "R", Types = {SMARTDEBUFF_CHARMED} }, -- Paralysis (5+)
    { Spell_ID = 115151, Button = "M", Types = {SMARTDEBUFF_HEAL} }, -- Renewing Mist (5+)
    { Spell_ID = 116670, Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Vivify (5+)
  },
  ["PALADIN"]  = {
    { Spell_ID = 20066, Button = "R", Types = {SMARTDEBUFF_CHARMED} }, -- Repentance (1+)
    { Spell_ID = 1022,  Button = "M", Types = {SMARTDEBUFF_UTIL} }, --  Blessing of protection (1+)
    { Spell_ID = 19750, Button = "AL", Types = {SMARTDEBUFF_HEAL} }, --  Flash of light (1+)
    -- 633 - Lay on Hands (1+)?
  },
  ["PRIEST"]  = {
    { Spell_ID = 73325, Button = "R", Types = {SMARTDEBUFF_UTIL} }, -- Leap of Faith (4+)
    { Spell_ID = 64044,   Button = "M", Types = {SMARTDEBUFF_CHARMED} }, -- Psychic horror (3+)
    { Spell_ID = 2061,   Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Flash heal (1+)
    { Spell_ID = 139,   Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Renew (1+)
    { Spell_ID = 17,    Button = "AM", Types = {SMARTDEBUFF_UTIL} }, -- Power word shield (1+)
    -- 528 - Cure Disease (1-4)
    -- 552 - Abolish Disease (1-3)
    -- 2061 - Flash heal (1+)
    -- 64044 -- Psychic horror? (3+)
  },
  ["SHAMAN"]  = {
    { Spell_ID = 51514, Button = "R", Types = {SMARTDEBUFF_CHARMED} }, -- Hex (3+)
    { Spell_ID = 974,   Button = "M", Types = {SMARTDEBUFF_UTIL} }, -- Earth shield (1+)
    { Spell_ID = 8004,  Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Healing surge (1+)
    -- 2870 - Cure Disease (1-2)
    -- 331 - Healing wave (1-4)
  },

  ["DEATHKNIGHT"]  = {
    { Spell_ID = 45524, Button = "R", Types = {SMARTDEBUFF_CHARMED} }, -- Chains of ice (3+)
    { Spell_ID = 47541, Button = "M", Types = {SMARTDEBUFF_HEAL} }, -- Death Coil (3+)
  },
  ["DEMONHUNTER"]  = {
    { Spell_ID = 217832, Button = "R", Types = {SMARTDEBUFF_CHARMED} }, -- Imprison (7+)
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

SMARTDEBUFF_OVERRIDE_PICKUP_LIST_ID = {
  ["spell"] = {
    -- Druid Wild Charge (5+) overrides: use base spell
    [16979] = {"spell", 102401},
    [49376] = {"spell", 102401},
    [102383] = {"spell", 102401},
    [102417] = {"spell", 102401},
    -- Warlock command demon (4+) : imp Singe Magic
    [119898] = {"petaction", 89808},
  }
}

SMARTDEBUFF_DEBUFFS_LIST = {
  -- Generic / Outside instances / PvP
  [0] = {
    __name = PVP,
    __type = SETTINGS_DEFAULTS,
    __ext = "",
    -- DEATH KNIGHT
    [55095]  = SMARTDEBUFF_DISEASE,  -- Frost Fever
    [55078]  = SMARTDEBUFF_DISEASE,  -- Blood Plague
    [191587] = SMARTDEBUFF_DISEASE,  -- Virulent Plague

    -- DEMON HUNTER
    [217832] = SMARTDEBUFF_MAGIC,    -- Imprison

    -- DRUID
    [164812] = SMARTDEBUFF_MAGIC,    -- Moonfire
    [164815] = SMARTDEBUFF_MAGIC,    -- Sunfire
    [1079]   = SMARTDEBUFF_BLEEDING, -- Rip
    [106830] = SMARTDEBUFF_BLEEDING, -- Thrash
    [339]    = SMARTDEBUFF_MAGIC,    -- Entangling Roots
    [155722] = SMARTDEBUFF_BLEEDING, -- Rake
    [1822]   = SMARTDEBUFF_BLEEDING, -- Rake

    -- EVOKER
    [355689] = SMARTDEBUFF_MAGIC,    -- Landslide
    [360806] = SMARTDEBUFF_MAGIC,    -- Sleep Walk
    [357209] = SMARTDEBUFF_MAGIC,    -- Fire Breath

    -- HUNTER
    [3355]   = SMARTDEBUFF_MAGIC,    -- Freezing Trap
    [213691] = SMARTDEBUFF_MAGIC,    -- Scatter Shot
    -- [2719]   = SMARTDEBUFF_BLEEDING, -- Lacerate / Sting Bleed
    [118253] = SMARTDEBUFF_POISON,   -- Serpent Sting
    [259491] = SMARTDEBUFF_POISON,   -- Serpent Sting
    -- [1978]   = SMARTDEBUFF_POISON,   -- Serpent Sting

    -- MAGE
    [118]    = SMARTDEBUFF_MAGIC,    -- Polymorph
    [122]    = SMARTDEBUFF_MAGIC,    -- Frost Nova
    [31661]  = SMARTDEBUFF_MAGIC,    -- Dragon's Breath
    [2139]   = SMARTDEBUFF_MAGIC,    -- Counterspell / Silence
    [82691]  = SMARTDEBUFF_MAGIC,    -- Ring of Frost
    [12654]  = SMARTDEBUFF_MAGIC,    -- Ignite
    [2120]   = SMARTDEBUFF_MAGIC,    -- Flamestrike
    -- [113092] = SMARTDEBUFF_MAGIC,    -- Frost Bomb

    -- MONK
    [198909] = SMARTDEBUFF_MAGIC,    -- Song of Chi-Ji
    [115181] = SMARTDEBUFF_MAGIC,    -- Breath of Fire
    [123725] = SMARTDEBUFF_MAGIC,    -- Breath of Fire
    [122470] = SMARTDEBUFF_MAGIC,    -- Touch of Karma

    -- PALADIN
    [853]    = SMARTDEBUFF_MAGIC,    -- Hammer of Justice
    [20066]  = SMARTDEBUFF_MAGIC,    -- Repentance
    [197277] = SMARTDEBUFF_MAGIC,    -- Judgment
    [204242] = SMARTDEBUFF_MAGIC,    -- Greater Judgment
    -- [31803]  = SMARTDEBUFF_MAGIC,    -- Execution Sentence

    -- PRIEST
    [605]    = SMARTDEBUFF_MAGIC,    -- Mind Control
    [8122]   = SMARTDEBUFF_MAGIC,    -- Psychic Scream
    [15487]  = SMARTDEBUFF_MAGIC,    -- Silence
    -- [212440] = SMARTDEBUFF_DISEASE,  -- Devouring Plague
    [589]    = SMARTDEBUFF_MAGIC,    -- Shadow Word: Pain
    [34914]  = SMARTDEBUFF_MAGIC,    -- Vampiric Touch
    [335467] = SMARTDEBUFF_MAGIC,    -- Devouring Plague

    -- ROGUE
    [2818]   = SMARTDEBUFF_POISON,   -- Deadly Poison
    [3408]   = SMARTDEBUFF_POISON,   -- Crippling Poison
    [5760]   = SMARTDEBUFF_POISON,   -- Mind-Numbing Poison
    -- [199804] = SMARTDEBUFF_POISON,   -- Wound Poison
    -- [113952] = SMARTDEBUFF_POISON,   -- Paralytic Poison
    [703]    = SMARTDEBUFF_BLEEDING, -- Garrote
    [1943]   = SMARTDEBUFF_BLEEDING, -- Rupture
    [3409]   = SMARTDEBUFF_POISON,   -- Crippling Poison
    [8680]   = SMARTDEBUFF_POISON,   -- Wound Poison

    -- SHAMAN
    [51514]  = SMARTDEBUFF_MAGIC,    -- Hex
    [188389] = SMARTDEBUFF_MAGIC,    -- Flame Shock

    -- WARLOCK
    [5782]   = SMARTDEBUFF_MAGIC,    -- Fear
    [6358]   = SMARTDEBUFF_MAGIC,    -- Seduction
    [118699] = SMARTDEBUFF_MAGIC,    -- Fear
    [30283]  = SMARTDEBUFF_MAGIC,    -- Shadowfury
    [702]    = SMARTDEBUFF_CURSE,    -- Curse of Weakness
    -- [17862]  = SMARTDEBUFF_CURSE,    -- Curse of Shadows
    [1714]   = SMARTDEBUFF_CURSE,    -- Curse of Tongues
    [199711] = SMARTDEBUFF_CURSE,    -- Agony
    [980]    = SMARTDEBUFF_CURSE,    -- Agony
    [172]    = SMARTDEBUFF_MAGIC,    -- Corruption
    [30108]  = SMARTDEBUFF_MAGIC,    -- Unstable Affliction
    [48181]  = SMARTDEBUFF_MAGIC,    -- Haunt
    [80240]  = SMARTDEBUFF_CURSE,    -- Havoc

    -- WARRIOR
    -- [115767] = SMARTDEBUFF_BLEEDING, -- Deep Wounds
    [257044] = SMARTDEBUFF_BLEEDING, -- Sweeping Strikes Bleed
    -- [94009]  = SMARTDEBUFF_BLEEDING, -- Rend
  },


  -- =====
  -- Midnight S2 Content
  -- =======================

  [3004] = {
      __name = "The Venomous Abyss",
      __type = MAP_LEGEND_RAID,
      __ext = "Midnight S2",
      [1286922] = SMARTDEBUFF_MAGIC,       -- Icebound Flames
      [1301800] = SMARTDEBUFF_MAGIC,       -- Acidic Burst
      [1306906] = SMARTDEBUFF_POISON,       -- Venomfang

      [1287434] = SMARTDEBUFF_MAGIC,       -- Essence Rend
      -- [1284483] = SMARTDEBUFF_MAGIC,       -- Blighted Blood
      [1295173] = SMARTDEBUFF_MAGIC,       -- Exploding Infection
      -- [1294994] = SMARTDEBUFF_MAGIC,       -- Stygian Infection
  },

  [2741] = {
      __name = "Altar of Fangs",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "Midnight S2",
      [1294569] = SMARTDEBUFF_MAGIC,    -- Paralyzing Shots
      [1294845] = SMARTDEBUFF_POISON,   -- Corrosive Fangs
      [1296069] = SMARTDEBUFF_DISEASE,  -- Regurgitate
      [1302867] = SMARTDEBUFF_DISEASE,  -- Festering Gash
      [1305368] = SMARTDEBUFF_POISON,   -- Spiteful Venom
      [1307571] = SMARTDEBUFF_POISON,   -- Envenom
      [1309980] = SMARTDEBUFF_CURSE,    -- Cursed
      [1310017] = SMARTDEBUFF_CURSE,    -- Twisted Curse
      [1238255] = SMARTDEBUFF_CURSE,    -- Whirling Spirit
  },

  [2743] = {
      __name = "Murder Row",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "Midnight S2",
      [474515]  = SMARTDEBUFF_POISON,   -- Heartstop Poison
      [1216590] = SMARTDEBUFF_POISON,   -- Heartstop Poison (variant)
      [474740]  = SMARTDEBUFF_BLEEDING, -- Murder in a Row
      [1217633] = SMARTDEBUFF_MAGIC,    -- Corroding Spittle
      [1228198] = SMARTDEBUFF_MAGIC,    -- Corroding Spittle (variant)
      [1217973] = SMARTDEBUFF_CURSE,    -- Curse of Doom
      [1216300] = SMARTDEBUFF_BLEEDING, -- Cutpurse
      [1295035] = SMARTDEBUFF_BLEEDING, -- Glaive Toss
      [1295427] = SMARTDEBUFF_BLEEDING, -- Flay
      [1311136] = SMARTDEBUFF_BLEEDING, -- Sharp Nail
      [1201554] = SMARTDEBUFF_MAGIC,    -- Seduction
      [1245456] = SMARTDEBUFF_DISEASE,  -- Blightspore Burst
  },

  [2742] = {
      __name = "Den of Nalorakk",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "Midnight S2",
      [1234846] = SMARTDEBUFF_POISON,   -- Toxic Spores
      [1235549] = SMARTDEBUFF_MAGIC,    -- Glacial Torment
      [1239860] = SMARTDEBUFF_MAGIC,    -- Cryo Surge
      [1238439] = SMARTDEBUFF_BLEEDING, -- Razor Dive
      [1238801] = SMARTDEBUFF_CURSE,    -- Insatiable Hunger
  },

  [2744] = {
      __name = "The Blinding Vale",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "Midnight S2",
      [1235865] = SMARTDEBUFF_BLEEDING, -- Thornblade
      [1238076] = SMARTDEBUFF_BLEEDING, -- Thornblade (variant)
      [1241058] = SMARTDEBUFF_BLEEDING, -- Grievous Thrash
      [1247746] = SMARTDEBUFF_BLEEDING, -- Thornspike
      [1259365] = SMARTDEBUFF_MAGIC,    -- Bloodthorn Roots
      [1242135] = SMARTDEBUFF_BLEEDING, -- Grievous Gash
      [1237267] = SMARTDEBUFF_BLEEDING, -- Incise
      [1238084] = SMARTDEBUFF_MAGIC,    -- Spore Spines
      [1250937] = SMARTDEBUFF_POISON,   -- Toxic Spew
  },

  [2745] = {
      __name = "Voidscar Arena",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "Midnight S2",
      [1226031] = SMARTDEBUFF_POISON,   -- Poison Splash
      [1289258] = SMARTDEBUFF_POISON,   -- Corrosive Essence
      [1249238] = SMARTDEBUFF_MAGIC,    -- Fire Spit
      [1263971] = SMARTDEBUFF_POISON,   -- Lingering Poison
      [1267894] = SMARTDEBUFF_BLEEDING, -- Savage Leap
      [1299133] = SMARTDEBUFF_BLEEDING, -- Ferocious Leap
      [1311778] = SMARTDEBUFF_BLEEDING, -- Rip and Slice
      [1252095] = SMARTDEBUFF_CURSE,    -- Curse of Dread
  },

  [1762] = {
      __name = "Kings' Rest",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "BfA",
      [266191]  = SMARTDEBUFF_BLEEDING, -- Whirling Axe
      [266231]  = SMARTDEBUFF_BLEEDING, -- Severing Axe
      [267273]  = SMARTDEBUFF_POISON,   -- Poison Nova
      [267763]  = SMARTDEBUFF_DISEASE,  -- Wretched Discharge
      [269972]  = SMARTDEBUFF_CURSE,    -- Hex Volley
      [270492]  = SMARTDEBUFF_CURSE,    -- Hex
      [270499]  = SMARTDEBUFF_CURSE,    -- Frost Shock
      [270920]  = SMARTDEBUFF_CURSE,    -- Bind Soul
      [271564]  = SMARTDEBUFF_POISON,   -- Lingering Fluid
      [276031]  = SMARTDEBUFF_MAGIC,    -- Pit of Despair
      [1294815] = SMARTDEBUFF_MAGIC,    -- Shadowfrost Bolt
      [1297781] = SMARTDEBUFF_BLEEDING, -- Sudden Rupture
      [1297918] = SMARTDEBUFF_BLEEDING, -- Mortal Bleed
      [1298104] = SMARTDEBUFF_POISON,   -- Putrid Seekers
      [1301851] = SMARTDEBUFF_BLEEDING, -- Bloodthirsty Axe
      [1302945] = SMARTDEBUFF_BLEEDING, -- Impaling Spear
      [1303490] = SMARTDEBUFF_BLEEDING, -- Savage Maul
      [1306763] = SMARTDEBUFF_POISON,   -- Serpent Strike
  },

  [2520] = {
      __name = "Ruby Life Pools",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "Dragonflight",
      [372682]  = SMARTDEBUFF_MAGIC,    -- Primal Chill
      [373589]  = SMARTDEBUFF_MAGIC,    -- Primal Chill (variant)
      [1305234] = SMARTDEBUFF_MAGIC,    -- Cold Claws
      [372796]  = SMARTDEBUFF_BLEEDING, -- Blazing Rush
      [381515]  = SMARTDEBUFF_MAGIC,    -- Stormslam
      [392641]  = SMARTDEBUFF_MAGIC,    -- Rolling Thunder
      [392924]  = SMARTDEBUFF_MAGIC,    -- Shock Blast
  },

  [1877] = {
      __name = "Temple of Sethraliss",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "BfA",
      [263957]  = SMARTDEBUFF_POISON, -- Hadotoxin
      [268008]  = SMARTDEBUFF_MAGIC,  -- Snake Charm
      [268013]  = SMARTDEBUFF_MAGIC,  -- Flame Shock
      [269686]  = SMARTDEBUFF_DISEASE, -- Plague
      [272699]  = SMARTDEBUFF_POISON, -- Venomous Spit
      [273563]  = SMARTDEBUFF_POISON,  -- Neurotoxin
      [1291399] = SMARTDEBUFF_BLEEDING,  -- Serrated Charge
      [1296052] = SMARTDEBUFF_MAGIC,  -- Imbued Conduction
      [1308100] = SMARTDEBUFF_POISON, -- Poisoned Cheap Shot
      [1308148] = SMARTDEBUFF_POISON, -- Cytotoxin
      [267027]  = SMARTDEBUFF_POISON, -- Poison Spit
      [1303486] = SMARTDEBUFF_POISON, -- Caustic Stomp
      [1308546] = SMARTDEBUFF_POISON,  -- Venomous Slash
  },

  -- =====
  -- Midnight S1 Content
  -- =======================

   [2912] = {
    __name = "The Voidspire",
    __type = MAP_LEGEND_RAID,
    __ext = "Midnight S1",
    [1233865] = SMARTDEBUFF_MAGIC,       -- Null Corona
    [1275059] = SMARTDEBUFF_CURSE,       -- Black Miasma
    [1280023] = SMARTDEBUFF_MAGIC,       -- Void Marked
  },

  -- -- March on Quel'Danas (Raid)
  -- [2913] = {
  -- },

  [2939] = {
      __name = "The Dreamrift",
      __type = MAP_LEGEND_RAID,
      __ext = "Midnight S1",
      [1257087] = SMARTDEBUFF_MAGIC,       -- Consuming Miasma - Stage 1
      [1257085] = SMARTDEBUFF_MAGIC,       -- Consuming Miasma - Stage 2
  },

  -- -- Sporefall (Raid)
  -- [1592] = {
  -- },

  [2526] = {
      __name = "Algeth'ar Academy",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "Midnight S1",
      [390918]  = SMARTDEBUFF_POISON,   -- Detonation Seeds
      [389033]  = SMARTDEBUFF_POISON,   -- Lasher Toxin
      [396716]  = SMARTDEBUFF_BLEEDING, -- Splinterbark
  },

  [2747] = {
      __name = "Magister's Terrace",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "Midnight S1",
      [1255187] = SMARTDEBUFF_MAGIC,    -- Holy Fire
      [1282055] = SMARTDEBUFF_MAGIC,    -- Ethereal Shackles
      [1245068] = SMARTDEBUFF_MAGIC,    -- Consuming Void
  },

  [2748] = {
      __name = "Maisara Caverns",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "Midnight S1",
      [1258475] = SMARTDEBUFF_MAGIC,    -- Magma Surge
      [1258806] = SMARTDEBUFF_MAGIC,    -- Ritual Firebrand
      [1259255] = SMARTDEBUFF_MAGIC,    -- Spirit Rend
      [1246666] = SMARTDEBUFF_DISEASE,  -- Infected Pinions
  },

  [2746] = {
      __name = "Nexus Point Xenas",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "Midnight S1",
      [1277557] = SMARTDEBUFF_MAGIC,    -- Burning Radiance
  },

  [658] = {
      __name = "Pit of Saron",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "Midnight S1",
      [1258434] = SMARTDEBUFF_CURSE,    -- Curse of Torment
      [1258437] = SMARTDEBUFF_MAGIC,    -- Permeating Cold
      [1264186] = SMARTDEBUFF_CURSE,    -- Shadowbind
      [1261847] = SMARTDEBUFF_MAGIC,    -- Cryostomp
      [1262929] = SMARTDEBUFF_DISEASE,  -- Rotting Strikes
  },

  [1753] = {
      __name = "Seat of the Triumvirate",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "Midnight S1",
      [1280330] = SMARTDEBUFF_MAGIC,    -- Rift Essence
  },

  [1209] = {
      __name = "Skyreach",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "Midnight S1",
      [1254475] = SMARTDEBUFF_BLEEDING, -- Blade Rush
      [1254380] = SMARTDEBUFF_BLEEDING, -- Shear
  },

  [2749] = {
      __name = "Windrunner Spire",
      __type = MAP_LEGEND_DUNGEON,
      __ext = "Midnight S1",
      [1216298] = SMARTDEBUFF_MAGIC,    -- Soul Torment
      [1216822] = SMARTDEBUFF_POISON,   -- Poison Spray
      [474105]  = SMARTDEBUFF_CURSE,    -- Curse of Darkness
  },

  -- =====
  -- The War Within
  -- =======================

  [2652] = {
    __name = "The Stonevault",
    __type = MAP_LEGEND_DUNGEON,
    __ext = "The War Within",
    [426308] = SMARTDEBUFF_CURSE, -- Void Infection
    [449455] = SMARTDEBUFF_MAGIC, -- Howling Fear
    [425974] = SMARTDEBUFF_MAGIC, -- Ground Pound
  },
}