pfUI.addonskinner:RegisterSkin("pfQuest", function()
  
  local buttons = {"pfQuestShow", "pfQuestHide", "pfQuestClean", "pfQuestReset"}
  local penv = pfUI:GetEnvironment()
  local SkinButton, SkinDropDown = penv.SkinButton, penv.SkinDropDown

  -- don't skin if pfQuest does its own integration skinning down the road
  for _, btnName in pairs(buttons) do
    local btn = getglobal(btnName)
    if btn and not btn.backdrop then 
      SkinButton(btn)
    end
  end
  if pfQuestMapDropdown and not pfQuestMapDropdown.backdrop then
    SkinDropDown(pfQuestMapDropdown)
    pfQuestMapDropdown.backdrop:SetFrameLevel(pfQuestMapDropdown:GetParent():GetFrameLevel()+1)
  end  
  
  pfUI.addonskinner:UnregisterSkin("pfQuest")
end)