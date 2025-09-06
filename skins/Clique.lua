pfUI.addonskinner:RegisterSkin("Clique", function()
  local penv = pfUI:GetEnvironment()
  local HookScript, StripTextures, CreateBackdrop, SkinButton, SkinDropDown, SkinScrollbar = 
  penv.HookScript, penv.StripTextures, penv.CreateBackdrop, penv.SkinButton, penv.SkinDropDown, penv.SkinScrollbar
  -- place main code below
  do
    StripTextures(CliquePulloutTab, false, "BACKGROUND")
    SkinButton(CliquePulloutTab)
    CreateBackdrop(CliquePulloutTab, penv.GetBorderSize()+1)
    CliquePulloutTab:SetPushedTexture("Interface\\AddOns\\Clique\\Images\\CliqueIcon")
    CliquePulloutTab:SetNormalTexture("Interface\\AddOns\\Clique\\Images\\CliqueIcon")

    StripTextures(CliqueFrame)
    CreateBackdrop(CliqueFrame)
    SkinDropDown(CliqueDropDown)
    CliqueDropDown:SetPoint("TOPRIGHT", CliqueFrame, "TOPRIGHT", 0, 0)
    
    SkinScrollbar(CliqueListScrollScrollBar)
    SkinScrollbar(CliqueIconScrollFrameScrollBar)

    for i = 1, 6 do
      getglobal("CliqueList"..i.."Binding"):SetTextColor(.9,.95,1,1)
      getglobal("CliqueList"..i.."Rank"):SetTextColor(.9,.95,1,1)
    end

    SkinButton(CliqueButtonDelete)
    SkinButton(CliqueButtonMax)
    SkinButton(CliqueButtonNew)
    SkinButton(CliqueButtonEdit)
    SkinButton(CliqueButtonOk)
    SkinButton(CliqueButtonHelp)

    StripTextures(CliqueNameEditBox, false, "BACKGROUND")
    CreateBackdrop(CliqueNameEditBox)
    StripTextures(CliqueTextEditBox, false, "BACKGROUND")
    CreateBackdrop(CliqueTextEditBox)
    StripTextures(CliqueEditBinding, true, "BACKGROUND")
    CreateBackdrop(CliqueEditBinding)
    SkinButton(CliqueButtonSave)
    SkinButton(CliqueButtonCancel)


    StripTextures(CliqueTutorial)
    CreateBackdrop(CliqueTutorial)
  end


  HookScript(CliqueFrame, "OnUpdate", function()
    -- UnitXP("debug", "breakpoint");
  end)
  -- remove from pending list when applied
  pfUI.addonskinner:UnregisterSkin("Clique")
end)

