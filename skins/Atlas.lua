
pfUI.addonskinner:RegisterSkin("Atlas", function()
  -- upvalue the pfUI methods we use to avoid repeated lookups
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, SkinCloseButton, SkinButton, SkinArrowButton, 
    SkinCheckbox, SkinCollapseButton, SetAllPointsOffset, SetHighlight, SkinScrollbar, 
    HookScript, hooksecurefunc, SkinDropDown, SkinSlider = 
  penv.StripTextures, penv.CreateBackdrop, penv.SkinCloseButton, penv.SkinButton, penv.SkinArrowButton, 
  penv.SkinCheckbox, penv.SkinCollapseButton, penv.SetAllPointsOffset, penv.SetHighlight, penv.SkinScrollbar, 
  penv.HookScript, penv.hooksecurefunc, penv.SkinDropDown, penv.SkinSlider

  local noop = function() end

  StripTextures(AtlasFrame)
  CreateBackdrop(AtlasFrame, nil, nil, .75)
-->>--  AtlasFrame
  SkinCloseButton(AtlasFrameCloseButton, AtlasFrame.backdrop, -6, -6)
  SkinButton(AtlasFrameLockButton, nil, nil, nil, nil, true)
  AtlasFrameLockButton:SetWidth(16)
  AtlasFrameLockButton:SetHeight(16)
  AtlasFrameLockButton:SetPoint("RIGHT", AtlasFrameCloseButton, "LEFT", -3, 0)
  Atlas_UpdateLock = function()
    if (AtlasOptions.AtlasLocked) then
      AtlasFrameLockButton:SetNormalTexture("Interface\\AddOns\\Atlas\\Images\\LockButton-Locked-Up")
    else
      AtlasFrameLockButton:SetNormalTexture("Interface\\AddOns\\Atlas\\Images\\LockButton-Unlocked-Up")
    end
    local texture = AtlasFrameLockButton:GetNormalTexture()
    SetDesaturation(texture,true)
    SetAllPointsOffset(texture, AtlasFrameLockButton, -2)
    texture:SetTexCoord(.1, .9, .1, .9)
  end
  Atlas_UpdateLock()

  SkinDropDown(AtlasFrameDropDownType)
  SkinDropDown(AtlasFrameDropDown)
  
  StripTextures(AtlasFrameOptionsButton)
  AtlasFrameOptionsButtonLeft:SetTexture("")
  AtlasFrameOptionsButtonLeft.SetTexture = noop
  AtlasFrameOptionsButtonMiddle:SetTexture("")
  AtlasFrameOptionsButtonMiddle.SetTexture = noop
  AtlasFrameOptionsButtonRight:SetTexture("")
  AtlasFrameOptionsButtonRight.SetTexture = noop
  SkinButton(AtlasFrameOptionsButton)
  
  StripTextures(AtlasSwitchButton)
  AtlasSwitchButtonLeft:SetTexture("")
  AtlasSwitchButtonLeft.SetTexture = noop
  AtlasSwitchButtonMiddle:SetTexture("")
  AtlasSwitchButtonMiddle.SetTexture = noop
  AtlasSwitchButtonRight:SetTexture("")
  AtlasSwitchButtonRight.SetTexture = noop
  SkinButton(AtlasSwitchButton)
  
  StripTextures(AtlasSearchButton)
  AtlasSearchButtonLeft:SetTexture("")
  AtlasSearchButtonLeft.SetTexture = noop
  AtlasSearchButtonMiddle:SetTexture("")
  AtlasSearchButtonMiddle.SetTexture = noop
  AtlasSearchButtonRight:SetTexture("")
  AtlasSearchButtonRight.SetTexture = noop
  SkinButton(AtlasSearchButton)
  AtlasSearchButton:SetHeight(20)
  
  StripTextures(AtlasSearchClearButton)
  AtlasSearchClearButtonLeft:SetTexture("")
  AtlasSearchClearButtonLeft.SetTexture = noop
  AtlasSearchClearButtonMiddle:SetTexture("")
  AtlasSearchClearButtonMiddle.SetTexture = noop
  AtlasSearchClearButtonRight:SetTexture("")
  AtlasSearchClearButtonRight.SetTexture = noop
  SkinButton(AtlasSearchClearButton)
  AtlasSearchClearButton:SetHeight(20)
  
  StripTextures(AtlasSearchEditBox, true, "BACKGROUND")
  CreateBackdrop(AtlasSearchEditBox, nil, true)
  AtlasSearchEditBox:SetHeight(20)
  SkinScrollbar(AtlasScrollBarScrollBar)

  AtlasMap:SetDrawLayer("OVERLAY")

-->>--  AtlasOptionsFrame
  StripTextures(AtlasOptionsFrame)
  CreateBackdrop(AtlasOptionsFrame, nil, nil, .75)
  SkinCheckbox(AtlasOptionsFrameToggleButton, 20)
  SkinCheckbox(AtlasOptionsFrameAutoSelect, 20)
  SkinCheckbox(AtlasOptionsFrameRightClick, 20)
  SkinCheckbox(AtlasOptionsFrameAcronyms, 20)
  SkinCheckbox(AtlasOptionsFrameClamped, 20)
  SkinSlider(AtlasOptionsFrameSliderButtonPos)
  SkinSlider(AtlasOptionsFrameSliderButtonRad)
  SkinSlider(AtlasOptionsFrameSliderAlpha)
  SkinSlider(AtlasOptionsFrameSliderScale)
  SkinDropDown(AtlasOptionsFrameDropDownCats)
  AtlasOptionsFrameDropDownCats:SetPoint("TOPLEFT", AtlasOptionsFrame.backdrop, "TOPLEFT", 10, -475)
  StripTextures(AtlasOptionsFrameDone)
  AtlasOptionsFrameDoneLeft:SetTexture("")
  AtlasOptionsFrameDoneLeft.SetTexture = noop
  AtlasOptionsFrameDoneMiddle:SetTexture("")
  AtlasOptionsFrameDoneMiddle.SetTexture = noop
  AtlasOptionsFrameDoneRight:SetTexture("")
  AtlasOptionsFrameDoneRight.SetTexture = noop
  SkinButton(AtlasOptionsFrameDone)
  AtlasOptionsFrameDone:SetHeight(20)
  AtlasOptionsFrameDone:ClearAllPoints()
  AtlasOptionsFrameDone:SetPoint("LEFT", AtlasOptionsFrameResetPosition, "RIGHT", 5, 0)
  StripTextures(AtlasOptionsFrameResetPosition)
  AtlasOptionsFrameResetPositionLeft:SetTexture("")
  AtlasOptionsFrameResetPositionLeft.SetTexture = noop
  AtlasOptionsFrameResetPositionMiddle:SetTexture("")
  AtlasOptionsFrameResetPositionMiddle.SetTexture = noop
  AtlasOptionsFrameResetPositionRight:SetTexture("")
  AtlasOptionsFrameResetPositionRight.SetTexture = noop
  SkinButton(AtlasOptionsFrameResetPosition)
  AtlasOptionsFrameResetPosition:SetHeight(20)

  pfUI.addonskinner:UnregisterSkin("Atlas")
end)
