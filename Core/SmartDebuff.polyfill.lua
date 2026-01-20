local _, ns = ...
-- Since Midnight (12)
ns.IsSecretValue = issecretvalue or function() return false end

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
  if ns.IsSecretValue(auraData) or not auraData then
    return nil;
  end
  return AuraUtil.UnpackAuraData(auraData);
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


if (not SMARTDEBUFF_HASSECRETS) then return end
-- ============================================================
-- SmartDebuff - Nouvelle API pour les debuffs (WoW 12.0+)
-- Utilise C_UnitAuras au lieu de l'ancienne API UnitAura/UnitDebuff
-- ============================================================

-- Cache local des API WoW pour performance
local C_UnitAuras = C_UnitAuras
local UnitAuraSlots = UnitAuraSlots
local UnitIsUnit = UnitIsUnit
local GetTime = GetTime
local pcall = pcall

-- ============================================================
-- TYPES DE DISPEL (Enum WoW 12.0+)
-- ============================================================

local Enum_DispelType = {
    None = 0,
    Magic = 1,
    Curse = 2,
    Disease = 3,
    Poison = 4,
    Enrage = 9,
    Bleed = 11,
}

-- ============================================================
-- DÉTECTION DES TYPES DE DISPEL DU JOUEUR
-- ============================================================

local playerClass = nil
local playerDispelTypes = nil

local function GetPlayerDispelTypes()
    if playerDispelTypes then
        return playerDispelTypes
    end

    if not playerClass then
        playerClass = select(2, UnitClass("player"))
    end

    local canDispel = {
        PRIEST = {Magic = true, Disease = true},
        SHAMAN = {Magic = true, Curse = true},
        PALADIN = {Magic = true, Disease = true, Poison = true},
        MAGE = {Curse = true},
        DRUID = {Magic = true, Curse = true, Poison = true},
        MONK = {Magic = true, Disease = true, Poison = true},
        EVOKER = {Magic = true, Curse = true, Disease = true, Poison = true, Bleed = true},
        WARLOCK = {Magic = true},  -- Felhunter
        HUNTER = {Enrage = true, Magic = true},  -- Tranquilizing Shot + Spirit Mend (pet)
        WARRIOR = {},
        DEATHKNIGHT = {},
        ROGUE = {},
        DEMONHUNTER = {},
    }

    playerDispelTypes = canDispel[playerClass] or {}
    return playerDispelTypes
end

-- ============================================================
-- VÉRIFICATION SI DISPELLABLE PAR LE JOUEUR
-- ============================================================

local function IsDispellableByPlayer(auraData)
    if not auraData then return false end

    -- Gestion des valeurs secrètes (secret values) dans WoW 12.0+
    local isDispellable = false
    pcall(function()
        local dispelName = auraData.dispelName
        if dispelName then
            local canDispel = GetPlayerDispelTypes()
            isDispellable = canDispel[dispelName] == true
        end
    end)

    return isDispellable
end

-- ============================================================
-- DÉTECTION DES AURAS BOSS
-- ============================================================

local function IsBossAura(auraData)
    if not auraData then return false end

    -- Gestion des valeurs secrètes
    local isBoss = false
    pcall(function()
        if auraData.isBossAura then
            isBoss = true
        end
    end)

    return isBoss
end

-- ============================================================
-- FONCTION PRINCIPALE : CHECK UNIT DEBUFFS
-- Remplace l'ancienne SMARTDEBUFF_GetUnitDebuffs
-- ============================================================

--[[
    SMARTDEBUFF_GetUnitDebuffs(unit, filterMode, maxDebuffs)

    Paramètres:
        unit         - unitID (e.g., "player", "party1", "raid5", "target")
        filterMode   - Mode de filtrage:
                       "SMART"      - Debuffs boss + dispellables par le joueur
                       "DISPEL"     - Uniquement dispellables par le joueur
                       "BOSS"       - Uniquement debuffs boss
                       "ALL"        - Tous les debuffs
                       nil/autre    - Par défaut: "SMART"
        maxDebuffs   - Nombre maximum de debuffs à retourner (défaut: 40)

    Retour:
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

function SMARTDEBUFF_GetUnitDebuffs(unit, filterMode, maxDebuffs)
    if not unit then return {} end

    filterMode = filterMode or "SMART"
    maxDebuffs = maxDebuffs or 40

    local debuffs = {}
    local filter = "HARMFUL"  -- On ne récupère que les debuffs

    -- Vérifier que l'API est disponible
    if not C_UnitAuras or not C_UnitAuras.GetAuraDataBySlot then
        -- Fallback: retourner table vide si nouvelle API non disponible
        return debuffs
    end

    -- Obtenir les slots d'auras pour cette unité
    local slots = UnitAuraSlots and UnitAuraSlots(unit, filter)
    if not slots then
        -- Fallback: scanner manuellement les slots 1-40
        for slot = 1, maxDebuffs do
            local auraData = C_UnitAuras.GetAuraDataBySlot(unit, slot, filter)

            if auraData then
                local shouldInclude = false

                -- Appliquer le filtre selon le mode
                if filterMode == "ALL" then
                    shouldInclude = true

                elseif filterMode == "BOSS" then
                    shouldInclude = IsBossAura(auraData)

                elseif filterMode == "DISPEL" then
                    shouldInclude = IsDispellableByPlayer(auraData)

                else  -- "SMART" ou défaut
                    -- Boss OU dispellable
                    shouldInclude = IsBossAura(auraData) or IsDispellableByPlayer(auraData)
                end

                if shouldInclude then
                    -- Ajouter le numéro de slot pour référence
                    auraData.slot = slot
                    table.insert(debuffs, auraData)

                    -- Arrêter si on a atteint le maximum
                    if #debuffs >= maxDebuffs then
                        break
                    end
                end
            end
        end

        return debuffs
    end

    -- Nouvelle méthode: utiliser UnitAuraSlots (plus efficace)
    local ContinueOnSlot = true
    for i = 1, #slots do
        if not ContinueOnSlot then
            break
        end

        local slot = slots[i]
        local auraData = C_UnitAuras.GetAuraDataBySlot(unit, slot, filter)

        if auraData then
            local shouldInclude = false

            -- Appliquer le filtre selon le mode
            if filterMode == "ALL" then
                shouldInclude = true

            elseif filterMode == "BOSS" then
                shouldInclude = IsBossAura(auraData)

            elseif filterMode == "DISPEL" then
                shouldInclude = IsDispellableByPlayer(auraData)

            else  -- "SMART" ou défaut
                -- Boss OU dispellable
                shouldInclude = IsBossAura(auraData) or IsDispellableByPlayer(auraData)
            end

            if shouldInclude then
                -- Ajouter le numéro de slot pour référence
                auraData.slot = slot
                table.insert(debuffs, auraData)

                -- Arrêter si on a atteint le maximum
                if #debuffs >= maxDebuffs then
                    ContinueOnSlot = false
                end
            end
        end
    end

    return debuffs
end

-- ============================================================
-- FONCTION UTILITAIRE : Obtenir un debuff spécifique par auraInstanceID
-- ============================================================

--[[
    SMARTDEBUFF_GetDebuffByInstanceID(unit, auraInstanceID)

    Paramètres:
        unit           - unitID
        auraInstanceID - ID unique de l'instance d'aura

    Retour:
        auraData ou nil si non trouvé
]]

function SMARTDEBUFF_GetDebuffByInstanceID(unit, auraInstanceID)
    if not unit or not auraInstanceID then return nil end
    if not C_UnitAuras or not C_UnitAuras.GetAuraDataByAuraInstanceID then
        return nil
    end

    return C_UnitAuras.GetAuraDataByAuraInstanceID(unit, auraInstanceID)
end

-- ============================================================
-- FONCTION UTILITAIRE : Compter les debuffs d'un type spécifique
-- ============================================================

--[[
    SMARTDEBUFF_CountDebuffsByType(unit, dispelType)

    Paramètres:
        unit       - unitID
        dispelType - Type de dispel à compter ("Magic", "Curse", "Disease", "Poison", "Enrage", "Bleed")

    Retour:
        Nombre de debuffs de ce type
]]

function SMARTDEBUFF_CountDebuffsByType(unit, dispelType)
    if not unit or not dispelType then return 0 end

    local count = 0
    local filter = "HARMFUL"

    if not C_UnitAuras or not C_UnitAuras.GetAuraDataBySlot then
        return 0
    end

    -- Scanner tous les slots
    for slot = 1, 40 do
        local auraData = C_UnitAuras.GetAuraDataBySlot(unit, slot, filter)

        if auraData then
            -- Vérifier le type de dispel (avec gestion des secret values)
            local success = pcall(function()
                if auraData.dispelName == dispelType then
                    count = count + 1
                end
            end)
        else
            -- Plus de debuffs à scanner
            break
        end
    end

    return count
end

-- ============================================================
-- FONCTION UTILITAIRE : Vérifier si une unité a un debuff dispellable
-- ============================================================

--[[
    SMARTDEBUFF_HasDispellableDebuff(unit)

    Paramètres:
        unit - unitID

    Retour:
        true si l'unité a au moins un debuff que le joueur peut dispell
]]

function SMARTDEBUFF_HasDispellableDebuff(unit)
    if not unit then return false end

    local filter = "HARMFUL"

    if not C_UnitAuras or not C_UnitAuras.GetAuraDataBySlot then
        return false
    end

    -- Scanner jusqu'à trouver un debuff dispellable
    for slot = 1, 40 do
        local auraData = C_UnitAuras.GetAuraDataBySlot(unit, slot, filter)

        if auraData then
            if IsDispellableByPlayer(auraData) then
                return true
            end
        else
            -- Plus de debuffs
            break
        end
    end

    return false
end

-- ============================================================
-- FONCTION UTILITAIRE : Vérifier si une unité a un debuff boss
-- ============================================================

--[[
    SMARTDEBUFF_HasBossDebuff(unit)

    Paramètres:
        unit - unitID

    Retour:
        true si l'unité a au moins un debuff boss
]]

function SMARTDEBUFF_HasBossDebuff(unit)
    if not unit then return false end

    local filter = "HARMFUL"

    if not C_UnitAuras or not C_UnitAuras.GetAuraDataBySlot then
        return false
    end

    -- Scanner jusqu'à trouver un debuff boss
    for slot = 1, 40 do
        local auraData = C_UnitAuras.GetAuraDataBySlot(unit, slot, filter)

        if auraData then
            if IsBossAura(auraData) then
                return true
            end
        else
            -- Plus de debuffs
            break
        end
    end

    return false
end

-- ============================================================
-- EXEMPLE D'UTILISATION
-- ============================================================

--[[
    -- Obtenir tous les debuffs importants (boss + dispellables)
    local debuffs = SMARTDEBUFF_GetUnitDebuffs("target", "SMART", 8)
    for i, debuff in ipairs(debuffs) do
        print(string.format("%d. %s (slot %d) - %s",
            i,
            debuff.name or "Unknown",
            debuff.slot,
            debuff.dispelName or "None"))
    end

    -- Obtenir uniquement les debuffs dispellables
    local dispellableDebuffs = SMARTDEBUFF_GetUnitDebuffs("player", "DISPEL")

    -- Compter les debuffs Magic sur la cible
    local magicCount = SMARTDEBUFF_CountDebuffsByType("target", "Magic")

    -- Vérifier si le joueur a un debuff dispellable
    if SMARTDEBUFF_HasDispellableDebuff("player") then
        print("Vous avez un debuff que vous pouvez dispel !")
    end
]]


