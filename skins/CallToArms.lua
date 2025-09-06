pfUI.addonskinner:RegisterSkin("CallToArms", function()
  -- upvalue the pfUI methods we use to avoid repeated lookups
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, SkinCloseButton, SkinButton, SkinArrowButton, 
    SkinCheckbox, SkinCollapseButton, SetAllPointsOffset, SetHighlight, SkinScrollbar, 
    HookScript, SkinDropDown, SkinSlider, SkinTab = 
  penv.StripTextures, penv.CreateBackdrop, penv.SkinCloseButton, penv.SkinButton, penv.SkinArrowButton, 
  penv.SkinCheckbox, penv.SkinCollapseButton, penv.SetAllPointsOffset, penv.SetHighlight, penv.SkinScrollbar, 
  penv.HookScript, penv.SkinDropDown, penv.SkinSlider, penv.SkinTab

  local noop = function() end
  local SkinArrowButtonWrapper = function(button, dir, size)
    SkinArrowButton(button, dir, size)
    if not (button.icon:GetTexture()) then
      button.icon:SetTexture("Interface\\AddOns\\pfUI-addonskinner\\media\\img\\" .. dir)
    end
  end

  CreateBackdrop(CTA_SearchFrame_Filters_PlayerInternalFrame)
  CreateBackdrop(CTA_SearchFrame_Filters_GroupInternalFrame)
  CreateBackdrop(CTA_GreyListItemEditFrame)
  CreateBackdrop(CTA_SettingsFrameLFxSettings)
  CreateBackdrop(CTA_LogFrameInternalFrame)
  CreateBackdrop(CTA_SettingsFrameMinimapSettings)
  
  SkinDropDown(CTA_SearchDropDown)
  SkinDropDown(CTA_PlayerClassDropDown)
  SkinDropDown(CTA_RoleplayDropDown)
  
  SkinButton(CTA_SearchButton)
  SkinButton(CTA_RequestInviteButton)
  SkinButton(CTA_ConvertToRaidButton)
  SkinButton(CTA_ConvertToPartyButton)
  SkinButton(CTA_StopHostingButton)
  SkinButton(CTA_ToggleViewableButton)
  SkinButton(CTA_AnnounceToLFGButton)
  SkinButton(CTA_StartAPartyButton)
  SkinButton(CTA_StartARaidButton)
  SkinButton(CTA_AnnounceToLFGButton2)
  SkinButton(CTA_AddPlayerButton)
  SkinButton(CTA_GreyListItemEditFrameEditButton)
  SkinButton(CTA_GreyListItemEditFrameDeleteButton)
  SkinButton(CTA_GreyListItemEditFrameCloseButton)

  CreateBackdrop(CTA_InformationDialog,nil,nil,.75)
  SkinButton(CTA_InformationDialogOkButton)
  SkinButton(CTA_InformationDialogCloseButton)
  CreateBackdrop(CTA_JoinRaidWindow,nil,nil,.75)
  SkinButton(CTA_JoinRaidWindowOkButton)
  SkinButton(CTA_JoinRaidWindowCloseButton)
  CreateBackdrop(CTA_AcidEditDialog,nil,nil,.75)
  SkinButton(CTA_AcidEditDialogOkButton)
  SkinButton(CTA_AcidEditDialogCloseButton)
  CreateBackdrop(CTA_AddPlayerFrame,nil,nil,.75)
  SkinButton(CTA_AddPlayerFrameOkButton)
  SkinButton(CTA_AddPlayerFrameCloseButton)

  SkinCheckbox(CTA_LFGCheckButton)
  SkinCheckbox(CTA_MuteLFGChannelCheckButton)
  SkinCheckbox(CTA_ShowFilteredMessagesInChatCheckButton)
  SkinCheckbox(CTA_ShowOnMinimapCheckButton)
  SkinCheckbox(CTA_PlaySoundOnNewResultCheckButton)
  SkinCheckbox(CTA_MyRaidFramePVPCheckButton)
  SkinCheckbox(CTA_MyRaidFramePVECheckButton)

  SkinSlider(CTA_MinimapArcSlider)
  SkinSlider(CTA_MinimapRadiusSlider)
  SkinSlider(CTA_MinimapMsgArcSlider)
  SkinSlider(CTA_MinimapMsgRadiusSlider)
  SkinSlider(CTA_FrameTransparencySlider)
  SkinSlider(CTA_FilterLevelSlider)

  SkinArrowButton(CTA_SearchFrame_ResultsPrev, "left", 22)
  CTA_SearchFrame_ResultsPrev:SetPoint("BOTTOM", -64, 5)
  SkinArrowButton(CTA_SearchFrame_ResultsNext, "right", 22)
  CTA_SearchFrame_ResultsNext:SetPoint("BOTTOM", 64, 5)
  SkinArrowButton(CTA_GreyListFramePrev, "left", 22)
  CTA_GreyListFramePrev:SetPoint("BOTTOM", -64, 5)
  SkinArrowButton(CTA_GreyListFrameNext, "right", 22)
  CTA_GreyListFrameNext:SetPoint("BOTTOM", 64,5)
  SkinArrowButton(CTA_LogUpButton, "up", 22)
  SkinArrowButton(CTA_LogDownButton, "down", 22)
  SkinArrowButtonWrapper(CTA_LogBottomButton, "bottom", 22)

  local SkinAcidItem = function(f, s)
    StripTextures(f)
    CreateBackdrop(f)
    if s then
      SetAllPointsOffset(f.backdrop, f, s)
    end
  end
  for i=1,8 do
    local btn = getglobal(string.format("CTA_AcidClassCheckButton%d",i))
    SkinCheckbox(btn)
    btn = getglobal(string.format("CTA_Acid%dDeleteButton",i))
    SkinButton(btn)
    btn = getglobal(string.format("CTA_Acid%dMoreButton",i))
    SkinArrowButton(btn, "up", 14)
    btn:SetPoint("TOPLEFT", 43, 1)
    btn = getglobal(string.format("CTA_Acid%dLessButton",i))
    SkinArrowButton(btn, "down", 14)
    btn:SetPoint("TOPLEFT", 43, -37)
    SkinAcidItem(getglobal(string.format("CTA_Acid%dbarBorder",i)),2)
  end
  SkinAcidItem(CTA_Acid0barBorder, 2)

  StripTextures(CTA_MainFrame)
  CreateBackdrop(CTA_MainFrame, nil, nil, .75)
  SkinCloseButton(CTA_MainFrameCloseButton, CTA_MainFrame.backdrop, -6, -6)
  CTA_MainFrame:SetHeight(500)
  SkinTab(CTA_ShowResultsButton)
  CTA_ShowResultsButton:SetPoint("TOPLEFT", 21, -20)
  SkinTab(CTA_ShowOptionsButton)
  SkinTab(CTA_ShowBlacklistButton)
  CTA_ShowBlacklistButton:SetPoint("TOPLEFT", 21, -36)
  SkinTab(CTA_SettingsFrameButton)
  SkinTab(CTA_LogFrameButton)

  SkinTab(CTA_ShowSearchButton)
  CTA_ShowSearchButton:SetPoint("TOPLEFT", CTA_MainFrame.backdrop, "BOTTOMLEFT", 16, -3)
  SkinTab(CTA_ShowMyRaidButton)
  CTA_ShowMyRaidButton:SetPoint("TOPLEFT", CTA_ShowSearchButton, "TOPRIGHT", 2, 0)
  SkinTab(CTA_ShowLFGButton)
  CTA_ShowLFGButton:SetPoint("TOPLEFT", CTA_ShowMyRaidButton, "TOPRIGHT", 2, 0)
  SkinTab(CTA_ShowMFFButton)
  CTA_ShowMFFButton:SetPoint("TOPRIGHT", CTA_MainFrame.backdrop, "BOTTOMRIGHT", -16, -3)
  CTA_ShowSearchButton.SetFrameLevel = noop
  CTA_ShowMyRaidButton.SetFrameLevel = noop
  CTA_ShowLFGButton.SetFrameLevel = noop
  CTA_ShowMFFButton.SetFrameLevel = noop

  pfUI.addonskinner:UnregisterSkin("CallToArms")
end)