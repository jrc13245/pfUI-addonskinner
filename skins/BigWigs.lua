pfUI.addonskinner:RegisterSkin("BigWigs", function()
  if pfUI then
    local font = pfUI_config.global.font_combat
    -- local font_size = tonumber(pfUI_config.global.font_size)
    local font_size = 10

      -- TODO: hook functions maybe?
    if BigWigsProximity then
      BigWigsProximity:SetupFrames()
      pfUI.api.CreateBackdrop(getglobal("BigWigsProximityAnchor"), nil, nil, .75)    
    end
    if BigWigsFrostBlast then
      BigWigsFrostBlast:SetupFrames()
      pfUI.api.CreateBackdrop(getglobal("BigWigsFrostBlastAnchor"), nil, nil, .75)  
    end
    if BigWigsIgnite then
      BigWigsIgnite:SetupFrames()
      local ignite_frame = getglobal("BigWigsIgniteFrame")
      pfUI.api.CreateBackdrop(ignite_frame, nil, nil, .75)
      ignite_frame.cheader:SetFont(font, font_size)
      ignite_frame.text:SetJustifyH("LEFT")
      ignite_frame.text:SetFont(font, font_size)
      -- TODO: skin stop button
      -- TODO: skin close button
      -- TODO: proper skining? mhm...
    end

  end
  -- seems impossible to properly skin timer bars, as they're done with ACE:CandyBar
  pfUI.addonskinner:UnregisterSkin("BigWigs")
end)