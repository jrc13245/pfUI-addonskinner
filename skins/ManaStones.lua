-- ManaStones skin for pfUI-addonskinner

local function SafeSkinManaStonesButton()
  local ok, err = pcall(function()
    local f = getglobal("ManaStonesTemp")
    if not f or not pfUI or not pfUI.api then return end

    pfUI.api.StripTextures(f)
    pfUI.api.CreateBackdrop(f)

    -- Icon
    if f.pfIcon and f.pfIcon.SetTexture then
      f.pfIcon:Hide()
      f.pfIcon:SetParent(nil)
      f.pfIcon = nil
    end
    local icon = f:CreateTexture(nil, "ARTWORK")
    icon:SetTexture("Interface\\Icons\\INV_Misc_Gem_Emerald_01")
    icon:SetAllPoints(f)
    icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    icon:SetVertexColor(1, 1, 1, 1)
    f.pfIcon = icon

    -- pfUI-style highlight (frame with backdrop)
    if f.pfHighlight and f.pfHighlight.SetBackdrop then
      f.pfHighlight:Hide()
      f.pfHighlight:SetParent(nil)
      f.pfHighlight = nil
    end
    local highlight = CreateFrame("Frame", nil, f)
    highlight:SetAllPoints(f)
    highlight:SetFrameLevel(f:GetFrameLevel() + 10)
    highlight:SetBackdrop({ edgeFile = pfUI.media["img:glow"], edgeSize = 8 })
    highlight:SetBackdropBorderColor(1, 1, 1, 0.8)
    highlight:Hide()
    f.pfHighlight = highlight

    f:EnableMouse(true)
    f:SetScript("OnEnter", function()
      if f.pfHighlight then f.pfHighlight:Show() end
      if ManaStonesTooltipCheck then ManaStonesTooltipCheck() end
    end)
    f:SetScript("OnLeave", function()
      if f.pfHighlight then f.pfHighlight:Hide() end
      if ManaStonesTooltip then ManaStonesTooltip:Hide() end
    end)
  end)
  if not ok and DEFAULT_CHAT_FRAME then
    DEFAULT_CHAT_FRAME:AddMessage("ManaStones skin error: " .. tostring(err))
  end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("VARIABLES_LOADED")
frame:SetScript("OnEvent", SafeSkinManaStonesButton)
