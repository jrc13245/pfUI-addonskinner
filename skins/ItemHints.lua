pfUI.addonskinner:RegisterSkin("ItemHints", function()
  -- check the api is present for any methods needed and apply the skin
  if pfUI.api and pfUI.api.CreateBackdrop and pfUI_config and pfUI_config.tooltip and pfUI_config.tooltip.alpha then
    if ItemHints and ItemHints.extratip then
      pfUI.api.CreateBackdrop(ItemHints.extratip,nil,nil,tonumber(pfUI_config.tooltip.alpha))
    end
  end

  pfUI.addonskinner:UnregisterSkin("ItemHints")
end)