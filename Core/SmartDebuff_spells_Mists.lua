--@do-not-package@
--[[
List dispels: https://warcraft.wiki.gg/wiki/Magic_(dispel_type)
ALL Dispels : https://www.wowhead.com/mop-classic/spells?filter=109;38;0
Class Dispels only: https://www.wowhead.com/mop-classic/spells/abilities/druid?filter=109;38;0
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
  Démoniste :
    Changement de pet (imp)
    Bon fonctionnement des actionpet
    Drop de Commandement démoniaque Brûle-Magie depuis les sorts
    Déplacement/drop de Brûle-Magie

  Autre : Mauvaise détection des sorts, mais car mauvais Spell_ID: Voile mortel (DK)

]]--
--@end-do-not-package@

  SMARTDEBUFF_SPELLS_VERSION = "Mists of Pandaria";
  SMARTDEBUFF_MACROTEXT = true;
  SMARTDEBUFF_NO_TALENT = true;

  -- Debuff spell IDs (for L button)
  SMARTDEBUFF_CLASS_DISPELS_LIST_ID = {
    ["DRUID"]  = {
      { -- Nature's Cure, heal spec (6-9)
        Spell_ID = 88423,
        Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_CURSE, SMARTDEBUFF_POISON},
      },
      { -- Remove Corruption (1+)
        Spell_ID = 2782,
        Spell_List = {SMARTDEBUFF_CURSE, SMARTDEBUFF_POISON},
      },
    },


    ["MONK"] = {
      { -- Detox
        Spell_ID = 115450,
        Spell_List = {SMARTDEBUFF_DISEASE, SMARTDEBUFF_POISON},
        Improved_Talent = 115451,
        Improved_Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_DISEASE, SMARTDEBUFF_POISON},
      },
    },

    ["PALADIN"] = {
      { -- Cleanse (1+)
        Spell_ID = 4987,
        Spell_List = {SMARTDEBUFF_DISEASE, SMARTDEBUFF_POISON},
        Improved_Talent = 53551,
        Improved_Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_DISEASE, SMARTDEBUFF_POISON},
      },
    },

    ["PRIEST"] = {
      { -- Purify, was named Dispel Magic (4+)
        Spell_ID = 527,
        Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_DISEASE},
      },
      -- Dispel Magic (528) only enemies, was a Cure Disease (4+)
    },

    ["SHAMAN"] = {
      { -- Cleanse Spirit (3+)
        Spell_ID = 51886,
        Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_CURSE},
      },
      { -- Purify Spirit, was talent for Cleanse Spirit (10+)
        Spell_ID = 77130,
        Spell_List = {SMARTDEBUFF_MAGIC, SMARTDEBUFF_CURSE},
      },
    },

    ["MAGE"] = {
      { -- Remove Curse (1+)
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
      { Spell_ID = 102401, Button = "R", Types = {SMARTDEBUFF_UTIL} }, -- Wild charge (5+)
      { Spell_ID = 5185, Button = "M", Types = {SMARTDEBUFF_HEAL} }, -- Healing touch (1-5)
      { Spell_ID = 774,   Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Rejuvenation (1+)
      -- 8946 - Cure Poison (1-3)
      -- 2893 - Abolish Poison (1-3)
    },
    ["MONK"]  = {
      { Spell_ID = 115078, Button = "R", Types = {SMARTDEBUFF_CHARMED} }, -- Paralysis (5+)
      { Spell_ID = 115175, Button = "M", Types = {SMARTDEBUFF_HEAL} }, -- Soothing Mist (5+)
      { Spell_ID = 115151, Button = "M", Types = {SMARTDEBUFF_HEAL} }, -- Renewing Mist (5+) >= 42
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
      { Spell_ID = 331,  Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Healing wave (1-4)
      { Spell_ID = 8004,  Button = "AL", Types = {SMARTDEBUFF_HEAL} }, -- Healing surge (1+)
      -- 2870 - Cure Disease (1-2)
      -- 331 - Healing wave (1-4)
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
Spell\
";