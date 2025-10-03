local _, ns = ...

-- Since The War Within (11)
ns.PickupSpell = C_Spell.PickupSpell or PickupSpell;
ns.GetSpellLink = C_Spell.GetSpellLink or GetSpellLink;
ns.Enum_SpellBookSpellBank_Pet = (Enum and Enum.SpellBookSpellBank and Enum.SpellBookSpellBank.Pet) or 1
ns.Enum_SpellBookSpellBank_Player = (Enum and Enum.SpellBookSpellBank and Enum.SpellBookSpellBank.Player) or 0

ns.IsSpellInRange = C_Spell.IsSpellInRange or function (spellnameOrId)
  return IsSpellInRange(spellnameOrId) == 1
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
  if not auraData then
    return nil;
  end
  return AuraUtil.UnpackAuraData(auraData);
end

ns.UnitBuff = UnitBuff or function(unitToken, index, filter)
  local auraData = C_UnitAuras.GetBuffDataByIndex(unitToken, index, filter);
  if not auraData then
    return nil;
  end
  return AuraUtil.UnpackAuraData(auraData);
end

ns.IsSpellInSpellBook = C_SpellBook.IsSpellInSpellBook or function (spellID, spellBank)
  -- legit, can't coexist with C_SpellBook.IsSpellInSpellBook
  return IsSpellKnownOrOverridesKnown(spellID, spellBank == ns.Enum_SpellBookSpellBank_Pet and true or nil)
end
ns.IsSpellKnownOrInSpellBook = C_SpellBook.IsSpellKnownOrInSpellBook or ns.IsSpellInSpellBook