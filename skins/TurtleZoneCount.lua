pfUI.addonskinner:RegisterSkin("TurtleZoneCount", function()
  local penv = pfUI:GetEnvironment()
  local CreateBackdrop, CreateBackdropShadow = penv.CreateBackdrop, penv.CreateBackdropShadow

  local tooltip_alpha = pfUI_config.tooltip.alpha
  CreateBackdrop(TZC,nil,nil,tonumber(pfUI_config.tooltip.alpha))
  CreateBackdropShadow(TZC)
  pfUI.addonskinner:UnregisterSkin("TurtleZoneCount")
end)