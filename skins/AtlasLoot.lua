
pfUI.addonskinner:RegisterSkin("AtlasLoot", function()
  -- upvalue the pfUI methods we use to avoid repeated lookups
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, SkinCloseButton, SkinButton, SkinArrowButton, 
    SkinCheckbox, SkinCollapseButton, SetAllPointsOffset, SetHighlight, SkinScrollbar, 
    HookScript, hooksecurefunc, SkinDropDown, SkinSlider = 
  penv.StripTextures, penv.CreateBackdrop, penv.SkinCloseButton, penv.SkinButton, penv.SkinArrowButton, 
  penv.SkinCheckbox, penv.SkinCollapseButton, penv.SetAllPointsOffset, penv.SetHighlight, penv.SkinScrollbar, 
  penv.HookScript, penv.hooksecurefunc, penv.SkinDropDown, penv.SkinSlider

  local noop = function() end

  StripTextures(AtlasLootInfoHidePanel, true, "BACKGROUND")
  SkinButton(AtlasLootInfoHidePanel)
  AtlasLootInfoHidePanel:SetHeight(20)
  StripTextures(AtlasLootInfo_AtlasLoot, true, "BACKGROUND")
  SkinButton(AtlasLootInfo_AtlasLoot)
  AtlasLootInfo_AtlasLoot:SetHeight(20)
  hooksecurefunc("AtlasLoot_SetupForAtlas", function()
    AtlasLootPanel:ClearAllPoints()
    AtlasLootPanel:SetPoint("TOP", "AtlasFrame", "BOTTOM", 0, -3)
  end,true)

  StripTextures(AtlasLootItemsFrame)
  CreateBackdrop(AtlasLootItemsFrame, nil, nil, .9)
  SkinCloseButton(AtlasLootItemsFrame_CloseButton, AtlasLootItemsFrame.backdrop, -6, -6)

  StripTextures(AtlasLootPanel)
  CreateBackdrop(AtlasLootPanel, nil, nil, .75)
  if AtlasFrame then AtlasLootPanel:SetPoint("TOP", "AtlasFrame", "BOTTOM", 0, -3) end

  SkinButton(AtlasLootPanel_WorldEvents)
  SkinButton(AtlasLootPanel_Sets)
  SkinButton(AtlasLootPanel_Reputation)
  SkinButton(AtlasLootPanel_PvP)
  SkinButton(AtlasLootPanel_Crafting)
  SkinButton(AtlasLootPanel_WishList)
  SkinButton(AtlasLootPanel_Options)
  SkinButton(AtlasLootPanel_AtlasLoot)
  SkinButton(AtlasLootPanel_Preset1)
  SkinButton(AtlasLootPanel_Preset2)
  SkinButton(AtlasLootPanel_Preset3)
  SkinButton(AtlasLootPanel_Preset4)
  StripTextures(AtlasLootSearchBox, true, "BACKGROUND")
  CreateBackdrop(AtlasLootSearchBox, nil, true)
  AtlasLootSearchBox:SetHeight(20)
  
  StripTextures(AtlasLootSearchButton)
  AtlasLootSearchButtonLeft:SetTexture("")
  AtlasLootSearchButtonLeft.SetTexture = noop
  AtlasLootSearchButtonMiddle:SetTexture("")
  AtlasLootSearchButtonMiddle.SetTexture = noop
  AtlasLootSearchButtonRight:SetTexture("")
  AtlasLootSearchButtonRight.SetTexture = noop  
  SkinButton(AtlasLootSearchButton)
  AtlasLootSearchButton:SetHeight(20)
  SkinArrowButton(AtlasLootSearchOptionsButton, "right", 16)
  
  StripTextures(AtlasLootSearchClearButton)
  AtlasLootSearchClearButtonLeft:SetTexture("")
  AtlasLootSearchClearButtonLeft.SetTexture = noop
  AtlasLootSearchClearButtonMiddle:SetTexture("")
  AtlasLootSearchClearButtonMiddle.SetTexture = noop
  AtlasLootSearchClearButtonRight:SetTexture("")
  AtlasLootSearchClearButtonRight.SetTexture = noop
  SkinButton(AtlasLootSearchClearButton)
  AtlasLootSearchClearButton:SetHeight(20)

  SkinButton(AtlasLootLastResultButton)
  SkinArrowButton(AtlasLootQuickLooksButton, "right", 20)

  SkinButton(AtlasLootServerQueryButton)
  SkinButton(AtlasLootItemsFrame_BACK)
  SkinArrowButton(AtlasLootItemsFrame_PREV, "left", 20)
  SkinArrowButton(AtlasLootItemsFrame_NEXT, "right", 20)

-->>--	 Options Frame
  StripTextures(AtlasLootOptionsFrame)
  CreateBackdrop(AtlasLootOptionsFrame, nil, nil, .75)

  SkinCheckbox(AtlasLootOptionsFrameSafeLinks,20)
  SkinCheckbox(AtlasLootOptionsFrameMinimap,20)
  SkinCheckbox(AtlasLootOptionsFrameAllLinks,20)
  SkinCheckbox(AtlasLootOptionsFrameHidePanel,20)
  SkinCheckbox(AtlasLootOptionsFrameOpaque,20)
  SkinCheckbox(AtlasLootOptionsFrameDefaultTT,20)
  SkinCheckbox(AtlasLootOptionsFrameLootlinkTT,20)
  SkinCheckbox(AtlasLootOptionsFrameItemSyncTT,20)
  SkinCheckbox(AtlasLootOptionsFrameShowSource,20)
  SkinCheckbox(AtlasLootOptionsFrameItemSpam,20)
  SkinCheckbox(AtlasLootOptionsFrameEquipCompare,20)
  SkinCheckbox(AtlasLootOptionsFrameItemID,20)
  SkinSlider(AtlasLootOptionsFrameSliderButtonPos)
  SkinSlider(AtlasLootOptionsFrameSliderButtonRad)

  StripTextures(AtlasLootOptionsFrameDefaultSettings)
  AtlasLootOptionsFrameDefaultSettingsLeft:SetTexture("")
  AtlasLootOptionsFrameDefaultSettingsLeft.SetTexture = noop
  AtlasLootOptionsFrameDefaultSettingsMiddle:SetTexture("")
  AtlasLootOptionsFrameDefaultSettingsMiddle.SetTexture = noop
  AtlasLootOptionsFrameDefaultSettingsRight:SetTexture("")
  AtlasLootOptionsFrameDefaultSettingsRight.SetTexture = noop  
  SkinButton(AtlasLootOptionsFrameDefaultSettings)
  
  StripTextures(AtlasLootOptionsFrameDone)
  AtlasLootOptionsFrameDoneLeft:SetTexture("")
  AtlasLootOptionsFrameDoneLeft.SetTexture = noop
  AtlasLootOptionsFrameDoneMiddle:SetTexture("")
  AtlasLootOptionsFrameDoneMiddle.SetTexture = noop
  AtlasLootOptionsFrameDoneRight:SetTexture("")
  AtlasLootOptionsFrameDoneRight.SetTexture = noop  
  SkinButton(AtlasLootOptionsFrameDone)

  StripTextures(AtlasLootOptionsFrameResetPosition)
  AtlasLootOptionsFrameResetPositionLeft:SetTexture("")
  AtlasLootOptionsFrameResetPositionLeft.SetTexture = noop
  AtlasLootOptionsFrameResetPositionMiddle:SetTexture("")
  AtlasLootOptionsFrameResetPositionMiddle.SetTexture = noop
  AtlasLootOptionsFrameResetPositionRight:SetTexture("")
  AtlasLootOptionsFrameResetPositionRight.SetTexture = noop  
  SkinButton(AtlasLootOptionsFrameResetPosition)

-->>-- Atlasloot default frame
  StripTextures(AtlasLootDefaultFrame)
  CreateBackdrop(AtlasLootDefaultFrame, nil, nil, .75)
  SkinCloseButton(AtlasLootDefaultFrame_CloseButton, AtlasLootDefaultFrame.backdrop, -6, -6)
  SkinButton(AtlasLootDefaultFrame_Atlas)
  SkinButton(AtlasLootDefaultFrame_Options)
  SkinButton(AtlasLootDefaultFrame_Menu)
  SkinButton(AtlasLootDefaultFrame_SubMenu)
  SkinButton(AtlasLootDefaultFrame_Preset1)
  SkinButton(AtlasLootDefaultFrame_Preset2)
  SkinButton(AtlasLootDefaultFrame_Preset3)
  SkinButton(AtlasLootDefaultFrame_Preset4)

  StripTextures(AtlasLootDefaultFrameWishListButton)
  AtlasLootDefaultFrameWishListButtonLeft:SetTexture("")
  AtlasLootDefaultFrameWishListButtonLeft.SetTexture = noop
  AtlasLootDefaultFrameWishListButtonMiddle:SetTexture("")
  AtlasLootDefaultFrameWishListButtonMiddle.SetTexture = noop
  AtlasLootDefaultFrameWishListButtonRight:SetTexture("")
  AtlasLootDefaultFrameWishListButtonRight.SetTexture = noop
  SkinButton(AtlasLootDefaultFrameWishListButton)
  AtlasLootDefaultFrameWishListButton:SetHeight(20)

  StripTextures(AtlasLootDefaultFrameSearchBox, true, "BACKGROUND")
  CreateBackdrop(AtlasLootDefaultFrameSearchBox, nil, true)
  AtlasLootDefaultFrameSearchBox:SetHeight(20)

  SkinArrowButton(AtlasLootDefaultFrameSearchOptionsButton, "right", 20)
  
  StripTextures(AtlasLootDefaultFrameSearchButton)
  AtlasLootDefaultFrameSearchButtonLeft:SetTexture("")
  AtlasLootDefaultFrameSearchButtonLeft.SetTexture = noop
  AtlasLootDefaultFrameSearchButtonMiddle:SetTexture("")
  AtlasLootDefaultFrameSearchButtonMiddle.SetTexture = noop
  AtlasLootDefaultFrameSearchButtonRight:SetTexture("")
  AtlasLootDefaultFrameSearchButtonRight.SetTexture = noop  
  SkinButton(AtlasLootDefaultFrameSearchButton)
  AtlasLootDefaultFrameSearchButton:SetHeight(20)

  StripTextures(AtlasLootDefaultFrameSearchClearButton)
  AtlasLootDefaultFrameSearchClearButtonLeft:SetTexture("")
  AtlasLootDefaultFrameSearchClearButtonLeft.SetTexture = noop
  AtlasLootDefaultFrameSearchClearButtonMiddle:SetTexture("")
  AtlasLootDefaultFrameSearchClearButtonMiddle.SetTexture = noop
  AtlasLootDefaultFrameSearchClearButtonRight:SetTexture("")
  AtlasLootDefaultFrameSearchClearButtonRight.SetTexture = noop
  SkinButton(AtlasLootDefaultFrameSearchClearButton)
  AtlasLootDefaultFrameSearchClearButton:SetHeight(20)

  StripTextures(AtlasLootDefaultFrameLastResultButton)
  AtlasLootDefaultFrameLastResultButtonLeft:SetTexture("")
  AtlasLootDefaultFrameLastResultButtonLeft.SetTexture = noop
  AtlasLootDefaultFrameLastResultButtonMiddle:SetTexture("")
  AtlasLootDefaultFrameLastResultButtonMiddle.SetTexture = noop
  AtlasLootDefaultFrameLastResultButtonRight:SetTexture("")
  AtlasLootDefaultFrameLastResultButtonRight.SetTexture = noop
  SkinButton(AtlasLootDefaultFrameLastResultButton)
  AtlasLootDefaultFrameLastResultButton:SetHeight(20)

  pfUI.addonskinner:UnregisterSkin("AtlasLoot")
end)
