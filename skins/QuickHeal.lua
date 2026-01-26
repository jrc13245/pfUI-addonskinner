pfUI:RegisterSkin("QuickHeal", "vanilla", function ()
    HookAddonOrVariable("QuickHealHealingBar", function()
    -- To get more Glassic style comment CreateBackdrop
  
      StripTextures(QuickHealHealingBar)
      CreateBackdrop(QuickHealHealingBar)
      CreateBackdropShadow(QuickHealHealingBar)
  
      QuickHealHealingBarStatusBar:SetStatusBarTexture(pfUI.media["img:bar"])
      QuickHealHealingBarStatusBar:SetStatusBarColor(0.0, 1.0, 0.0)
      QuickHealHealingBarStatusBar:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
  
      QuickHealHealingBarStatusBarPost:SetStatusBarTexture(pfUI.media["img:bar"])
      QuickHealHealingBarStatusBarPost:SetStatusBarColor(0.0, 1.0, 0.0, 0.5)
      QuickHealHealingBarStatusBarPost:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
  
      --QuickHealHealingBarBackground:Hide()
      QuickHealHealingBarBackground:SetTexture(pfUI.media["img:bar"])
      QuickHealHealingBarBackground:SetVertexColor(0.1, 0.1, 0.1, 0.8)
      QuickHealHealingBarSpark:SetTexture(pfUI.media["img:spark"])
      QuickHealHealingBarSpark:SetVertexColor(1.0, 1.0, 1.0, 1.0)
  
      QuickHealHealingBarText:SetFont(pfUI.font_default, C.global.font_size, "OUTLINE")
      QuickHealOverhealStatus_Text:SetFont(pfUI.font_default, C.global.font_size, "OUTLINE")
  
      QuickHealHealingBar:ClearAllPoints()
      QuickHealHealingBar:SetWidth(186)
      QuickHealHealingBar:SetHeight(13)
      QuickHealHealingBar:SetPoint("CENTER", CastingBarFrame, "CENTER", 0, 30)
  
      QuickHealOverhealStatus:SetWidth(300)
      QuickHealOverhealStatus:SetHeight(13)
      QuickHealOverhealStatus:SetPoint("CENTER", QuickHealHealingBar, "CENTER", 0, 5)
  
      QuickHealHealingBarStatusBar:SetWidth(186)
      QuickHealHealingBarStatusBar:SetHeight(13)
      QuickHealHealingBarStatusBar:SetPoint("TOPLEFT", QuickHealHealingBar, "TOPLEFT", 0, 0)
  
      QuickHealHealingBarStatusBarPost:SetWidth(372)
      QuickHealHealingBarStatusBarPost:SetHeight(13)
      QuickHealHealingBarStatusBarPost:SetPoint("TOPLEFT", QuickHealHealingBar, "TOPLEFT", 0, 0)
  
      QuickHealHealingBarBackground:SetWidth(186)
      QuickHealHealingBarBackground:SetHeight(13)
      QuickHealHealingBarBackground:SetPoint("TOPLEFT", QuickHealHealingBarStatusBarPost, "TOPLEFT", 0, 0)
  
      QuickHealHealingBarText:SetWidth(196)
      QuickHealHealingBarText:SetHeight(16)
      QuickHealHealingBarText:SetPoint("CENTER", QuickHealHealingBar, "CENTER", 0, 0)
  
      QuickHealOverhealStatus_Text:SetPoint("BOTTOM", QuickHealOverhealStatus, "TOP", 0, 0)
  end)
  
    HookAddonOrVariable("QuickHeal", function()
      local frames = {
        QuickHealConfig,
        QuickHeal_DownrankSlider,
        QuickHealConfig_NotificationChannelNameEditBox, -- -- skinEditBox ???
        MTListFrame,
        QH_Display_Tooltip,
      }
      
      local function Hover(btn, dir)
        if dir == "in" then 
        else 

        end
        
      end
      for _, frame in pairs(frames) do
        StripTextures(frame)
        CreateBackdrop(frame)
        CreateBackdropShadow(frame)
      end
  
        QuickHealConfig_NotificationChannelNameEditBox:ClearAllPoints()
        QuickHealConfig_NotificationChannelNameEditBox:SetWidth(133)
        QuickHealConfig_NotificationChannelNameEditBox:SetHeight(22)
        QuickHealConfig_NotificationChannelNameEditBox:SetPoint("TOPLEFT", QuickHealConfig, "TOPLEFT", 139, -110)
  
      local buttons = {
        QuickHealConfig_CloseButton,
        QuickHealConfig_DefaultButton,
        QuickHeal_MTList,
        MTListFrameClear,
        MTListFrameClose,
        MTListFramePopulate,
        MTListFrameAdd,
        MTListFrameUp,
        MTListFrameDown,
      }
      for _, button in pairs(buttons) do
        SkinButton(button)
      end
      MTListFrameClear:SetPoint("TOPLEFT", MTListFrameText, "TOPLEFT", 24, -12)
      MTListFrameAdd:SetTextColor(0,1,0,1)
      MTListFrameAdd:SetWidth(35)
      MTListFrameAdd:GetHighlightTexture():SetTexture(0,1,0,1)

      MTListFramePopulate:SetTextColor(0.41,0.8,0.94,1)
      MTListFramePopulate:SetWidth(35)
      MTListFramePopulate:GetHighlightTexture():SetTexture(0.41,0.8,0.94,1)

      MTListFrameClear:SetTextColor(1,1,0,1)
      MTListFrameClear:SetWidth(35)
      MTListFrameClear:GetHighlightTexture():SetTexture(0.4,0.4,0.4,1)

      MTListFrameClose:SetTextColor(1,0,0,1)
      MTListFrameClose:SetWidth(35)
      MTListFrameClose:GetHighlightTexture():SetTexture(1,0,0,1)
  
      local checkboxes = {
        QuickHealConfig_CheckButtonNotificationWhisper,
        QuickHealConfig_CheckButtonNotificationChannel,
        QuickHealConfig_CheckButtonNotificationParty,
        QuickHealConfig_CheckButtonNotificationRaid,
        QuickHealConfig_CheckButtonDisplayHealingBar,
        QuickHealConfig_CheckButtonMessageScreenCenter,
        QuickHealConfig_CheckButtonMessageChatWindow,
        QuickHealConfig_CheckButtonOverhealMessageScreenCenter,
        QuickHealConfig_CheckButtonOverhealMessageCastingBar,
        QuickHealConfig_CheckButtonOverhealMessagePlaySound,
        QuickHealConfig_CheckButtonTargetPriority,
        QuickHealConfig_CheckButtonQuickClick,
        QuickHealConfig_CheckButtonStopcast,
        QuickHealConfig_CheckButtonPrecastAggro,
        QuickHealConfig_CheckButtonPreHOTAggro,
        QuickHealConfig_FilterRaidGroup1CheckBox,
        QuickHealConfig_FilterRaidGroup2CheckBox,
        QuickHealConfig_FilterRaidGroup3CheckBox,
        QuickHealConfig_FilterRaidGroup4CheckBox,
        QuickHealConfig_FilterRaidGroup5CheckBox,
        QuickHealConfig_FilterRaidGroup6CheckBox,
        QuickHealConfig_FilterRaidGroup7CheckBox,
        QuickHealConfig_FilterRaidGroup8CheckBox,
      }
      for _, checkbox in pairs(checkboxes) do
        SkinCheckbox(checkbox)
      end
  
      local sliders = {
        QuickHealConfig_RatioFullSlider,
        QuickHealConfig_RatioHealthySlider,
        QuickHealConfig_RatioForceselfSlider,
        QuickHealConfig_PetPrioritySlider,
        QuickHealConfig_MaxOverhealPercentSlider,
        QuickHealConfig_StopcastCheckWindowSlider,
        QuickHealDownrank_Slider_NH,
        QuickHealDownrank_Slider_FH,
        QuickHealMinrank_Slider_NH,
        QuickHealMinrank_Slider_FH,
      }
      for _, slider in pairs(sliders) do
        SkinSlider(slider)
      end
  
      local dropdowns = {
        QuickHealConfig_ComboBoxNotificationStyle,
        QuickHealConfig_ComboBoxMessageConfigure,
        QuickHealConfig_ComboBoxNotificationChannel,
      }
      for _, dropdown in pairs(dropdowns) do
        SkinDropDown(dropdown)
      end
  
      for i = 1, 4 do
          local tab = _G["QuickHealConfigTab" .. i]
          if tab then
              SkinTab(tab)
              -- Adjust the position of each tab based on its index
              if i > 1 then
                  local previousTab = _G["QuickHealConfigTab" .. (i - 1)]
                  tab:SetPoint("TOPLEFT", previousTab, "TOPRIGHT", 3, 0)
              else
                  tab:SetPoint("TOPLEFT", QuickHealConfig, "BOTTOMLEFT", 0, -3)
              end
            end
         end
      end)
  -- remove from pending list when applied
  pfUI.addonskinner:UnregisterSkin("QuickHeal")
end)
