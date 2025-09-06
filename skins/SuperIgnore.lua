pfUI.addonskinner:RegisterSkin("SuperIgnore", function()
  
  local penv = pfUI:GetEnvironment()
  local SkinButton, CreateBackdrop, SkinCheckbox, SkinDropDown, StripTextures, SkinScrollbar, hooksecurefunc, HookScript = 
  penv.SkinButton, penv.CreateBackdrop, penv.SkinCheckbox, penv.SkinDropDown, penv.StripTextures, penv.SkinScrollbar, penv.hooksecurefunc, penv.HookScript

  SkinButton(SI_OpenButton)
  CreateBackdrop(SI_OptionsFrame, nil, nil, .75)
  SI_OptionsFrame.backdrop:SetPoint("TOPLEFT", 4, -4)
  SI_OptionsFrame.backdrop:SetPoint("BOTTOMRIGHT", -4, 0)
  SI_OptionsFrame:SetHitRectInsets(4, 4, 4, 0)
  CreateBackdrop(SI_ModsFrame, nil, nil, .75)
  SI_ModsFrame.backdrop:SetPoint("TOPLEFT", 5, -4)
  SI_ModsFrame.backdrop:SetPoint("BOTTOMRIGHT", -4, 20)
  SI_ModsFrame:SetHitRectInsets(5, 4, 4, 20)
  SkinCheckbox(getglobal("SI_Box_1"),20)
  SkinCheckbox(getglobal("SI_Box_2"),20)
  SkinCheckbox(getglobal("SI_Box_3"),20)
  SkinCheckbox(getglobal("SI_Box_4"),20)
  SkinCheckbox(getglobal("SI_Box_5"),20)
  SkinCheckbox(getglobal("SI_Box_6"),20)
  SkinCheckbox(getglobal("SI_Box_7"),20)
  SkinCheckbox(getglobal("SI_Box_8"),20)
  SkinCheckbox(getglobal("SI_Box_9"),20)
  SkinCheckbox(getglobal("SI_Box_10"),20)
  SkinCheckbox(getglobal("SI_Box_11"),20)
  SkinCheckbox(getglobal("SI_Box_12"),20)  
  SkinCheckbox(getglobal("SI_Box_100"),20)
  SkinCheckbox(getglobal("SI_Box_101"),20)
  SkinCheckbox(getglobal("SI_Box_103"),20)
  SkinDropDown(SI_BanDuration)
  HookScript(SI_ModsFrame, "OnShow", function() 
    for _,child in pairs({SI_ModsFrame:GetChildren()}) do
      if child.IsObjectType and not child.backdrop then
        if child:IsObjectType("CheckButton") then
          SkinCheckbox(child, 20)
        elseif child:IsObjectType("Button") then
          SkinButton(child)
        end
      end
    end
    if SI_CMB and not SI_CMB.backdrop then
      CreateBackdrop(SI_CMB,nil,nil,.75)
      SI_CMB.backdrop:SetPoint("TOPLEFT", 5, -4)
      SI_CMB.backdrop:SetPoint("BOTTOMRIGHT", -4, 2)
      SI_CMB:SetHitRectInsets(5,4,4,2)
      StripTextures(SI_CMB_Scroll)
      SkinScrollbar(SI_CMB_ScrollScrollBar)
    end
  end)

  pfUI.addonskinner:UnregisterSkin("SuperIgnore")
end)

