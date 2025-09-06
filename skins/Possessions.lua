pfUI.addonskinner:RegisterSkin("Possessions", function() 

  -- upvalue the pfUI methods we use to avoid repeated lookups
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, SkinCloseButton, SkinButton, SkinArrowButton, 
    SkinCheckbox, SkinDropDown, SkinScrollbar = 
    penv.StripTextures, penv.CreateBackdrop, penv.SkinCloseButton, penv.SkinButton, penv.SkinArrowButton, 
  penv.SkinCheckbox, penv.SkinDropDown, penv.SkinScrollbar

  StripTextures(Possessions_Frame)
  CreateBackdrop(Possessions_Frame, nil, nil, .75)
  SkinCloseButton(Possessions_FrameCloseButton, Possessions_Frame.backdrop, -6, -6)

  SkinDropDown(Possessions_CharDropDown)
  SkinDropDown(Possessions_LocDropDown)
  SkinDropDown(Possessions_SlotDropDown)
  StripTextures(Possessions_IC_ScrollFrame)
  SkinScrollbar(Possessions_IC_ScrollFrameScrollBar)
	
  StripTextures(Possessions_SearchBox, true, "BACKGROUND")
  CreateBackdrop(Possessions_SearchBox, nil, true)
  Possessions_SearchBox:SetWidth(120)
  Possessions_SearchBox:ClearAllPoints()
  Possessions_SearchBox:SetPoint("TOPRIGHT", Possessions_Frame.backdrop, "TOPRIGHT", -52, -64)
  SkinCheckbox(POSSESSIONS_CHK_SortName)
  SkinCheckbox(POSSESSIONS_CHK_SortRarity)

  pfUI.addonskinner:UnregisterSkin("Possessions")
end)