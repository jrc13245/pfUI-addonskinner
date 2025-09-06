pfUI.addonskinner:RegisterSkin("GearMenu", function()

  local font, font_size_key, font_size_name, font_color_key
  if pfUI_config.bars then
    font = pfUI_config.bars.font or pfUI_config.global.font_default
    font_size_key = tonumber(pfUI_config.bars.bind_size) or tonumber(pfUI_config.global.font_size)
    font_size_name = tonumber(pfUI_config.bars.macro_size) or tonumber(pfUI_config.global.font_size)
    font_color_key = {pfUI.api.strsplit(",", pfUI_config.bars.bind_color or "0, 0, 0, 0")}
  else
      font = pfUI_config.global.font_default
      font_size_key = tonumber(pfUI_config.global.font_size)
      font_size_name = tonumber(pfUI_config.global.font_size)
      font_color_key = {pfUI.api.strsplit(",", "0, 0, 0, 0")}
  end

  for i=0,30 do
    local frames = {}
    table.insert(frames, getglobal("GM_Slot" .. i))
    table.insert(frames, getglobal("GM_MenuItem" .. i))
    for k, f in pairs(frames) do
      pfUI.addonskinner.api.SkinActionButton(f)
      local keybind = getglobal(f:GetName() .. "HotKey")
      if keybind then
        keybind:SetFont(font, font_size_key, "OUTLINE")
        keybind:SetTextColor(unpack(font_color_key))
      end
      local name = getglobal(f:GetName() .. "Name")
      if name then
        name:SetFont(font, font_size_name, "OUTLINE")
      end
    end
    frames = nil
  end

  pfUI.addonskinner:UnregisterSkin("GearMenu")
end)