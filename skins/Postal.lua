pfUI.addonskinner:RegisterSkin("Postal", function()
-- place main code below
local penv = pfUI:GetEnvironment()
local HookAddonOrVariable, StripTextures, SkinButton, SkinCheckbox, CreateBackdrop, CreateBackdropShadow =
penv.HookAddonOrVariable, penv.StripTextures, penv.SkinButton, penv.SkinCheckbox, penv.CreateBackdrop, penv.CreateBackdropShadow
local GetStringColor = pfUI.api.GetStringColor

local function GetLinkColor(link)
  if not link then return end
  local color = string.match(link, "|c(%x%x%x%x%x%x%x%x)")
  if not color then return end
  local r = tonumber(string.sub(color, 3, 4), 16) / 255
  local g = tonumber(string.sub(color, 5, 6), 16) / 255
  local b = tonumber(string.sub(color, 7, 8), 16) / 255
  return r, g, b
end

local function SetQualityBorder(btn, link, hasItem, quality)
  if not btn then return end
  local target = btn.backdrop
  if not target or not target.SetBackdropBorderColor then target = btn end
  if not target or not target.SetBackdropBorderColor then return end

  local resolvedQuality = quality
  if resolvedQuality == nil and link then
    local _, _, q = GetItemInfo(link)
    if q ~= nil then resolvedQuality = q end
  end

  local r, g, b = nil, nil, nil
  if resolvedQuality ~= nil and resolvedQuality >= 0 then
    r, g, b = GetItemQualityColor(resolvedQuality)
  else
    r, g, b = GetLinkColor(link)
  end

  if r and g and b then
    target:SetBackdropBorderColor(r, g, b, 1)
    btn.rr, btn.rg, btn.rb, btn.ra = r, g, b, 1
    btn.cr, btn.cg, btn.cb, btn.ca = r, g, b, 1
  elseif hasItem then
    target:SetBackdropBorderColor(1, 1, 1, 1)
    btn.rr, btn.rg, btn.rb, btn.ra = 1, 1, 1, 1
    btn.cr, btn.cg, btn.cb, btn.ca = 1, 1, 1, 1
  else
    local br, bg, bb, ba = GetStringColor(pfUI_config.appearance.border.color)
    target:SetBackdropBorderColor(br, bg, bb, ba)
    btn.rr, btn.rg, btn.rb, btn.ra = br, bg, bb, ba
    btn.cr, btn.cg, btn.cb, btn.ca = br, bg, bb, ba
  end
end

local function GetInboxItemQuality(index)
  if not index or not GetInboxItem then return nil end
  local _, _, _, quality = GetInboxItem(index, 1)
  if quality ~= nil then return quality end
  local _, _, _, fallbackQuality = GetInboxItem(index)
  return fallbackQuality
end

local function SkinMailItemButtons()
  local max = INBOXITEMS_TO_DISPLAY or 7
  local page = InboxFrame and InboxFrame.pageNum or 1
  if page < 1 then page = 1 end

  for i = 1, max do
    local btn = _G["MailItem" .. i .. "Button"]
    if btn then
      local index = ((page - 1) * max) + i
      local hasItem = false
      if GetInboxHeaderInfo then
        local _, _, _, _, _, _, _, item = GetInboxHeaderInfo(index)
        hasItem = item and true or false
      end
      local link = nil

      if GetInboxItemLink then
        link = GetInboxItemLink(index)
      else
        local name = GetInboxItem(index)
        if name then link = pfUI.api.GetItemLinkByName(name) end
      end

      local quality = GetInboxItemQuality(index)
      SetQualityBorder(btn, link, hasItem, quality)
      btn.locked = true
    end
  end
end

local function UpdateOpenMailButton(index)
  if not OpenMailPackageButton then return end
  local hasItem = false
  if index and GetInboxHeaderInfo then
    local _, _, _, _, _, _, _, item = GetInboxHeaderInfo(index)
    hasItem = item and true or false
  end

  local link = nil
  if index and GetInboxItemLink then
    link = GetInboxItemLink(index)
  end
  if not link and index then
    local name = GetInboxItem(index)
    if name then link = pfUI.api.GetItemLinkByName(name) end
  end

  local quality = GetInboxItemQuality(index)
  SetQualityBorder(OpenMailPackageButton, link, hasItem or (link and true or false), quality)
  OpenMailPackageButton.locked = true
end
local function SkinPostalAttachments()
  for i = 1, 200 do
    local btn = _G["PostalAttachment" .. i]
    if not btn then break end

    if not btn._pfSkinned then
      StripTextures(btn, true)
      CreateBackdrop(btn, nil, nil, .75)
      if btn.SetHighlightTexture then btn:SetHighlightTexture("") end
      local origSetNormal = btn.SetNormalTexture
      btn.SetNormalTexture = function(self, tex)
        if origSetNormal then origSetNormal(self, tex) end
        local icon = self:GetNormalTexture()
        if icon and icon.SetTexCoord then
          pfUI.api.HandleIcon(self, icon)
        end
      end
      local cur = btn:GetNormalTexture()
      if cur and cur.GetTexture then
        btn:SetNormalTexture(cur:GetTexture())
      end
      local count = _G[btn:GetName() .. 'Count']
      if count and count.SetFont then
        count:SetFont(pfUI.font_default, 11, "THICKOUTLINE")
        count:SetTextColor(1, 1, 1)
      end
      btn._pfSkinned = true
    end

    local link = nil
    local hasItem = false
    if btn.bag and btn.slot then
      link = GetContainerItemLink(btn.bag, btn.slot)
      hasItem = GetContainerItemInfo(btn.bag, btn.slot) and true or false
    end

    SetQualityBorder(btn, link, hasItem)
    btn.locked = true
  end

  StripTextures(SendMailPackageButton, true)
  if SendMailPackageButton.backdrop then SendMailPackageButton.backdrop:Hide() end
end

HookAddonOrVariable("Postal", function()
  SkinButton(PostalInboxReturnSelected)
  SkinButton(PostalInboxOpenSelected)
  SkinButton(PostalInboxReturnAllButton)
  SkinButton(PostalInboxOpenAllButton)
  SkinButton(PostalMailButton)

  pcall(function()
    StripTextures(SendMailPackageButton, true)
    SkinButton(SendMailPackageButton, nil, nil, nil, SendMailPackageButton:GetNormalTexture(), true)
    if SendMailPackageButton.backdrop then SendMailPackageButton.backdrop:Hide() end
    for _, r in ipairs({SendMailPackageButton:GetRegions()}) do if r and r.SetTexture then r:Hide() end end
  end)

  for i = 1, 16 do
    local cb = _G["PostalBoxItem" .. i .. "CB"]
    if not cb then break end
    SkinCheckbox(cb)
  end

  SkinPostalAttachments()
  SkinMailItemButtons()
end)

StripTextures(PostalSubjectEditBox, false, "BACKGROUND")
CreateBackdrop(PostalSubjectEditBox)
SkinCheckbox(SendMailSendMoneyButton)
SkinCheckbox(SendMailCODButton)



-- Use Friz Quadrata for mail text and set color directly
local MAIL_FONT = "Fonts\\FRIZQT__.TTF"
InvoiceTextFontNormal:SetTextColor(1, 1, 1)
InvoiceTextFontNormal:SetFont(MAIL_FONT, 12)
InvoiceTextFontSmall:SetFont(MAIL_FONT, 11)
SendMailTitleText:SetFont(MAIL_FONT, 14)

-- Reapply fonts when the Mail frame opens (ensures pfUI or others don't overwrite)
local mailHook = CreateFrame("Frame")
mailHook:RegisterEvent("MAIL_SHOW")
mailHook:SetScript("OnEvent", function()
  InvoiceTextFontNormal:SetTextColor(1, 1, 1)
  InvoiceTextFontNormal:SetFont(MAIL_FONT, 12)
  InvoiceTextFontSmall:SetFont(MAIL_FONT, 11)
  SendMailTitleText:SetFont(MAIL_FONT, 14)
  MailTextFontNormal:SetFont(MAIL_FONT, 15); MailTextFontNormal:SetTextColor(1, 1, 1)
  ItemTextFontNormal:SetFont(MAIL_FONT, 15); ItemTextFontNormal:SetTextColor(1, 1, 1)

  pcall(function() SendStationeryBackgroundLeft:Hide() end)
  pcall(function() SendStationeryBackgroundRight:Hide() end)
  pcall(function() OpenStationeryBackgroundLeft:Hide() end)
  pcall(function() OpenStationeryBackgroundRight:Hide() end)
  pcall(function() StationeryBackgroundLeft:Hide() end)
  pcall(function() StationeryBackgroundRight:Hide() end)
  pcall(function() PostalHorizontalBarLeft:Hide() end)
  pcall(function() PostalHorizontalBarRight:Hide() end)
  pcall(function() StripTextures(SendMailScrollFrame, true) end)
  pcall(function() StripTextures(SendMailScrollChildFrame, true) end)
  pcall(function()
    for _, r in ipairs({SendMailScrollChildFrame:GetRegions()}) do if r and r.SetTexture then r:Hide() end end
    for _, c in ipairs({SendMailScrollChildFrame:GetChildren()}) do for _, r in ipairs({c:GetRegions()}) do if r and r.SetTexture then r:Hide() end end end
  end)

  pcall(function() CreateBackdrop(SendMailScrollFrame) end)
  pcall(function() CreateBackdropShadow(SendMailScrollFrame) end)
  pcall(function() SkinScrollbar(SendMailScrollFrameScrollBar) end)
  pcall(function() if SendMailScrollFrame.backdrop and SendMailScrollFrame.backdrop.SetFrameLevel then SendMailScrollFrame.backdrop:SetFrameLevel(SendMailScrollFrame:GetFrameLevel() - 1) end end)

  pcall(function()
    for _, r in ipairs({SendMailScrollChildFrame:GetRegions()}) do pcall(function() if r.SetFont then r:SetFont(MAIL_FONT, 12); r:SetTextColor(1,1,1) end end) end
  end)
end)
hooksecurefunc("SendMailFrame_Update", function()
  PostalHorizontalBarLeft:Hide()
  PostalHorizontalBarRight:Hide()
  SkinPostalAttachments()
end)
hooksecurefunc("InboxFrame_Update", function()
  SkinMailItemButtons()
end)
hooksecurefunc("InboxFrame_OnClick", function(index)
  UpdateOpenMailButton(index)
end)

if _G.Postal and _G.Postal.SendMailFrame_Update then
  hooksecurefunc(_G.Postal, "SendMailFrame_Update", function()
    pcall(SkinPostalAttachments)
  end)
end

-- remove from pending list when applied
pfUI.addonskinner:UnregisterSkin("Postal")
end)
