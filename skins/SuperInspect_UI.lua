pfUI.addonskinner:RegisterSkin("SuperInspect_UI", function()
  -- upvalue the pfUI methods we use to avoid repeated lookups
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, SkinCloseButton, SkinButton, SkinArrowButton, 
    SkinCheckbox, SkinCollapseButton, SetAllPointsOffset, SetHighlight, SkinScrollbar, 
    HookScript, hooksecurefunc, SkinDropDown, SkinSlider, HandleIcon = 
  penv.StripTextures, penv.CreateBackdrop, penv.SkinCloseButton, penv.SkinButton, penv.SkinArrowButton, 
  penv.SkinCheckbox, penv.SkinCollapseButton, penv.SetAllPointsOffset, penv.SetHighlight, penv.SkinScrollbar, 
  penv.HookScript, penv.hooksecurefunc, penv.SkinDropDown, penv.SkinSlider, penv.HandleIcon

  local noop = function() end
	
  StripTextures(SuperInspectFrameHeader)
  --CreateBackdrop(SuperInspectFrameHeader, nil, nil, .25)
  StripTextures(SuperInspectFrame)
  CreateBackdrop(SuperInspectFrame, nil, nil, .75)
  StripTextures(SuperInspect_InRangeFrame)
  CreateBackdrop(SuperInspect_InRangeFrame, nil, nil, .75)
  SuperInspect_InRangeFrame:SetPoint("TOP", 0, 105)
  SuperInspect_InRangeFrame:SetHeight(30)
  SuperInspect_InRangeFrame_Text:SetPoint("TOP", 0, 0)
  SuperInspect_InRangeFrame_Text2:SetPoint("TOP", 0, -18)
  SkinCloseButton(SuperInspectFrameHeader_CloseButton, SuperInspectFrame.backdrop, -6, -6)

  SkinArrowButton(SIButton, "right", 20)
  StripTextures(SuperInspect_ItemBonusesFrame)
  CreateBackdrop(SuperInspect_ItemBonusesFrame, nil, nil, .75)
  SkinArrowButton(SuperInspect_CompareButton, "right", 16)
  StripTextures(SuperInspect_COHBonusesFrame)
  CreateBackdrop(SuperInspect_COHBonusesFrame, nil, nil, .75)
  StripTextures(SuperInspect_USEBonusesFrame)
  CreateBackdrop(SuperInspect_USEBonusesFrame, nil, nil, .75)
  StripTextures(SuperInspect_SnTBonusesFrame)
  CreateBackdrop(SuperInspect_SnTBonusesFrame, nil, nil, .75)

  StripTextures(SuperInspect_HonorFrameProgressBar)
  CreateBackdrop(SuperInspect_HonorFrameProgressBar, nil, nil, .9)
  StripTextures(SuperInspect_HonorFrameProgressBarBG)
  SuperInspect_HonorFrameProgressBar:SetStatusBarTexture("Interface\\AddOns\\pfUI\\img\\bar")
  StripTextures(SuperInspect_HonorFrameProgressButton)
  CreateBackdrop(SuperInspect_HonorFrameProgressButton, nil, nil, .25)

  StripTextures(SuperInspect_ItemBonusesFrameCompare)
  CreateBackdrop(SuperInspect_ItemBonusesFrameCompare, nil, nil, .75)
  SuperInspect_ItemBonusesFrameCompare:ClearAllPoints()
  SuperInspect_ItemBonusesFrameCompare:SetPoint("TOPLEFT", SuperInspectFrame.backdrop, "TOPRIGHT", 1, -81)
  SkinCloseButton(SuperInspect_ItemBonusesFrameCompare_CloseButton, SuperInspect_ItemBonusesFrameCompare.backdrop, -6, -6)
  SkinButton(SuperInspect_Button_ShowHonor)
  SkinButton(SuperInspect_Button_ShowBonuses)
  SkinButton(SuperInspect_Button_ShowMobInfo)
  SkinButton(SuperInspect_Button_ShowItems)

  SuperInspect_BonusFrameParent:SetPoint("TOP", 0, -25)
  SuperInspect_HonorFrame:SetPoint("TOP", 0, -2)
  StripTextures(SuperInspect_BonusFrameParentTab1)
  CreateBackdrop(SuperInspect_BonusFrameParentTab1, nil, nil, .75)
  SuperInspect_BonusFrameParentTab1:SetHeight(16)
  StripTextures(SuperInspect_BonusFrameParentTab2)
  CreateBackdrop(SuperInspect_BonusFrameParentTab2, nil, nil, .75)
  SuperInspect_BonusFrameParentTab2:SetHeight(16)
  StripTextures(SuperInspect_BonusFrameParentTab3)
  CreateBackdrop(SuperInspect_BonusFrameParentTab3, nil, nil, .75)
  SuperInspect_BonusFrameParentTab3:SetHeight(16)
  StripTextures(SuperInspect_BonusFrameParentTab4)
  CreateBackdrop(SuperInspect_BonusFrameParentTab4, nil, nil, .75)
  SuperInspect_BonusFrameParentTab4:SetHeight(16)
	
  StripTextures(SuperInspect_HonorFrame)
  CreateBackdrop(SuperInspect_HonorFrame, nil, nil, .75)
	
  StripTextures(SIInfoFrame)
  CreateBackdrop(SIInfoFrame, nil, nil, .75)
  SIInfoFrame:ClearAllPoints()
  SIInfoFrame:SetPoint("TOPLEFT", SuperInspectFrame.backdrop, "TOPRIGHT", 1, -44)
  SkinCloseButton(SIInfoCloseButton, SIInfoFrame.backdrop, -6, -6)
  SkinScrollbar(SIInfoScrollFrameScrollBar)
	
  SuperInspectFramePortrait:Hide()
	
  pfUI.addonskinner:UnregisterSkin("SuperInspect_UI")
end)
