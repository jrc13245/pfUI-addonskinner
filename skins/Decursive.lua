pfUI.addonskinner:RegisterSkin("Decursive", function()
  if pfUI and pfUI.api and pfUI_config then
    local penv = pfUI:GetEnvironment()
    local hooksecurefunc, CreateBackdrop, SkinButton, SkinCheckbox, SkinSlider = penv.hooksecurefunc, penv.CreateBackdrop, penv.SkinButton, penv.SkinCheckbox, penv.SkinSlider
    local frame_table = {
      DecursiveMainBar = {
        buttons = {"Priority", "Skip", "Options", "Hide"},
      },
      DecursivePriorityListFrame = {
        buttons = {"Clear", "Close", "Populate", "Add", "Up", "Down"},
      },
      DecursiveSkipListFrame = {
        buttons = {"Clear", "Close", "Populate", "Add", "Up", "Down"},
      },
      DecursivePopulateListFrame = {
        buttons = {"Warrior", "Priest", "Mage", "Warlock", "Hunter", "Rogue", "Druid", "Other", "Close"},
        multi_buttons = {{"Group", 8}}
      },
      DcrOptionsFrame = {
        buttons = {"Anchor"},
        sliders = {"AmountOfAfflictedSlider", "CureBlacklistSlider", "ScanTimeSlider"},
        checkboxes_size = 24,
        checkboxes = {
          "PrintDefault", "PrintCustomFrame", "CheckForAbolish", "DoNotBLPrio", "AlwaysUseBestSpell", "RandomOrder", "CurePets",
          "SkipStealth", "PlaySound", "PrintError", "ShowToolTip", "ReverseLiveDisplay", "HideLL", "TieLL", "CureMutatingInjection", "CureWyvernSting", "RangeCheck",
        },
      },
      DecursiveAnchor = {
        buttons = {"Direction"},
      },
      DcrOptionsFrame2 = {
        buttons = {"Save"},
        checkboxes_size = 24,
        checkboxes = {"CureMagic", "CurePoison", "CureDisease", "CureCurse"},
      },
    }
    
    for k, v in pairs(frame_table) do
      CreateBackdrop(getglobal(k), nil, true, .75)
      
      if v.buttons then
        for _, btn in pairs(v.buttons) do
          local btn = getglobal(k..btn)
          SkinButton(btn)
        end
      end
      if v.multi_buttons then
        for _, btn in pairs(v.multi_buttons) do
          local name, size = btn[1], btn[2]
          for i = 1, size do
            SkinButton(getglobal(k..name..i))
          end
        end
      end
      if v.sliders then
        for _, slider in pairs(v.sliders) do
          SkinSlider(getglobal(k..slider))
        end
      end
      if v.checkboxes then
        for _, check in pairs(v.checkboxes) do
          SkinCheckbox(getglobal(k..check), v.checkboxes_size)
        end
      end
    end
    
    DecursiveMainBarPriority:SetPoint("LEFT", DecursiveMainBar, "RIGHT", 4, 0)
    DecursiveMainBarSkip:SetPoint("LEFT", DecursiveMainBarPriority, "RIGHT", 4, 0)
    DecursiveMainBarOptions:SetPoint("LEFT", DecursiveMainBarSkip, "RIGHT", 4, 0)
    DecursiveMainBarHide:SetPoint("LEFT", DecursiveMainBarOptions, "RIGHT", 4, 0)
    
    DecursiveAfflictedListFrameListItem1:SetPoint("TOPLEFT", DecursiveMainBar, "BOTTOMLEFT", 5, -4)
    
    hooksecurefunc("Dcr_ResetWindow", function()
      DcrOptionsFrame2:ClearAllPoints()
      DcrOptionsFrame2:SetPoint("TOPLEFT", DcrOptionsFrame, "TOPRIGHT", 4, 0)
    end, 1)
    hooksecurefunc("Dcr_ShowHideOptionsUI", function()
      if DcrOptionsFrame:IsVisible() then
        DcrOptionsFrame2:ClearAllPoints()
        DcrOptionsFrame2:SetPoint("TOPLEFT", DcrOptionsFrame, "TOPRIGHT", 4, 0)
      end
    end, 1)
    
    local tooltip_alpha = tonumber(pfUI_config.tooltip.alpha)
    CreateBackdrop(Dcr_Tooltip, nil, nil, tooltip_alpha)
    CreateBackdrop(DcrDisplay_Tooltip, nil, nil, tooltip_alpha)
    CreateBackdrop(Dcr_ScanningTooltip, nil, nil, tooltip_alpha)
  end

  pfUI.addonskinner:UnregisterSkin("Decursive")
  
end)
