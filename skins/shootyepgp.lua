pfUI.addonskinner:RegisterSkin("shootyepgp", function()
  if pfUI.api and pfUI.api.CreateBackdrop and pfUI_config and pfUI_config.tooltip and pfUI_config.tooltip.alpha then
    if sepgp and sepgp.extratip then
      pfUI.api.CreateBackdrop(sepgp.extratip,nil,nil,tonumber(pfUI_config.tooltip.alpha))
    end
  end
  
  pfUI.addonskinner:UnregisterSkin("shootyepgp")
end)