pfUI.addonskinner:RegisterSkin("RABuffs", function()
  pfUI.api.CreateBackdrop(getglobal("RAB_Title"))
  pfUI.api.CreateBackdrop(getglobal("RABFrame"))

  pfUI.addonskinner:UnregisterSkin("RABuffs")
end)