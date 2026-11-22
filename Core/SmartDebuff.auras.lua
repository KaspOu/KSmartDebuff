-------------------------------------------------------------------------------
-- KDecurse
-- Developed by Kallye (EU-Elune)  (cloned from Aeldra)
--
-- SmartDebuff Auras (SDA) : gestion lazy des frames AuraContainer (retail 12).
-- Crée les containers/slots de dispel à la demande : hors combat, pour les
-- unités affichées, pour les boutons assignés à un dispel. Aucun pcall de
-- détection d'existence : HasAuraSlot fait le test. Voir §4.6 de
-- docs/architecture.md et le spec .kaspou/work/KD-lazy-auras/spec.md.
-------------------------------------------------------------------------------

SDA = {};

-- Registres (unique propriétaire)
SDA.containersByButton = {};   -- [buttonName] = { [1..3] = dispelContainer, facade = facade }
SDA.slotsByKey = {};           -- [slotKey] = { container = dispelContainer, slotButton = slotButton }
SDA.lastCandidateFilters = {}; -- [slotKey] = derniers candidateFilters appliqués
SDA.initFailed = 0;

local labels = {SMARTDEBUFF_KEY_L, SMARTDEBUFF_KEY_R, SMARTDEBUFF_KEY_M};
local lastDispelCD = {};
local _, playerClass = UnitClass("player");

-- Façade Show()/Hide() propagée aux 3 dispelContainers (allouée une fois par bouton)
local function MakeFacade(entry)
  local facade = {};
  function facade:Show()
    for buttonIndex = 1, 3 do
      entry[buttonIndex]:Show();
    end
  end
  function facade:Hide()
    for buttonIndex = 1, 3 do
      entry[buttonIndex]:Hide();
    end
  end
  return facade;
end

local function SlotKey(idx, isPet, buttonIndex)
  return (isPet and "sdb_pet_" or "sdb_") .. idx .. "_" .. buttonIndex;
end

-- Égalité ensembliste de deux sets { [clé] = booléen } (nil ≡ set vide)
local function SetEquals(a, b)
  if (a == b) then return true; end
  a = a or {};
  b = b or {};
  for k, v in pairs(a) do
    if (b[k] ~= v) then return false; end
  end
  for k, v in pairs(b) do
    if (a[k] ~= v) then return false; end
  end
  return true;
end

local function FiltersEqual(a, b)
  if (a == nil or b == nil) then return false; end
  return SetEquals(a.includeDispelTypes, b.includeDispelTypes)
    and SetEquals(a.excludeSpellIDs, b.excludeSpellIDs)
    and SetEquals(a.includeSpellIDs, b.includeSpellIDs);
end

-- xpcall autour de la seule création (CreateFrame / AddAuraSlot) :
-- compteur d'échec + journalisation (contexte inchangé), puis
-- SMARTDEBUFF_UseAuraContainerPath() bascule définitivement à false.
local function GuardCreate(fn, idx, unit, isPet)
  return xpcall(fn, function(err)
    SDA.initFailed = SDA.initFailed + 1;
    SMARTDEBUFF_AddMsgErrT("CRITICAL ERROR: ", tostring(err), true)
    local un, uc = "?", "?"
    if (unit ~= nil) then
      un = UnitName(unit); uc = UnitClass(unit);
    end
    SMARTDEBUFF_AddMsgErrT("Init failed for container, please report the issue... >", SDA.initFailed.. " errors.. ("..UnitClass("player")..", "..idx..", "..un..", "..uc..", "..tostring(isPet)..")", true)
    return err
  end);
end

function SDA:HasInitFailed()
  return self.initFailed > 0;
end

function SDA:Reset()
  for slotKey, rec in pairs(self.slotsByKey) do
    rec.container:SetAuraSlotEnabled(slotKey, false);
  end
  self.slotsByKey = {};
  self.containersByButton = {};
  self.lastCandidateFilters = {};
end

function SDA:RefreshTextures(force)
  if (not force) then
    return;
  end
  local O = SMARTDEBUFF_Options;
  if (not O) then
    return;
  end
  for _, entry in pairs(self.containersByButton) do
    for buttonIndex = 1, 3 do
      local dispelContainer = entry[buttonIndex];
      local auraButton = dispelContainer and dispelContainer.auraButton;
      if (auraButton and auraButton:CanBeAccessedInContext()) then
        local buttonColor = SMARTDEBUFF_GetAuraContainerColorByButtonIndex(buttonIndex);
        local colorOverlay, border, text = auraButton.colorOverlay, auraButton.border, auraButton.text
        colorOverlay:SetColorTexture(1, 1, 1, 1)
        if O.ColDTexture == "-" then
          colorOverlay:SetVertexColor(buttonColor.r, buttonColor.g, buttonColor.b, O.ADebuff)
          auraButton:SetIcon(colorOverlay)
        elseif O.ColDTexture ~= "" then
          colorOverlay:SetTexture(SMARTDEBUFF_GetIcon(O.ColDTexture))
        end
        colorOverlay:SetVertexColor(buttonColor.r, buttonColor.g, buttonColor.b, O.ADebuff)
        border:SetVertexColor(buttonColor.r, buttonColor.g, buttonColor.b, O.ADebuff)
        text:SetShown(O.ShowLR)
        local sbs_coltext = SMARTDEBUFF_GetAuraContainerTextColorByButtonIndex(buttonIndex)
        text:SetTextColor(sbs_coltext.r, sbs_coltext.g, sbs_coltext.b, O.ADebuff)
        auraButton.ColDTexture = O.ColDTexture
      end
    end
  end
end

function SDA:_createContainers(idx, unit, isPet, button, buttonName)
  local entry = nil;
  local ok = GuardCreate(function()
    entry = {};
    for buttonIndex = 1, 3 do
      local dispelContainer = CreateFrame("AuraContainer", nil, button, "CustomAuraContainerTemplate");
      dispelContainer:SetPoint("BOTTOMLEFT", button, "TOPLEFT", 0, 2);
      dispelContainer:SetWidth(button:GetWidth());
      dispelContainer:SetHeight(math.max(8, button:GetHeight() * 0.26));
      dispelContainer.HasAuraSlot = dispelContainer.HasAuraSlot or function(self, slotKey)
        return self['__'..slotKey] ~= nil;
      end
      entry[buttonIndex] = dispelContainer;
    end
    button.dispelContainers = { entry[1], entry[2], entry[3] };
    entry.facade = MakeFacade(entry);
  end, idx, unit, isPet);
  if (not ok) then
    return nil;
  end
  self.containersByButton[buttonName] = entry;
  return entry;
end

function SDA:_adopt(idx, isPet, button, buttonName)
  local containers = button.dispelContainers;
  if (not containers) then
    return nil;
  end
  local entry = {};
  for buttonIndex = 1, 3 do
    local dispelContainer = containers[buttonIndex];
    entry[buttonIndex] = dispelContainer;
    local slotKey = SlotKey(idx, isPet, buttonIndex);
    if (dispelContainer:HasAuraSlot(slotKey)) then
      self.slotsByKey[slotKey] = { container = dispelContainer, slotButton = dispelContainer.auraButton };
    end
  end
  entry.facade = MakeFacade(entry);
  self.containersByButton[buttonName] = entry;
  return entry;
end

function SDA:_createSlot(idx, unit, isPet, button, buttonIndex, dispelContainer, slotKey, includeDispelTypes)
  local O = SMARTDEBUFF_Options;
  local btnTxt = labels[buttonIndex] or "?"
  if (idx == 1 and O and O.Debug) then
    local list = ""
    for dispelType, _ in pairs(includeDispelTypes) do
      list = list.. " " .. dispelType
    end
    SMARTDEBUFF_AddMsgDT("AuraContainers for button " .. buttonIndex.. " ("..(btnTxt ).."): ", list)
  end
  local buttonColor = SMARTDEBUFF_GetAuraContainerColorByButtonIndex(buttonIndex);
  local candidateFilters = {
    includeDispelTypes = includeDispelTypes,
    excludeSpellIDs = SMARTDEBUFF_GetAuraContainerExcludeSpellIDs(unit),
  }
  local slotButton = nil;
  local ok = GuardCreate(function()
    dispelContainer['__'..slotKey] = true
    slotButton = dispelContainer:AddAuraSlot(slotKey, SMARTDEBUFF_GetFilterString(), {
      candidateFilters = candidateFilters,
      initializeFrame = function(auraButton)
        auraButton:SetAllPoints(button);
        auraButton:SetFrameStrata("HIGH")
        auraButton:EnableMouse(O.ShowDebuffTooltip);

        local colorOverlay = auraButton:CreateTexture(nil, "BACKGROUND");
        colorOverlay:SetBlendMode("BLEND");
        colorOverlay:SetAllPoints();
        colorOverlay:SetColorTexture(1, 1, 1, 1);
        if O.ColDTexture == "-" then
          auraButton:SetIcon(colorOverlay)
        elseif O.ColDTexture ~= "" then
          colorOverlay:SetTexture(SMARTDEBUFF_GetIcon(O.ColDTexture))
        end
        colorOverlay:SetVertexColor(buttonColor.r, buttonColor.g, buttonColor.b, O.ADebuff);
        auraButton.colorOverlay = colorOverlay
        auraButton.ColDTexture = O.ColDTexture

        local border = auraButton:CreateTexture(nil, "OVERLAY")
        border:SetTexture("Interface\\Buttons\\CheckButtonHilight") -- Bordure brillante classique d'action bar
        border:SetBlendMode("ADD") -- Rend la bordure plus lumineuse
        border:SetPoint("TOPLEFT", auraButton, "TOPLEFT", -2, 2)
        border:SetPoint("BOTTOMRIGHT", auraButton, "BOTTOMRIGHT", 2, -2)
        border:SetVertexColor(buttonColor.r, buttonColor.g, buttonColor.b, O.ADebuff);
        auraButton.border = border

        local text = auraButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetFont(SMARTDEBUFF_FONT, O.BtnH - 2, "");
        local offsetY = -math.floor((O.BtnH - 20) / 10)
        text:SetPoint("CENTER", auraButton, "CENTER", 0, offsetY);
        -- 20 : 0 , 40 : 2
        text:SetText("")
        local sbs_coltext = SMARTDEBUFF_GetAuraContainerTextColorByButtonIndex(buttonIndex)
        text:SetTextColor(sbs_coltext.r, sbs_coltext.g, sbs_coltext.b, O.ADebuff)
        text:SetText(btnTxt)
        text:SetShown(O.ShowLR)
        auraButton.text = text
        dispelContainer.auraButton = auraButton
      end,
    })
  end, idx, unit, isPet);
  if (ok) then
    self.slotsByKey[slotKey] = { container = dispelContainer, slotButton = slotButton };
    self.lastCandidateFilters[slotKey] = candidateFilters;
  end
end

function SDA:SyncButton(idx, unit, inRange, isPet)
  local buttonName = isPet and ("SmartDebuffPetBtn" .. idx) or ("SmartDebuffBtn" .. idx)
  local button = _G[buttonName];
  if (not button) then
    return nil;
  end
  local O = SMARTDEBUFF_Options;
  local buttonShown = button:IsShown();

  -- Ré-adoption des frames déjà présentes (après Reset) : jamais de doublon
  local entry = self.containersByButton[buttonName];
  if (not entry and button.dispelContainers) then
    entry = self:_adopt(idx, isPet, button, buttonName);
  end
  -- Création lazy des containers : hors combat + unité affichée + bouton shown
  -- (l'assignation à un dispel ne conditionne que la création des slots, cf. notes)
  if (not entry) then
    if (InCombatLockdown() or unit == nil or not buttonShown) then
      return nil;
    end
    entry = self:_createContainers(idx, unit, isPet, button, buttonName);
    if (not entry) then
      return nil;
    end
  end

  for buttonIndex = 1, 3 do
    SMARTDEBUFF_SetBtnOverlay(idx, unit, inRange, button, buttonIndex);
    local dispelContainer = entry[buttonIndex];
    local slotKey = SlotKey(idx, isPet, buttonIndex);
    local includeDispelTypes = SMARTDEBUFF_GetAuraContainerDispelFiltersByButton(buttonIndex);
    local slotExists = dispelContainer:HasAuraSlot(slotKey);
    if (not slotExists and not InCombatLockdown() and unit ~= nil and buttonShown and includeDispelTypes) then
      self:_createSlot(idx, unit, isPet, button, buttonIndex, dispelContainer, slotKey, includeDispelTypes);
      slotExists = dispelContainer:HasAuraSlot(slotKey);
    end
    local shouldShowDebuff = unit ~= nil and buttonShown and not not includeDispelTypes;
    if (shouldShowDebuff and playerClass == "HUNTER") then
      shouldShowDebuff = UnitIsUnit(unit, "player")
    end
    if (shouldShowDebuff and O.IgnoreDebuff) then
      local firstDispelType = next(includeDispelTypes)
      local dispelCD = SMARTDEBUFF_GetDispelCooldownByType(firstDispelType)
      if lastDispelCD[buttonIndex] ~= dispelCD then
        SMARTDEBUFF_SetAuraSoundsDetectTest()
        lastDispelCD[buttonIndex] = dispelCD
      end
      shouldShowDebuff = SMARTDEBUFF_ShouldShowDebuff(dispelCD)
    end
    if (slotExists) then
      if (shouldShowDebuff) then
        dispelContainer:SetUnit(unit);
        dispelContainer:SetAuraSlotFilterString(slotKey, SMARTDEBUFF_GetFilterString());
        local candidateFilters = {
          includeDispelTypes = includeDispelTypes,
          excludeSpellIDs = SMARTDEBUFF_GetAuraContainerExcludeSpellIDs(unit),
        };
        if (not FiltersEqual(candidateFilters, self.lastCandidateFilters[slotKey])) then
          dispelContainer:SetAuraSlotCandidateFilters(slotKey, candidateFilters);
          self.lastCandidateFilters[slotKey] = candidateFilters;
        end
        dispelContainer:SetAuraSlotEnabled(slotKey, true);
      else
        dispelContainer:SetAuraSlotEnabled(slotKey, false);
      end
      dispelContainer:SetEnabled(shouldShowDebuff);
      dispelContainer:SetShown(shouldShowDebuff);
    end
  end
  return entry.facade;
end
