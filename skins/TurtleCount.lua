pfUI.addonskinner:RegisterSkin("TurtleCount", function()
  local penv = pfUI:GetEnvironment()
  local CreateBackdrop, CreateBackdropShadow = penv.CreateBackdrop, penv.CreateBackdropShadow

  local tooltip_alpha = pfUI_config.tooltip.alpha
  CreateBackdrop(TurtleCount,nil,nil,tonumber(pfUI_config.tooltip.alpha))
  CreateBackdropShadow(TurtleCount)
  TurtleCount:SetWidth(55)
  TurtleCount:SetHeight(16)
  TurtleCount.icon:SetPoint("LEFT", TurtleCount, "LEFT", 1, 0)
  TurtleCount.text:SetFont(pfUI.font_default, 12, "OUTLINE")
  pfUI.addonskinner:UnregisterSkin("TurtleCount")
end)