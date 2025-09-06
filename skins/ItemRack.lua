pfUI.addonskinner:RegisterSkin("ItemRack", function()

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
    table.insert(frames, getglobal("ItemRackInv" .. i))
    table.insert(frames, getglobal("ItemRackMenu" .. i))
    table.insert(frames, getglobal("ItemRack_Sets_Inv" .. i))
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

  -- skin inventory bar backdrop
  local inv_frame = getglobal("ItemRack_InvFrame")
  pfUI.api.CreateBackdrop(inv_frame)
  inv_frame.backdrop:SetPoint("TOPLEFT", inv_frame, "TOPLEFT", 2, -2)
  inv_frame.backdrop:SetPoint("BOTTOMRIGHT", inv_frame, "BOTTOMRIGHT", -2, 2)
  inv_frame.backdrop:Hide()

  local resize_frame = getglobal("ItemRack_InvFrame_Resize")
  resize_frame:SetScript("OnShow", function()
    inv_frame.backdrop:Show()
  end)
  resize_frame:SetScript("OnHide", function()
    inv_frame.backdrop:Hide()
  end)

  pfUI.addonskinner:UnregisterSkin("ItemRack")
end)