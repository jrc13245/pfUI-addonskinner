pfUI.addonskinner:RegisterSkin("ZHunterMod",function()
  -- check the api is present for any methods needed and apply the skin
  local buttons_done, bars_done, children_done
  local buttons = {ZHunterAIStripDisplay, ZHunterButtonAspect, ZHunterButtonPet, ZHunterButtonTrack, ZHunterButtonTrap}  
  local childbuttons = {"ZHunterButtonAspect", "ZHunterButtonPet", "ZHunterButtonTrack", "ZHunterButtonTrap"}
  if pfUI.api and pfUI.api.CreateBackdrop then
    for _, button in ipairs(buttons) do
      if button then
        buttons_done = true
        pfUI.api.CreateBackdrop(button)
      end
    end
    for _, child in ipairs(childbuttons) do
      for i=1,11 do
        local button = getglobal(child..i)
        if button then
          children_done = true
          pfUI.api.CreateBackdrop(button)
        end
      end
    end
    pfUI.api.CreateBackdrop(ZHunterCastBar)
    for i=0,10 do
      local tranq = getglobal("ZHunterTranq"..i)
      if tranq then
        bars_done = true
        pfUI.api.CreateBackdrop(tranq)
      end
    end
  end
  if buttons_done and bars_done and children_done then
    -- remove from list of pending skins after applying
    pfUI.addonskinner:UnregisterSkin("ZHunterMod")
  end
end)