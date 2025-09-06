pfUI.addonskinner:RegisterSkin("RingMenu", function()
  local penv = pfUI:GetEnvironment()
  local HookAddonOrVariable, hooksecurefunc, StripTextures, CreateBackdrop, SkinCheckbox, SkinSlider, SkinButton = 
  penv.HookAddonOrVariable, penv.hooksecurefunc, penv.StripTextures, penv.CreateBackdrop, penv.SkinCheckbox, penv.SkinSlider, penv.SkinButton

  local SkinRing = function()
    for i = 1, RingMenu_settings.numButtons do
      local btn = getglobal("RingMenuButton" .. i)
      pfUI.addonskinner.api.SkinActionButton(btn)
    end
  end

  local SkinSettings = function()
    StripTextures(RingMenuSettingsFrame)
    CreateBackdrop(RingMenuSettingsFrame, nil, nil, .75)
    SkinCheckbox(RingMenuSettingsFrameWidgetAutoClose, 26)
    SkinSlider(RingMenuSettingsFrameWidgetNumButtons)
    StripTextures(RingMenuSettingsFrameWidgetFirstButtonIndex, nil, "BACKGROUND")
    CreateBackdrop(RingMenuSettingsFrameWidgetFirstButtonIndex)
    RingMenuSettingsFrameWidgetFirstButtonIndex:SetWidth(50)
    RingMenuSettingsFrameWidgetFirstButtonIndex:SetHeight(12)
    SkinSlider(RingMenuSettingsFrameWidgetRadius)
    SkinSlider(RingMenuSettingsFrameWidgetAngle)
    SkinButton(RingMenuSettingsFrameButtonOkay)
    SkinButton(RingMenuSettingsFrameButtonCancel)
    SkinButton(RingMenuSettingsFrameButtonDefault)
  end

  HookAddonOrVariable("RingMenu", function()
    SkinRing()
    SkinSettings()
  end)

  pfUI.addonskinner:UnregisterSkin("RingMenu")

end)