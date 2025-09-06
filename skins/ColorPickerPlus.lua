pfUI.addonskinner:RegisterSkin("ColorPickerPlus", function()

  local penv = pfUI:GetEnvironment()
  local SkinButton, StripTextures, CreateBackdrop = 
  penv.SkinButton, penv.StripTextures, penv.CreateBackdrop
  
  local Skin = function()
    SkinButton(ColorPPCopy)
    SkinButton(ColorPPPaste)
    
    StripTextures(ColorPPBoxR, true, "BACKGROUND")
    CreateBackdrop(ColorPPBoxR, nil, true)
    ColorPPBoxR:SetHeight(18)

    StripTextures(ColorPPBoxG, true, "BACKGROUND")
    CreateBackdrop(ColorPPBoxG, nil, true)
    ColorPPBoxG:SetHeight(18)

    StripTextures(ColorPPBoxB, true, "BACKGROUND")
    CreateBackdrop(ColorPPBoxB, nil, true)
    ColorPPBoxB:SetHeight(18)

    StripTextures(ColorPPBoxH, true, "BACKGROUND")
    CreateBackdrop(ColorPPBoxH, nil, true)
    ColorPPBoxH:SetHeight(18)

    StripTextures(ColorPPBoxA, true, "BACKGROUND")
    CreateBackdrop(ColorPPBoxA, nil, true)
    ColorPPBoxA:SetHeight(18)    
  end

  if not ColorPPCopy then
    local orig_ColorPickerPlus_PEW = ColorPickerPlus.PLAYER_ENTERING_WORLD
    ColorPickerPlus.PLAYER_ENTERING_WORLD = function(self, event) 
      orig_ColorPickerPlus_PEW(self, event)
      Skin()
    end
  else
    Skin()
  end 

  pfUI.addonskinner:UnregisterSkin("ColorPickerPlus")
end)