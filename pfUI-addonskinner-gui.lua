-- load pfUI environment
  setfenv(1, pfUI:GetEnvironment())

  function pfUI.addonskinner:LoadGui()
    if not pfUI.gui then return end
  
    local function CreateSlashCmdLine(parent, index, cmd, description)
      parent.cmds = parent.cmds or {}
      if parent.cmds[index] then return end
      parent.cmds[index] = {}
      parent.cmds[index].cmd = parent:CreateFontString("Status", "LOW", "GameFontWhite")
      parent.cmds[index].cmd:SetFont(pfUI.font_default, C.global.font_size)
      parent.cmds[index].cmd:SetText("|cff33ffcc" .. cmd .. "|r")
      parent.cmds[index].cmd:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", - (parent:GetWidth() * 0.8), - (tonumber(C.global.font_size) * 2) * index)
  
      if description and description ~= "" then
        parent.cmds[index].desc = parent:CreateFontString("Status", "LOW", "GameFontWhite")
        parent.cmds[index].desc:SetFont(pfUI.font_default, C.global.font_size)
        parent.cmds[index].desc:SetText(" - " .. description)
        parent.cmds[index].desc:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", (parent:GetWidth() * 0.2), - (tonumber(C.global.font_size) * 2) * index)
      end
  
      parent:GetParent().objectCount = parent:GetParent().objectCount + 1
    end
  
    local old_gui = true
    
    if pfUI.gui.CreateGUIEntry then
      old_gui = false
    end
  
    if old_gui then
      local CreateConfig = pfUI.gui.CreateConfig
      local update = pfUI.gui.update
    
      if pfUI.gui.tabs.thirdparty then
        pfUI.gui.tabs.thirdparty.tabs.addonskinner = pfUI.gui.tabs.thirdparty.tabs:CreateTabChild(GetAddOnMetadata("pfUI-addonskinner", "X-LocalName"), true)
        pfUI.gui.tabs.thirdparty.tabs.addonskinner:SetScript("OnShow", function()
          if not this.setup then
            CreateConfig(update[c], this, T["General"], nil, nil, "header")
            CreateConfig(update["addonskinner"], this, T["Enable Chat Notifications"], C.addonskinner, "notifications", "checkbox")
    
            CreateConfig(update[c], this, T["Skins"], nil, nil, "header")
            table.sort(pfUI.addonskinner.list, function (a, b) return strupper(a) < strupper(b) end)
            for i, addon_name in pfUI.addonskinner.list do
              pfUI:UpdateConfig("addonskinner", "disabled", addon_name, "0")
              CreateConfig(nil, this, T["Disable Skin"] .. " " .. addon_name, C.addonskinner.disabled, addon_name, "checkbox")
            end
            
            this.setup = true
          end
        end)
      end
    else
      local Reload = pfUI.gui.Reload
      local CreateConfig = pfUI.gui.CreateConfig
      local CreateGUIEntry = pfUI.gui.CreateGUIEntry
      local U = pfUI.gui.UpdaterFunctions
      CreateGUIEntry(T["Thirdparty"], GetAddOnMetadata("pfUI-addonskinner", "X-LocalName"), function()
        CreateConfig(nil, T["General"], nil, nil, "header")
        CreateConfig(U["addonskinner"], T["Enable Chat Notifications"], C.addonskinner, "notifications", "checkbox")
  
        CreateConfig(nil, T["Skins"], nil, nil, "header")
        table.sort(pfUI.addonskinner.list, function (a, b) return strupper(a) < strupper(b) end)
        for i, addon_name in pfUI.addonskinner.list do
          pfUI:UpdateConfig("addonskinner", "disabled", addon_name, "0")
          CreateConfig(nil, T["Disable Skin"] .. " " .. addon_name, C.addonskinner.disabled, addon_name, "checkbox")
        end
  
        CreateConfig(nil, T["Version"] .. ": " .. GetAddOnMetadata("pfUI-addonskinner", "Version"), nil, nil, "header")
        CreateConfig(U["addonskinner"], T["Website"], nil, nil, "button", function()
          pfUI.chat.urlcopy.CopyText("https://gitlab.com/dein0s_wow_vanilla/pfUI-addonskinner")
        end)
  
      end)
    end
  end
  pfUI.addonskinner:LoadGui()