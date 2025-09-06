pfUI.addonskinner:RegisterSkin("AutoProfit", function()
	
  if pfUI and pfUI.api and pfUI.api.SkinButton then
    pfUI.api.SkinButton(AutosellButton)
  end

  pfUI.addonskinner:UnregisterSkin("AutoProfit")
end)

