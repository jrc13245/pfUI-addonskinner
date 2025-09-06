pfUI.addonskinner:RegisterSkin("YaHT",function()
  -- check the api is present for any methods needed and apply the skin
  if pfUI.api and pfUI.api.CreateBackdrop then
    if (YaHTFrame) then
      pfUI.api.CreateBackdrop(YaHTFrame)
      YaHT:OnProfileEnable()
      -- remove from list of pending skins after applying
      pfUI.addonskinner:UnregisterSkin("YaHT")
    end
  end
end)