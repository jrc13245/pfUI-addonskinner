pfUI.addonskinner:RegisterSkin("TalentSequence", function()
  local penv = pfUI:GetEnvironment()
  local default_border = pfUI_config.appearance.border.default
  local StripTextures, CreateBackdrop, SkinButton, SkinScrollbar, CreateBackdropShadow, HookAddonOrVariable, hooksecurefunc, HookScript = 
  penv.StripTextures, penv.CreateBackdrop, penv.SkinButton, penv.SkinScrollbar, penv.CreateBackdropShadow, penv.HookAddonOrVariable, penv.hooksecurefunc, penv.HookScript

  local Skin = function()
    if TalentOrderFrame.backdrop then return end
    StripTextures(TalentOrderFrame)
    CreateBackdrop(TalentOrderFrame, nil, nil, .75)
    CreateBackdropShadow(TalentOrderFrame)
    SkinScrollbar(TalentOrderFrameScrollBarScrollBar)
    SkinButton(TalentOrderFrameImportButton)
    SkinButton(ShowTalentOrderButton)
    ShowTalentOrderButton:ClearAllPoints()
    ShowTalentOrderButton:SetPoint("RIGHT", TalentFrameCloseButton, "LEFT", -5, 0)
    for i=1,10 do
      local btn = getglobal(string.format("TalentOrderFrameRow%dIcon",i))
      local icon = getglobal(string.format("TalentOrderFrameRow%dIconIconTexture",i))
      StripTextures(btn)
      SkinButton(btn, nil, nil, nil, icon)
    end
    if TalentFrame.backdrop then
      TalentOrderFrame:ClearAllPoints()
      TalentOrderFrame:SetPoint("TOPLEFT", TalentFrame.backdrop, "TOPRIGHT", 5, -default_border)
      TalentOrderFrame:SetPoint("BOTTOMLEFT", TalentFrame.backdrop, "BOTTOMRIGHT", 5, default_border)
    end
  end
  HookAddonOrVariable("TalentSequence", function()
    Skin()
  end)
  if TalentFrame then
    if TalentOrderFrame then
      HookScript(TalentFrame, "OnShow", Skin)
    end
  else
    HookAddonOrVariable("Blizzard_TalentUI", function()
      if TalentOrderFrame then
        HookScript(TalentFrame, "OnShow", Skin)
      end
    end)
  end

  pfUI.addonskinner:UnregisterSkin("TalentSequence")
end)