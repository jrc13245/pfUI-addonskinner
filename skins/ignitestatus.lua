pfUI.addonskinner:RegisterSkin("ignitestatus", function()
  -- main window
  local status_frame = getglobal("IGNITESTATUSFrame")
  local ignite_frame = getglobal("igniteFrame")
  local hide_button = getglobal("IgniteHideButton")

  local scale_value = 1
  local rel_frame = UIParent
  if pfUI.debuffmonitor and pfUI.debuffmonitor.target then
    scale_value = pfUI.debuffmonitor.target:GetWidth() / getglobal("IGNITESTATUSFrame"):GetWidth()
    rel_frame = pfUI.debuffmonitor.target
  elseif pfUI.chat.right then
    scale_value = pfUI.chat.right:GetWidth() / getglobal("IGNITESTATUSFrame"):GetWidth()
    rel_frame = pfUI.chat.right
  end

  -- if scale_value ~= 1 then
  --   status_frame:SetScale(scale_value)
  --   ISOptions.ISScale = scale_value
  -- end

  status_frame:SetBackdrop(nil)
  ignite_frame:SetBackdrop(nil)
  hide_button:Hide()

  if status_frame:GetWidth() > 220 then
    status_frame:SetWidth(220)
  end
  if status_frame:GetHeight() > 84 then
    status_frame:SetHeight(84)
  end

  status_frame:ClearAllPoints()
  status_frame:SetPoint("BOTTOMLEFT", rel_frame, "TOPLEFT", 0, 5)

  -- fonts
  getglobal("igniteFrame_Title"):SetFont(pfUI.font_default, pfUI_config.global.font_size)
  getglobal("igniteFrame_IGNITESTATUS_vDmg"):SetFont(pfUI.font_default, pfUI_config.global.font_size)
  getglobal("igniteFrame_IGNITESTATUS_vTotDmg"):SetFont(pfUI.font_default, pfUI_config.global.font_size)
  getglobal("igniteFrame_IGNITESTATUS_vTick"):SetFont(pfUI.font_default, pfUI_config.global.font_size)
  getglobal("igniteFrame_IGNITESTATUS_vOwner"):SetFont(pfUI.font_default, pfUI_config.global.font_size)
  getglobal("igniteFrame_IGNITESTATUS_Last"):SetFont(pfUI.font_default, pfUI_config.global.font_size)
  getglobal("igniteFrame_IGNITESTATUS_vScorch"):SetFont(pfUI.font_default, pfUI_config.global.font_size)
  getglobal("igniteFrame_IGNITESTATUS_vTarget"):SetFont(pfUI.font_default, pfUI_config.global.font_size)
  getglobal("igniteFrame_IGNITESTATUS_vTimeLeft"):SetFont(pfUI.font_default, pfUI_config.global.font_size)

  pfUI.addonskinner:UnregisterSkin("ignitestatus")
end)