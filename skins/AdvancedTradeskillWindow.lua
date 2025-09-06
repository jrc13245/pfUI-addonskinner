pfUI.addonskinner:RegisterSkin("AdvancedTradeskillWindow",function()
  -- upvalue the pfUI methods we use to avoid repeated lookups
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, SkinCloseButton, SkinButton, SkinArrowButton, 
    SkinCheckbox, SkinCollapseButton, SetAllPointsOffset, SetHighlight, SkinScrollbar, 
    HookScript, SkinDropDown = 
  penv.StripTextures, penv.CreateBackdrop, penv.SkinCloseButton, penv.SkinButton, penv.SkinArrowButton, 
  penv.SkinCheckbox, penv.SkinCollapseButton, penv.SetAllPointsOffset, penv.SetHighlight, penv.SkinScrollbar, 
  penv.HookScript, penv.SkinDropDown

  ATSWFrame:DisableDrawLayer("BACKGROUND")
  StripTextures(ATSWFrame)
  CreateBackdrop(ATSWFrame,nil, nil, .75)
  SkinCloseButton(ATSWFrameCloseButton, ATSWFrame.backdrop, -6, -6)
  ATSWFrameTitleText:SetPoint("TOP", ATSWFrame.backdrop, "TOP", 0, -5)
  StripTextures(ATSWRankFrameBorder)
  ATSWRankFrame:SetStatusBarTexture("Interface\\AddOns\\pfUI\\img\\bar")
  ATSWRankFrame:SetHeight(12)
  ATSWRankFrame:SetWidth(342)
  ATSWRankFrame:ClearAllPoints()
  ATSWRankFrame:SetPoint("TOPRIGHT", ATSWFrame.backdrop, "TOPRIGHT", -47, -68)
  CreateBackdrop(ATSWRankFrame)

  SkinButton(ATSWCSButton)
  SkinButton(ATSWOptionsButton)
  ATSWOptionsButton:SetPoint("TOPRIGHT", ATSWFrame.backdrop, "TOPRIGHT", -45, -40)
  SkinButton(ATSWQueueAllButton)
  SkinButton(ATSWCreateAllButton)
  SkinButton(ATSWCreateButton)
  SkinButton(ATSWQueueButton)
  SkinButton(ATSWQueueStartStopButton)
  SkinButton(ATSWQueueDeleteButton)
  SkinButton(ATSWReagentsButton)
  SkinButton(ATSWEnchantButton)

  SkinButton(ATSWBuyReagentsButton)
  SkinButton(ATSWOptionsFrameOKButton)

  SkinArrowButton(ATSWDecrementButton, "left", 16)
  StripTextures(ATSWInputBox, true, "BACKGROUND")
  CreateBackdrop(ATSWInputBox, nil, true)
  ATSWInputBox:SetWidth(42)
  SkinArrowButton(ATSWIncrementButton, "right", 16)

  SkinCheckbox(ATSWHeaderSortButton)
  SkinCheckbox(ATSWDifficultySortButton)
  SkinCheckbox(ATSWNameSortButton)
  SkinCheckbox(ATSWCustomSortButton)
  ATSWHeaderSortButton:SetPoint("TOPLEFT", ATSWFrame.backdrop, "TOPLEFT", 22, -25)
  ATSWDifficultySortButton:SetPoint("TOPLEFT", ATSWFrame.backdrop, "TOPLEFT", 152, -25)
  ATSWNameSortButton:SetPoint("TOPLEFT", ATSWFrame.backdrop, "TOPLEFT", 22, -40)
  ATSWCustomSortButton:SetPoint("TOPLEFT", ATSWFrame.backdrop, "TOPLEFT", 152, -40)
  ATSWCSButton:SetPoint("TOPLEFT", ATSWFrame.backdrop, "TOPLEFT", 275, -40)

  SkinCheckbox(ATSWOFUnifiedCounterButton)
  SkinCheckbox(ATSWOFSeparateCounterButton)
  SkinCheckbox(ATSWOFIncludeBankButton)
  SkinCheckbox(ATSWOFIncludeAltsButton)
  SkinCheckbox(ATSWOFIncludeMerchantsButton)
  SkinCheckbox(ATSWOFAutoBuyButton)
  SkinCheckbox(ATSWOFTooltipButton)
  SkinCheckbox(ATSWOFShoppingListButton)

  StripTextures(ATSWFilterBox, true, "BACKGROUND")
  CreateBackdrop(ATSWFilterBox, nil, true)  
  SkinButton(ATSWFilterBoxClear)
  StripTextures(ATSWCollapseAllButton)
  SkinCollapseButton(ATSWCollapseAllButton,true)
  HookScript(ATSWCollapseAllButton, "OnClick", function()
    ATSWCollapseAllButton:SetNormalTexture(ATSWCollapseAllButton.collapsed and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up")
  end)
  ATSWCollapseAllButton:SetNormalTexture(ATSWCollapseAllButton.collapsed and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up")
  for i=1,ATSW_TRADE_SKILLS_DISPLAYED do
    local btn = getglobal(string.format("ATSWSkill%d",i))
    StripTextures(btn)
    SkinCollapseButton(btn)
  end
  for i=1,4 do
    local btn = getglobal(string.format("ATSWQueueItem%dDeleteButton",i))
    SkinButton(btn)
  end
  StripTextures(ATSWSkillIcon)
  SkinButton(ATSWSkillIcon, nil, nil, nil, nil, true)
  ATSWSkillIcon:GetNormalTexture():SetTexCoord(.08, .92, .08, .92)
  for i=1,8 do
    local btn = getglobal(string.format("ATSWReagent%d",i))
    local btnIcon = getglobal(string.format("ATSWReagent%dIconTexture",i))
    local btnCount = getglobal(string.format("ATSWReagent%dCount",i))
    local size = btn:GetHeight() - 10
    StripTextures(btn)
    CreateBackdrop(btn, nil, nil, .75)
    SetAllPointsOffset(btn.backdrop, btn, 4)
    SetHighlight(btn)

    btnIcon:SetWidth(size)
    btnIcon:SetHeight(size)
    btnIcon:ClearAllPoints()
    btnIcon:SetPoint("LEFT", 5, 0)
    btnIcon:SetTexCoord(.08, .92, .08, .92)
    btnIcon:SetParent(btn.backdrop)
    btnIcon:SetDrawLayer("OVERLAY")
    btnCount:SetParent(btn.backdrop)
    btnCount:SetDrawLayer("OVERLAY")
    btnCount:ClearAllPoints()
    btnCount:SetPoint("BOTTOMRIGHT", btnIcon, "BOTTOMRIGHT", 0, 0)
  end

  StripTextures(ATSWListScrollFrame)
  SkinScrollbar(ATSWListScrollFrameScrollBar)
  StripTextures(ATSWExpandButtonFrame)
  StripTextures(ATSWInvSlotDropDown)
  SkinDropDown(ATSWInvSlotDropDown, nil, nil, nil, true)
  ATSWInvSlotDropDown:SetPoint("TOPLEFT", ATSWFrame.backdrop, "TOPLEFT", 190, -65)
  StripTextures(ATSWSubClassDropDown)
  SkinDropDown(ATSWSubClassDropDown, nil, nil, nil, true)
  ATSWSubClassDropDown:SetPoint("RIGHT", ATSWInvSlotDropDown, "LEFT", 27, 0)
  StripTextures(ATSWQueueScrollFrame)
  SkinScrollbar(ATSWQueueScrollFrameScrollBar)
  
  -- Reagent Frame
  StripTextures(ATSWReagentFrame)
  CreateBackdrop(ATSWReagentFrame,nil, nil, .75)
  SkinCloseButton(ATSWReagentFrameCloseButton, ATSWReagentFrame.backdrop, -6, -6)
  
  -- Options Frame
  StripTextures(ATSWOptionsFrame)
  CreateBackdrop(ATSWOptionsFrame,nil, nil, .75)
  
  -- Continue Frame
  StripTextures(ATSWContinueFrame)
  CreateBackdrop(ATSWContinueFrame,nil, nil, .75)
  
  -- AutoBuyButton Frame
  StripTextures(ATSWAutoBuyButtonFrame)
  CreateBackdrop(ATSWAutoBuyButtonFrame,nil, nil, .75)
  
  -- Shopping List Frame
  StripTextures(ATSWShoppingListFrame)
  CreateBackdrop(ATSWShoppingListFrame,nil, nil, .75)
  StripTextures(ATSWSLScrollFrame)
  SkinScrollbar(ATSWSLScrollFrameScrollBar)
  
  -- Custom Sorting Frame
  StripTextures(ATSWCSFrame)
  CreateBackdrop(ATSWCSFrame,nil, nil, .75)
  SkinCloseButton(ATSWCSFrameCloseButton, ATSWCSFrame.backdrop, -6, -6)
  StripTextures(ATSWCSUListScrollFrame)
  SkinScrollbar(ATSWCSUListScrollFrameScrollBar)
  StripTextures(ATSWCSSListScrollFrame)
  SkinScrollbar(ATSWCSSListScrollFrameScrollBar)

  pfUI.addonskinner:UnregisterSkin("AdvancedTradeskillWindow")
end)
