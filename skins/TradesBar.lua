pfUI.addonskinner:RegisterSkin("TradesBar",function()
  -- check the api is present for any methods needed and apply the skin
  local buttons_done
  if pfUI.api and pfUI.api.CreateBackdrop then
    for i=1,26 do
      local button = getglobal("TradesBarButton"..i)
      if button then
        pfUI.addonskinner.api.SkinActionButton(button)
        buttons_done = true
      end
    end

    pfUI.api.StripTextures(TradesBarConfig)
    pfUI.api.CreateBackdrop(TradesBarConfig,nil,nil,.75)
    for i = 1, 5 do
      local panel = getglobal(string.format("TradesBarConfigPanel%d",i))
      if panel then
        pfUI.api.CreateBackdrop(panel)
      end
    end
    pfUI.api.SkinButton(TradesBarConfigButtonClose)

    pfUI.api.SkinCheckbox(TradesBarConfigPanel1CheckButton1,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel1CheckButton2,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel1CheckButton3,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel4CheckButton4,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel4CheckButton5,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel4CheckButton6,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel4CheckButton7,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel4CheckButton8,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel4CheckButton9,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel4CheckButton11,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel4CheckButton12,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel4CheckButton13,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel4CheckButton14,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel4CheckButton15,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel4CheckButton16,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel5CheckButton10,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel5CheckButton17,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel5CheckButton18,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel5CheckButton19,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel5CheckButton20,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel5CheckButton21,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel5CheckButton22,25)
    pfUI.api.SkinCheckbox(TradesBarConfigPanel5CheckButton23,25)

    TradesBarConfig:SetScale(.8)

    if buttons_done then
      pfUI.addonskinner:UnregisterSkin("TradesBar")
    end
  end
end)
