pfUI.addonskinner:RegisterSkin("SP_Overpower", function()
  -- check the api is present for any methods needed and apply the skin
  if pfUI and pfUI.api and pfUI.api.CreateBackdrop then
    if SP_OP_Frame then
      pfUI.api.CreateBackdrop(SP_OP_Frame)
      local font_string = getglobal("SP_OP_FrameText")
      if font_string and font_string.SetFont then
        font_string:SetFont(pfUI_config.global.font_combat, 14, "NORMAL")
      end
    end
  end
  pfUI.addonskinner:UnregisterSkin("SP_Overpower")
end)