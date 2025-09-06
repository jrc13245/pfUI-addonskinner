pfUI.addonskinner:RegisterSkin("CloseUp",function() 
  if pfUI and pfUI.api and pfUI.api.SkinButton then
    pfUI.api.SkinButton(CloseUpUndressButton)
  end
  pfUI.addonskinner:UnregisterSkin("CloseUp")
end)