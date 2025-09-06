pfUI.addonskinner:RegisterSkin("SP_SwingTimer", function()
  -- check the api is present for any methods needed and apply the skin
  if pfUI and pfUI.api and pfUI.api.CreateBackdrop then
    if SP_ST_Frame then
      pfUI.api.CreateBackdrop(SP_ST_Frame)
      pfUI.api.CreateBackdrop(SP_ST_FrameOFF)
      pfUI.api.CreateBackdrop(SP_ST_FrameRange)
      local font_string = getglobal("SP_ST_FrameText")
      if font_string and font_string.SetFont then
        font_string:SetFont(pfUI_config.global.font_combat, 14, "NORMAL")
      end
    end
  end

  pfUI.addonskinner:UnregisterSkin("SP_SwingTimer")
end)
