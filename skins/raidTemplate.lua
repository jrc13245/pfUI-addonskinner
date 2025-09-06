pfUI.addonskinner:RegisterSkin("raidTemplate", function()

  -- upvalue the pfUI methods we use to avoid repeated lookups
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, SkinCloseButton, SkinButton, SkinArrowButton, 
    SkinCheckbox, SkinDropDown = 
    penv.StripTextures, penv.CreateBackdrop, penv.SkinCloseButton, penv.SkinButton, penv.SkinArrowButton, 
  penv.SkinCheckbox, penv.SkinDropDown

  StripTextures(xivenRaidWindow)
  CreateBackdrop(xivenRaidWindow, nil, nil, .75)
  SkinCloseButton(xivenRaidWindowCloseButton, xivenRaidWindow.backdrop, -6, -6)

  SkinButton(xivenRaidWindowNewButton)
  SkinButton(xivenRaidWindowRenameButton)
  SkinButton(xivenRaidWindowDeleteButton)
  SkinButton(xivenRaidWindowSwapButton)
  SkinButton(xivenRaidWindowGrabButton)
  
  SkinArrowButton(xivenRaidWindowNameUp, "up", 18)
  SkinArrowButton(xivenRaidWindowNameDown, "down", 18)

  SkinButton(xivenRaidWindowPriorityButton)
  SkinButton(xivenRaidWindowApplyButton)

  SkinCheckbox(xivenRaidWindow_raidmethod1)
  SkinCheckbox(xivenRaidWindow_raidmethod2)

  SkinArrowButton(xivenRaidWindowClassPriorityUp, "up", 18)
  SkinArrowButton(xivenRaidWindowClassPriorityDown, "down", 18)

  SkinButton(xivenRaidWindow_classPriorityIncrease)
  xivenRaidWindow_classPriorityIncrease:ClearAllPoints()
  xivenRaidWindow_classPriorityIncrease:SetPoint("TOPLEFT", xivenRaidWindowClassPriorityDown, "BOTTOMLEFT", 0, -5)
  SkinButton(xivenRaidWindow_classPriorityDecrease)
  SkinButton(xivenRaidWindow_classPriorityDelete)
  SkinButton(xivenRaidWindowPriorityButton)
  SkinButton(xivenRaidWindowApplyButton)
  SkinButton(xivenRaidWindow_classPriorityCapture)

  SkinDropDown(RIGroupOrderDropDown)
  if RIGroupOrderDropDown:GetWidth() < 100 then
    UIDropDownMenu_SetWidth(100, RIGroupOrderDropDown)
  end

  pfUI.addonskinner:UnregisterSkin("raidTemplate")
end)
