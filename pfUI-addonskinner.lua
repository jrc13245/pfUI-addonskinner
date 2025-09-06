pfUI:RegisterModule("addonskinner", function ()

  local config
  local msg_pref = GetAddOnMetadata("pfUI-addonskinner", "Title") .. "|r: "

  pfUI.addonskinner = CreateFrame("Frame", "pfAddonSkinner", UIParent)
  pfUI.addonskinner.skins = {}
  pfUI.addonskinner.list = {}
  pfUI.addonskinner:RegisterEvent("VARIABLES_LOADED")

  function pfUI.addonskinner:RegisterSkin(addon_name, skin_function)
    if pfUI.addonskinner.skins[addon_name] then return end
    pfUI.addonskinner.skins[addon_name] = skin_function
    table.insert(pfUI.addonskinner.list, addon_name)
  end

  function pfUI.addonskinner:UnregisterSkin(addon_name)
    if pfUI.addonskinner.skins[addon_name] then
      pfUI.addonskinner.skins[addon_name] = nil
    end
  end

  function pfUI.addonskinner:Skin(addon)
    local msg_skinned = msg_pref .. "%q skinned"
    local msg_err = msg_pref .. "error skinning %s --> |cffff0000%s|r"
    if addon then
      if pfUI.addonskinner.skins[addon] then
        if config.disabled[addon] ~= "1" then
          -- make it so an error in 1 skin doesn't break all skins
          local ok, err = pcall(pfUI.addonskinner.skins[addon])
          if config.notifications == "1" then
            if not ok then
              DEFAULT_CHAT_FRAME:AddMessage(string.format(msg_err,addon,tostring(err)))
            else
              DEFAULT_CHAT_FRAME:AddMessage(string.format(msg_skinned,addon))
            end
          end
        end
      end
    else
      -- load skins
      for i, addon_name in pairs(pfUI.addonskinner.list) do
        if config.disabled[addon_name] ~= "1" then
          if IsAddOnLoaded(addon_name) then
            -- make it so an error in 1 skin doesn't break all skins
            local ok, err = pcall(pfUI.addonskinner.skins[addon_name])
            if config.notifications == "1" then
              if not ok then
                DEFAULT_CHAT_FRAME:AddMessage(string.format(msg_err,addon_name,tostring(err)))
              else
                DEFAULT_CHAT_FRAME:AddMessage(string.format(msg_skinned,addon_name))
              end
            end
          end
        end
      end
    end
  end

  function pfUI.addonskinner:Load()
    if event == "VARIABLES_LOADED" then
      config = C.addonskinner
      -- purge non-existent skins from config
      for addon_name in config.disabled do
        if pfUI.addonskinner.skins[addon_name] == nil then
          config.disabled[addon_name] = nil
        end
      end
      if UnitIsConnected("player") then
        pfUI.addonskinner:Skin()
      else
        pfUI.addonskinner:RegisterEvent("PLAYER_LOGIN")
      end
      pfUI.addonskinner:RegisterEvent("ADDON_LOADED")
    elseif event == "PLAYER_LOGIN" then
      pfUI.addonskinner:Skin()
    else
      pfUI.addonskinner:Skin(arg1)
    end
  end

  pfUI.addonskinner:SetScript("OnEvent", pfUI.addonskinner.Load)

  function pfUI.addonskinner:Update()

  end

end)
