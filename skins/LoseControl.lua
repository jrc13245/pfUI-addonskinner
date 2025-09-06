pfUI.addonskinner:RegisterSkin("LoseControl", function()
  -- check the api is present for any methods needed and apply the skin
  if pfUI.api and pfUI.api.CreateBackdrop then
    if (LoseControlPlayer) then
      pfUI.api.CreateBackdrop(LoseControlPlayer)  
    end
  end
  pfUI.addonskinner:UnregisterSkin("LoseControl")
end)