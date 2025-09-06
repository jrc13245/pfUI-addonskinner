pfUI.addonskinner:RegisterSkin("UnitXP_SP3_Addon", function()
  -- place main code below
  local penv = pfUI:GetEnvironment()
  local HookAddonOrVariable, StripTextures, SkinButton, SkinCheckbox, CreateBackdrop, CreateBackdropShadow =
  penv.HookAddonOrVariable, penv.StripTextures, penv.SkinButton, penv.SkinCheckbox, penv.CreateBackdrop, penv.CreateBackdropShadow
  HookAddonOrVariable("UnitXP_SP3_Addon", function()
    -- skin UnitXP SP3 window and elements

    local frames = {
      xpsp3Frame,
      xpsp3tooltip,
    }
    
    local buttons = {
      xpsp3_button_close,
      xpsp3_button_resetCamera,
      xpsp3_button_cameraHeight_raise,
      xpsp3_button_cameraHeight_lower,
      xpsp3_button_cameraHorizontalDisplacement_leftPlayer,
      xpsp3_button_cameraHorizontalDisplacement_rightPlayer,
      xpsp3_buttonCancel_resetCamera,
      xpsp3_buttonCancel_close,

    }

    local boxes = {
      xpsp3_checkButton_minimapButton,
      xpsp3_checkButton_modernNameplate,
      xpsp3_checkButton_prioritizeTargetNameplate,
      xpsp3_checkButton_prioritizeMarkedNameplate,
      xpsp3_checkButton_notify_flashTaskbarIcon,
      xpsp3_checkButton_notify_playSystemDefaultSound,
      xpsp3_checkButton_nameplateCombatFilter,
      xpsp3_checkButton_showInCombatNameplatesNearPlayer,
    }
    
    for _, f in pairs(frames) do
      StripTextures(f)
      CreateBackdrop(f)
      CreateBackdropShadow(f)
    end
    
    for _, button in pairs(buttons) do
      SkinButton(button)
    end

    for _, box in pairs(boxes) do
      SkinCheckbox(box)
    end
  end)

  StripTextures(xpsp3_editBox_FPScap, false, "BACKGROUND")
  xpsp3_editBox_FPScap:SetHeight(20)
  xpsp3_editBox_FPScap:SetPoint("TOPLEFT", xpsp3Frame, 320, -35)
  xpsp3_editBox_FPScap:SetWidth(40)
  CreateBackdrop(xpsp3_editBox_FPScap)


  -- remove from pending list when applied
  pfUI.addonskinner:UnregisterSkin("UnitXP_SP3_Addon")
end)