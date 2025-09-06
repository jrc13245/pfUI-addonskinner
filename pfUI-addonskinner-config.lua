--                MODULE        SUBGROUP       ENTRY               VALUE
-- pfUI:UpdateConfig("module_template", nil, nil, 0)

-- load pfUI environment
setfenv(1, pfUI:GetEnvironment())

function pfUI.addonskinner:LoadConfig()
  pfUI:UpdateConfig("addonskinner", nil,         "notifications",    "0")
  pfUI:UpdateConfig("addonskinner", "disabled",  nil,                nil)
end
pfUI.addonskinner:LoadConfig()