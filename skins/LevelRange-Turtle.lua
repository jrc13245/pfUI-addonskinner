pfUI.addonskinner:RegisterSkin("LevelRange-Turtle", function()
  if pfUI.api and pfUI.api.CreateBackdrop and pfUI_config and pfUI_config.tooltip and pfUI_config.tooltip.alpha then
    pfUI.api.CreateBackdrop(LevelRangeTooltip, nil, nil, tonumber(pfUI_config.tooltip.alpha))
  end
  pfUI.addonskinner:UnregisterSkin("LevelRange-Turtle")
end)
