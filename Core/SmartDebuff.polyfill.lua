local _, ns = ...
-- Since Midnight (12)
ns.IsSecretValue = issecretvalue or function() return false end

-- Since The War Within (11)
ns.PickupSpell = C_Spell.PickupSpell or PickupSpell;
ns.GetSpellLink = C_Spell.GetSpellLink or GetSpellLink;
ns.Enum_SpellBookSpellBank_Pet = (Enum and Enum.SpellBookSpellBank and Enum.SpellBookSpellBank.Pet) or 1
ns.Enum_SpellBookSpellBank_Player = (Enum and Enum.SpellBookSpellBank and Enum.SpellBookSpellBank.Player) or 0

ns.IsSpellInRange = C_Spell.IsSpellInRange or function (spellnameOrId, unit)
  return IsSpellInRange(spellnameOrId, unit) == 1
end
ns.UnitInRange = function (unit)
    local result = UnitInRange(unit)
    if (ns.IsSecretValue(result)) then
        result = ns.IsSpellInRange(1229376, unit)
    end
    return result
end

ns.GetSpellCooldown = C_Spell.GetSpellCooldown or function (spellnameOrId)
  local start, duration, enabled, modRate = GetSpellCooldown(spellnameOrId);
  if (start) then
    return {
      startTime = start,
      duration = duration,
      isEnabled = enabled > 0,
      modRate = modRate,
    };
  else
    return nil;
  end
end;

ns.GetSpellInfo = C_Spell.GetSpellInfo or function (spellnameOrId)
  local spellName, _, iconID, castTime, minRange, maxRange, spellID, originalIconID = GetSpellInfo(spellnameOrId);
  if (spellName) then
    return {
          name = spellName,
          spellID = spellID,
          iconID = iconID,
          castTime = castTime,
          minRange = minRange,
          maxRange = maxRange,
          originalIconID = originalIconID,
        };
  else
    return nil;
  end
end

ns.GetSpellName = C_Spell.GetSpellName or function (spellnameOrId)
  local spellName = ns.GetSpellInfo(spellnameOrId);
  return spellName
end

ns.GetSpellTexture = C_Spell.GetSpellTexture or function (spellnameOrId)
  local _, _, iconID = ns.GetSpellInfo(spellnameOrId);
  return iconID
end

-- Check for older API before newest

ns.PickupSpellBookItem = PickupSpellBookItem or function (spellId, bookType)
  local spellBank = Enum.SpellBookSpellBank.Player;
  if bookType == "pet" then
    spellBank = Enum.SpellBookSpellBank.Pet
  elseif tonumber(bookType) then
    spellBank = tonumber(bookType)
  end
  local index = FindSpellBookSlotBySpellID(spellId, spellBank)
  return C_SpellBook.PickupSpellBookItem(index, spellBank)
end

ns.GetTalentInfo = GetTalentInfo or function(tabIndex, talentIndex, isInspect, isPet, groupIndex)
  local talentInfoQuery = {};
  talentInfoQuery.specializationIndex = tabIndex;
  talentInfoQuery.talentIndex = talentIndex;
  talentInfoQuery.isInspect = isInspect;
  talentInfoQuery.isPet = isPet;
  talentInfoQuery.groupIndex = groupIndex;
  local talentInfo = C_SpecializationInfo.GetTalentInfo(talentInfoQuery);
  if not talentInfo then
    return nil;
  end

  return talentInfo.name, talentInfo.icon, talentInfo.tier, talentInfo.column, talentInfo.rank,
    talentInfo.maxRank, talentInfo.meetsPrereq, talentInfo.previewRank,
    talentInfo.meetsPreviewPrereq, talentInfo.isExceptional, talentInfo.hasGoldBorder,
    talentInfo.talentID;
end

ns.UnitAura = UnitAura or function(unitToken, index, filter)
  local auraData = C_UnitAuras.GetAuraDataByIndex(unitToken, index, filter);
  return auraData
--   if ns.IsSecretValue(auraData) or not auraData then
--     return nil;
--   end
--   return AuraUtil.UnpackAuraData(auraData);
end

ns.UnitBuff = UnitBuff or function(unitToken, index, filter)
  local auraData = C_UnitAuras.GetBuffDataByIndex(unitToken, index, filter);
  if ns.IsSecretValue(auraData) or not auraData then
    return nil;
  end
  return AuraUtil.UnpackAuraData(auraData);
end

ns.IsSpellInSpellBook = C_SpellBook.IsSpellInSpellBook or function (spellID, spellBank)
  -- legit, can't coexist with C_SpellBook.IsSpellInSpellBook
  return IsSpellKnownOrOverridesKnown(spellID, spellBank == ns.Enum_SpellBookSpellBank_Pet and true or nil)
end
ns.IsSpellKnownOrInSpellBook = C_SpellBook.IsSpellKnownOrInSpellBook or ns.IsSpellInSpellBook


-- Cache local des API WoW pour performance
local C_UnitAuras = C_UnitAuras
local pcall = pcall


---Is dispellabl by player
---@param auraData AuraData
---@param canDispel Array of available dispel_type canDispel['Magic'] , ...
---@return boolean true if available in canDispel
local function IsDispellableByPlayer(auraData, canDispel)
    if not auraData then return false end

    -- Gestion des valeurs secrètes (secret values) dans WoW 12.0+
    local isDispellable = false
    pcall(function()
        local dispelName = auraData.dispelName
        if dispelName then
            isDispellable = (not not canDispel[dispelName])
        end
    end)

    return isDispellable
end


--[[
    SMARTDEBUFF_GetUnitDebuffs(unit, filterMode, maxDebuffs)

    Params:
        unit         - unitID (e.g., "player", "party1", "raid5", "target")
        filterMode   - Mode de filtrage:
                       "SMART"      - Debuffs boss + dispellables par le joueur
                       "DISPEL"     - Uniquement dispellables par le joueur
                       "BOSS"       - Uniquement debuffs boss
                       "ALL"        - Tous les debuffs
                       nil/autre    - Par défaut: "SMART"
        maxDebuffs   - Nombre maximum de debuffs à retourner (défaut: 40)

    Return:
        Table de debuffs, chaque entrée contient:
        {
            name          - Nom du sort (peut être secret)
            icon          - Texture de l'icône
            count         - Nombre de stacks
            dispelName    - Type de dispel (Magic, Curse, etc.)
            duration      - Durée totale
            expirationTime - Temps d'expiration
            source        - Caster du debuff (unitID)
            isStealable   - Peut être volé
            nameplateShowPersonal - Afficher sur nameplate
            spellId       - ID du sort
            canApplyAura  - Peut appliquer l'aura
            isBossAura    - Est un debuff boss
            isFromPlayerOrPlayerPet - Vient du joueur ou de son pet
            nameplateShowAll - Afficher sur toutes les nameplates
            timeMod       - Modificateur de temps
            points        - Table de points d'effet
            auraInstanceID - ID unique de l'instance d'aura
            isHarmful     - Est un debuff (toujours true ici)
            slot          - Numéro de slot (1-40)
        }
]]
function SMARTDEBUFF_GetUnitDebuffs(unit, filterMode, maxDebuffs, canDispel)
    if not unit then return {} end

    filterMode = filterMode or "SMART"
    maxDebuffs = maxDebuffs or 40

    local debuffs = {}
    for slot = 1, maxDebuffs do
        local auraData = C_UnitAuras.GetAuraDataBySlot(unit, slot)
        if auraData and not auraData.isHarmful  then
            -- auraData.isBossAura
            if IsDispellableByPlayer(auraData, canDispel) then
                auraData.slot = slot -- pour référence
                table.insert(debuffs, auraData)

                break
            end
        end
    end

    return debuffs
end




local function getColor(cSpell, colors)
    if not cSpell then
        return colors.NONE
    elseif cSpell[2] == "L" then
        return colors.LEFT
    elseif cSpell[2] == "R" then
        return colors.RIGHT
    elseif cSpell[2] == "M" then
        return colors.MIDDLE
    end
    return colors.UNKNOWN
end

-- Since Midnight (12)
-- C_UnitAuras.GetAuraDispelTypeColor(auraInstanceUnit, auraInstanceID, curve)
-- https://warcraft.wiki.gg/wiki/API_C_UnitAuras.GetAuraDispelTypeColor
-- https://github.com/Tercioo/Plater-Nameplates/blob/master/Plater_Auras.lua
local cachedCurve
ns.getCurve = function(cSpells, colors, reset)
    if (reset or not cachedCurve) then
        cachedCurve = C_CurveUtil.CreateColorCurve();
        cachedCurve:SetType(Enum.LuaCurveType.Step)
        local colorInfo = {
             [0] = colors.NONE,
             [1] = getColor(cSpells[SMARTDEBUFF_MAGIC], colors),
             [2] = getColor(cSpells[SMARTDEBUFF_CURSE], colors),
             [3] = getColor(cSpells[SMARTDEBUFF_DISEASE], colors),
             [4] = getColor(cSpells[SMARTDEBUFF_POISON], colors),
             [9] = getColor(cSpells[SMARTDEBUFF_BLEED], colors), -- enrage
            [11] = getColor(cSpells[SMARTDEBUFF_BLEED], colors),

        }
        for i, c in pairs(colorInfo) do
            cachedCurve:AddPoint(i, c)
        end
    end
    return cachedCurve
end