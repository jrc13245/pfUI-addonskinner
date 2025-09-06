pfUI.addonskinner:RegisterSkin("AtlasQuest", function()
  -- upvalue the pfUI methods we use to avoid repeated lookups
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, SkinCloseButton, SkinButton, SkinArrowButton, 
    SkinCheckbox, SkinCollapseButton, SetAllPointsOffset, SetHighlight, SkinScrollbar, 
    HookScript, hooksecurefunc, SkinDropDown, SkinSlider = 
  penv.StripTextures, penv.CreateBackdrop, penv.SkinCloseButton, penv.SkinButton, penv.SkinArrowButton, 
  penv.SkinCheckbox, penv.SkinCollapseButton, penv.SetAllPointsOffset, penv.SetHighlight, penv.SkinScrollbar, 
  penv.HookScript, penv.hooksecurefunc, penv.SkinDropDown, penv.SkinSlider

  local function reposition() 
    if AtlasORAlphaMap == "Atlas" then
      if AQ_ShownSide == "Right" then
        AtlasQuestFrame:SetPoint("TOP","AtlasFrame", 565, -81)
      else
        AtlasQuestFrame:SetPoint("TOP","AtlasFrame", -565, -81)
      end
    end
  end

  StripTextures(AtlasQuestFrame, nil, "ARTWORK")
  CreateBackdrop(AtlasQuestFrame, nil, nil, .75)
  CLOSEbutton:SetText("")
  SkinCloseButton(CLOSEbutton, AtlasQuestFrame.backdrop, -180, -6)
  StripTextures(AtlasQuestInsideFrame)
  CreateBackdrop(AtlasQuestInsideFrame, nil, nil, .9)
  CLOSEbutton2:SetText("")
  SkinCloseButton(CLOSEbutton2, AtlasQuestInsideFrame.backdrop, -6, -6)
  SkinButton(CLOSEbutton3)

  hooksecurefunc("AQ_AtlasOrAlphamap",function()
    reposition()
  end,true)
  hooksecurefunc("AQRIGHTOption_OnClick",function() 
    reposition()
  end,true)
  hooksecurefunc("AQLEFTOption_OnClick",function() 
    reposition()
  end,true)

  SkinCheckbox(AQFinishedQuest, 20)
  SkinCheckbox(AQACB, 20)
  SkinCheckbox(AQHCB, 20)
  SkinButton(STORYbutton)
  SkinButton(OPTIONbutton)

-->>-- Options frame
  StripTextures(AtlasQuestOptionFrame)
  CreateBackdrop(AtlasQuestOptionFrame, nil, nil, .75)
  SkinCheckbox(AQAutoshowOption,20)
  SkinCheckbox(AQLEFTOption,20)
  SkinCheckbox(AQRIGHTOption,20)
  SkinCheckbox(AQColourOption,20)
  SkinCheckbox(AQCheckQuestlogButton,20)
  SkinCheckbox(AQAutoQueryOption,20)
  SkinCheckbox(AQNoQuerySpamOption,20)
  SkinCheckbox(AQCompareTooltipOption,20)
  SkinButton(AQOptionCloseButton)

  pfUI.addonskinner:UnregisterSkin("AtlasQuest")
end)
