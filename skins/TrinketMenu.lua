pfUI.addonskinner:RegisterSkin("TrinketMenu", function()

  local font, font_size_key, font_color_key
  if pfUI_config.bars then
    font = pfUI_config.bars.font or pfUI_config.global.font_default
    font_size_key = tonumber(pfUI_config.bars.bind_size) or tonumber(pfUI_config.global.font_size)
    font_color_key = {pfUI.api.strsplit(",", pfUI_config.bars.bind_color or "0, 0, 0, 0")}
  else
    font = pfUI_config.global.font_default
    font_size_key = tonumber(pfUI_config.global.font_size)
    font_color_key = {pfUI.api.strsplit(",", "0, 0, 0, 0")}
  end

  for i=0,30 do
    local frames = {}
    table.insert(frames, getglobal("TrinketMenu_Trinket" .. i))
    table.insert(frames, getglobal("TrinketMenu_Menu" .. i))
    for k, f in pairs(frames) do
      pfUI.addonskinner.api.SkinActionButton(f)
      local keybind = getglobal(f:GetName() .. "HotKey")
      if keybind then
        keybind:SetFont(font, font_size_key, "OUTLINE")
        keybind:SetTextColor(unpack(font_color_key))
      end
    end
  end

  -- skin main actionbutton frame
  local main_frame = getglobal("TrinketMenu_MainFrame")
  pfUI.api.CreateBackdrop(main_frame)
  main_frame.backdrop:SetPoint("TOPLEFT", main_frame, "TOPLEFT", 2, -2)
  main_frame.backdrop:SetPoint("BOTTOMRIGHT", main_frame, "BOTTOMRIGHT", -2, 2)
  main_frame.backdrop:Hide()

  local main_resize_button = getglobal("TrinketMenu_MainResizeButton")

  main_resize_button:SetScript("OnShow", function()
    main_frame.backdrop:Show()
  end)
  main_resize_button:SetScript("OnHide", function()
    main_frame.backdrop:Hide()
  end)

  -- skin trinketlist frame
  local list_frame = getglobal("TrinketMenu_MenuFrame")
  pfUI.api.CreateBackdrop(list_frame)
  list_frame.backdrop:SetPoint("TOPLEFT", list_frame, "TOPLEFT", 2, -2)
  list_frame.backdrop:SetPoint("BOTTOMRIGHT", list_frame, "BOTTOMRIGHT", -2, 2)
  list_frame.backdrop:Hide()

  local list_resize_button = getglobal("TrinketMenu_MenuResizeButton")

  list_resize_button:SetScript("OnShow", function()
    list_frame.backdrop:Show()
  end)
  list_resize_button:SetScript("OnHide", function()
    list_frame.backdrop:Hide()
  end)
  
  pfUI.addonskinner:UnregisterSkin("TrinketMenu")
end)