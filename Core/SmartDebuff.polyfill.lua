---@diagnostic disable: undefined-global
local _, ns = ...
-- Since Midnight (12)
ns.IsSecretValue = issecretvalue or function(_) return false end

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
  local spellInfo = ns.GetSpellInfo(spellnameOrId);
  return spellInfo and spellInfo.name
end

ns.GetSpellTexture = C_Spell.GetSpellTexture or function (spellnameOrId)
  local spellInfo = ns.GetSpellInfo(spellnameOrId);
  return spellInfo and spellInfo.iconID
end

-- Check for older API before newest

ns.PickupSpellBookItem = PickupSpellBookItem or function (spellId, bookType)
  local spellBank = Enum.SpellBookSpellBank.Player;
  if bookType == "pet" then
    spellBank = Enum.SpellBookSpellBank.Pet
  elseif tonumber(bookType) then
    spellBank = tonumber(bookType)
  end
  -- local spellBookItemSlotIndex, spellBookItemSpellBank = C_SpellBook.FindSpellBookSlotForSpell(spellId)
  local index = FindSpellBookSlotBySpellID(spellId, spellBank)
  if index == nil then
    return nil
  end
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

-- WARNING, can't be used with secrets
---@deprecated
ns.UnitAura = UnitAura or function(unitToken, index, filter)
  if SMARTDEBUFF_HASSECRETS then
    return nil;
  end
  local auraData = C_UnitAuras.GetAuraDataByIndex(unitToken, index, filter);
  return AuraUtil.UnpackAuraData(auraData);
end

---@deprecated
ns.UnitBuff = UnitBuff or function(unitToken, index, filter)
  if SMARTDEBUFF_HASSECRETS then
    return nil;
  end
  local auraData = C_UnitAuras.GetBuffDataByIndex(unitToken, index, filter);
  -- Since Midnight (12): doesn't work in raids
  if SMARTDEBUFF_HASSECRETS or not auraData then
    return nil;
  end
  return AuraUtil.UnpackAuraData(auraData);
end

ns.IsSpellInSpellBook = C_SpellBook.IsSpellInSpellBook or function (spellID, spellBank)
  -- legit, can't coexist with C_SpellBook.IsSpellInSpellBook
  return IsSpellKnownOrOverridesKnown(spellID, spellBank == ns.Enum_SpellBookSpellBank_Pet and true or nil)
end
ns.IsSpellKnownOrInSpellBook = C_SpellBook.IsSpellKnownOrInSpellBook or ns.IsSpellInSpellBook
ns.FindBaseSpellByID = C_SpellBook.FindBaseSpellByID or FindBaseSpellByID

