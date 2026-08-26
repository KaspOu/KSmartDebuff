if not C_UnitAuras or not C_UnitAuras.AddAuraSound then
    return
end


local auraSounds = {}
local auraSoundUnits = {}

local lastIsRaid
local lastInstanceID


local knownDispelTypes = {
    SMARTDEBUFF_BLEEDING,
    SMARTDEBUFF_CURSE,
    SMARTDEBUFF_DISEASE,
    SMARTDEBUFF_MAGIC,
    SMARTDEBUFF_POISON,
  }
local cacheAllIncludeDispelTypes = {}


local function BuildAuraSoundUnits()

    wipe(auraSoundUnits)

    local shouldParsePets = SMARTDEBUFF_Options.ShowPetsWL or SMARTDEBUFF_Options.ShowPetsDK or SMARTDEBUFF_Options.ShowPets

    auraSoundUnits[#auraSoundUnits + 1] = "player"
    if shouldParsePets then
        auraSoundUnits[#auraSoundUnits + 1] = "pet"
    end

    if IsInRaid() then

        -- Raid members + their pets
        for i = 1, 40 do
            auraSoundUnits[#auraSoundUnits + 1] = "raid" .. i
            if shouldParsePets then
                auraSoundUnits[#auraSoundUnits + 1] = "raidpet" .. i
            end
        end

    else

        -- Party members + their pets
        for i = 1, 4 do
            auraSoundUnits[#auraSoundUnits + 1] = "party" .. i
            if shouldParsePets then
                auraSoundUnits[#auraSoundUnits + 1] = "partypet" .. i
            end
        end
    end
end



local function ShouldShowUnit(unit)
    local isPet = false
    local owner = unit

    if unit == "pet" then
        isPet = true
        owner = "player"

    else
        isPet = unit:find("pet", 1, true) ~= nil
        owner = isPet and unit:gsub("pet", "") or unit

    end

    local _, class = UnitClass(owner)

    if not class then
        return false
    end

    if not SMARTDEBUFF_Options.DebuffClasses[class] then
        return false
    end

    local group

    if owner == "player" then
        group = 1

    elseif owner:match("^party%d+$") then
        group = 1

    elseif owner:match("^raid%d+$") then
        local raidIndex = tonumber(owner:match("%d+"))

        if not raidIndex then
            return false
        end

        local _, _, subgroup = GetRaidRosterInfo(raidIndex)
        group = subgroup
    end

    if not group or not SMARTDEBUFF_Options.DebuffGrp[group] then
        return false
    end

    if not isPet then
        return true
    end

    return (SMARTDEBUFF_Options.ShowVehicles or SMARTDEBUFF_Options.ShowPetsWL or SMARTDEBUFF_Options.ShowPetsDK or SMARTDEBUFF_Options.ShowPets) and true or false
end

-- ============================================================================
-- Remove every registered AuraSound
-- ============================================================================

local function RemoveAllAuraSounds()
    if next(auraSounds) == nil then
        return
    end
    for unit, spells in pairs(auraSounds) do
        for spellID, auraSoundID in pairs(spells) do
            if auraSoundID then
                C_UnitAuras.RemoveAuraSound(auraSoundID)
            end
        end
    end
    wipe(auraSounds)
end


-- Add one AuraSound
local function AddAuraSound(unit, spellID)

    auraSounds[unit] = auraSounds[unit] or {}

    -- Already registered
    if auraSounds[unit][spellID] then
        return
    end

    local auraSoundID = C_UnitAuras.AddAuraSound(
        Enum.UnitAuraSoundTrigger.Added,
        {
            unitToken = unit,
            spellID = spellID,
            soundFileID = SMARTDEBUFF_Options.Sound,
            outputChannel = "master",
        }
    )

    if auraSoundID then
        auraSounds[unit][spellID] = auraSoundID
    end
end


-- Add all appropriate AuraSounds for one unit
local function AddAuraSoundsForUnit(unit, listIDs, showDebug, testMode)

    local shouldShowUnit = ShouldShowUnit(unit)

    if not shouldShowUnit then
        return
    end

    listIDs[8936] = testMode and SMARTDEBUFF_MAGIC or nil

    local list = {}
    for spellID, dispelType in pairs(listIDs) do

        if cacheAllIncludeDispelTypes[dispelType] then
            AddAuraSound(unit, spellID)
            list[#list + 1] = tostring(spellID)
        end

    end

    if showDebug then
        local instanceID = select(8, GetInstanceInfo())
        SMARTDEBUFF_AddMsgD("AuraSounds IDs ('"..unit.."', instance: #"..instanceID..", "..(#list).." sounds on "..#auraSoundUnits.." units): "
            ..table.concat(list, ", ", 1, math.min(10, #list))
            .." - Test "..(listIDs[8936] and "|cffff00ffON" or "off")
        )
    end
end


-- Refresh every AuraSound
--
-- Call this when:
--
--   * class / pet configuration changes
--   * knownDebuffs changes
--   * auraSoundConfig changes
--   * entering/leaving a raid
local function RefreshAuraSounds(testMode)

    RemoveAllAuraSounds()

    BuildAuraSoundUnits()

    local instanceID = select(8, GetInstanceInfo())
    local knownDebuffs = SMARTDEBUFF_DEBUFFS_LIST[instanceID] or SMARTDEBUFF_DEBUFFS_LIST[0] or {}
    local showDebug = SMARTDEBUFF_Options.Debug

    for _, unit in ipairs(auraSoundUnits) do
        AddAuraSoundsForUnit(unit, knownDebuffs, showDebug, testMode)
        showDebug = false
    end

end

-- Detect if player debuff display has changed
--   * spec / talent change
--   * dispel on cooldown and ignore debuff
local function PlayerDispelTypesUpdated()
    local allIncludeDispelTypes = {}
    for buttonIndex = 1, 3, 1 do
      local includeDispelTypes = SMARTDEBUFF_GetAuraContainerDispelFiltersByButton(buttonIndex);
      if includeDispelTypes then
        local shouldAlertDebuff = true
        if SMARTDEBUFF_Options.IgnoreDebuff then
            local firstDispelType = next(includeDispelTypes)
            local dispelCD = SMARTDEBUFF_GetDispelCooldownByType(firstDispelType)
            shouldAlertDebuff = SMARTDEBUFF_ShouldShowDebuff(dispelCD)
        end
        if shouldAlertDebuff then
            for dispelType, _ in pairs(includeDispelTypes) do
                allIncludeDispelTypes[dispelType] = true
            end
        end
      end
    end
    for _, dispelType in ipairs(knownDispelTypes) do
      if (allIncludeDispelTypes[dispelType] ~= cacheAllIncludeDispelTypes[dispelType]) then
        cacheAllIncludeDispelTypes = allIncludeDispelTypes
        return true
      end
    end
    return false
end


-- Handle party <-> raid changes
function SMARTDEBUFF_SetAuraSounds()
  if not SMARTDEBUFF_Options.UseSound then
    RemoveAllAuraSounds()
    return
  end
  local isRaid = IsInRaid()
  local instanceID = select(8, GetInstanceInfo())

  if not SMARTDEBUFF_DEBUFFS_LIST[instanceID] then
    instanceID = 0
  end
  if instanceID == lastInstanceID and lastIsRaid == isRaid then
      return
  end

  lastIsRaid = isRaid
  lastInstanceID = instanceID

  RemoveAllAuraSounds()
  RefreshAuraSounds()
end

-- Handle Keys changes, with test mode
function SMARTDEBUFF_SetAuraSoundsOnKeySet(testMode)
  if not PlayerDispelTypesUpdated() then
    return
  end
  RemoveAllAuraSounds()
  if not SMARTDEBUFF_Options.UseSound then
    return
  end
  RefreshAuraSounds(testMode)
end

-- Handle always refresh, with test mode
function SMARTDEBUFF_SetAuraSoundsTestMode(testMode)
    RemoveAllAuraSounds()
    if not SMARTDEBUFF_Options.UseSound then
      return
    end
    RefreshAuraSounds(testMode)
end


