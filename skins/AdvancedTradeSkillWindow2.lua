-- Work in Progress skin for AdvancedTradeSkillWindow2 (ATSW2)
pfUI.addonskinner:RegisterSkin("AdvancedTradeSkillWindow2", function()
  -- upvalue the pfUI methods we use to avoid repeated lookups
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, SkinCloseButton, SkinButton, SkinArrowButton, 
    SkinCheckbox, SkinCollapseButton, SetAllPointsOffset, SetHighlight, SkinScrollbar, 
    HookScript, SkinDropDown, SkinTab = 
  penv.StripTextures, penv.CreateBackdrop, penv.SkinCloseButton, penv.SkinButton, penv.SkinArrowButton, 
  penv.SkinCheckbox, penv.SkinCollapseButton, penv.SetAllPointsOffset, penv.SetHighlight, penv.SkinScrollbar, 
  penv.HookScript, penv.SkinDropDown, penv.SkinTab

  -- Helper utilities to reduce duplication
  local function StripAndBackdrop(frame, alpha, inset)
    StripTextures(frame)
    CreateBackdrop(frame, nil, nil, alpha or .75)
    if inset and frame.backdrop then SetAllPointsOffset(frame.backdrop, frame, inset) end
  end

  local function SafeStripAndBackdrop(frame, alpha, inset)
    if not frame then return end
    StripAndBackdrop(frame, alpha, inset)
  end

  local function SafeSkinClose(frame, closeButton)
    if closeButton and frame and frame.backdrop then
      SkinCloseButton(closeButton, frame.backdrop, -6, -6)
    end
  end

  local function SafeSkinScrollbar(frame, scrollbar)
    if not frame then return end
    StripTextures(frame)
    if scrollbar then SkinScrollbar(scrollbar) end
  end

  -- Apply a skin function (e.g., SkinButton, SkinCheckbox) to a list of named globals
  local function ApplySkin(fn, names)
    for _, name in ipairs(names) do
      local obj = getglobal(name)
      if obj then fn(obj) end
    end
  end

  -- Main Frame (ATSWFrame)
  if ATSWFrame then
    local rawborder, border = 1, 1
    if pfUI and pfUI.skin and pfUI.skin.GetBorderSize then
      rawborder, border = pfUI.skin.GetBorderSize()
    end
    
    ATSWFrame:DisableDrawLayer("BACKGROUND")
    StripTextures(ATSWFrame)
    CreateBackdrop(ATSWFrame, nil, nil, .75)
    SkinCloseButton(ATSWFrameCloseButton, ATSWFrame.backdrop, -6, -6)
    
    -- Title
    if ATSWFrameTitleText then
      ATSWFrameTitleText:SetPoint("TOP", ATSWFrame.backdrop, "TOP", 0, -5)
    end
    
    -- Adjust backdrop to be narrower (reduce right padding)
    if ATSWFrame.backdrop then
      ATSWFrame.backdrop:SetPoint("TOPLEFT", ATSWFrame, "TOPLEFT", 12, -12)
      ATSWFrame.backdrop:SetPoint("BOTTOMRIGHT", ATSWFrame, "BOTTOMRIGHT", -34, 12)
    end
    
    -- Portrait icon (profession icon)
    if ATSWFramePortrait then
      local backdrop = CreateFrame("Frame", nil, ATSWFrame)
      backdrop:SetWidth(44)
      backdrop:SetHeight(44)
      backdrop:SetPoint("TOPLEFT", ATSWFrame.backdrop, "TOPLEFT", 10, -10)
      CreateBackdrop(backdrop, nil, nil, .75)
      
      ATSWFramePortrait:SetParent(backdrop)
      ATSWFramePortrait:SetAllPoints(backdrop)
      ATSWFramePortrait:SetTexCoord(.08, .92, .08, .92)
      ATSWFramePortrait:SetDrawLayer("ARTWORK")
    end
    
    -- Side tabs (SpellBook style) with customizable selection highlight
    local firstTab = getglobal("ATSWFrameTab1")
    if firstTab then
      firstTab:ClearAllPoints()
      firstTab:SetPoint("TOPLEFT", ATSWFrame.backdrop, "TOPRIGHT", border + (border == 1 and 1 or 2) - 1, -30)
    end
    
    for i = 1, ATSW_MAX_TRADESKILL_TABS do
      local tab = getglobal("ATSWFrameTab"..i)
      local lastTab = getglobal("ATSWFrameTab"..(i-1))
      local texture = tab and tab:GetNormalTexture()
      
      if tab then
        if lastTab and i > 1 then
          tab:ClearAllPoints()
          tab:SetPoint("TOPLEFT", lastTab, "BOTTOMLEFT", 0, -6)
        end
        
        StripTextures(tab)
        SkinButton(tab, nil, nil, nil, texture)
        
        if texture then
          texture:SetTexCoord(.08, .92, .08, .92)
        end
        
        -- Apply customizable selection highlight color and alpha
        if tab.backdrop then
          tab.backdrop:SetBackdropColor(TAB_SELECTED_COLOR.r, TAB_SELECTED_COLOR.g, TAB_SELECTED_COLOR.b, TAB_SELECTED_ALPHA)
        end
        
        tab:SetFrameLevel(ATSWFrame:GetFrameLevel() + 5)
      end
    end
    
    -- Recipe list scrollbar
    SafeSkinScrollbar(ATSWListScrollFrame, ATSWListScrollFrameScrollBar)
    
    -- Hide scrollbar background artwork
    local _scrollBackgrounds = {"ATSWScrollBackgroundTop","ATSWScrollBackgroundMiddle","ATSWScrollBackgroundBottom"}
    for _, name in ipairs(_scrollBackgrounds) do
      local tex = getglobal(name)
      if tex then tex:Hide() end
    end
    
    -- Task list scrollbar and background artwork
    SafeSkinScrollbar(ATSWTaskScrollFrame, ATSWTaskScrollFrameScrollBar)
    
    -- Strip textures from task scrollbar background frame (contains 2 decorative texture layers)
    if ATSWTaskScrollFrameBackground then
      StripTextures(ATSWTaskScrollFrameBackground)
      ATSWTaskScrollFrameBackground:Hide()
    end

    -- Create a persistent backdrop around the Task list area so it is visible even with few/no tasks
    local function EnsureTaskListBackdrop()
      if not ATSWTaskScrollFrame then return end
      if ATSWTaskListBackdrop and ATSWTaskListBackdrop.pfuiCreated then return end

      -- Hide original decorative web texture
      if ATSWWeb then ATSWWeb:Hide() end

      -- Create a dedicated frame anchored to the task scrollframe
      local fb = CreateFrame("Frame", "ATSWTaskListBackdrop", ATSWFrame)
      fb:SetPoint("TOPLEFT", ATSWTaskScrollFrame, "TOPLEFT", 2, 3)
      fb:SetPoint("BOTTOMRIGHT", ATSWTaskScrollFrame, "BOTTOMRIGHT", 0, 1)
      CreateBackdrop(fb, nil, nil, .6)

      -- Place it behind the scrollframe content
      if ATSWTaskScrollFrame then
        local fl = ATSWTaskScrollFrame:GetFrameLevel()
        fb:SetFrameLevel(math.max(1, fl - 1))
      end

      fb.pfuiCreated = true
      ATSWTaskListBackdrop = fb
    end

    -- If frame exists now, create backdrop immediately, otherwise hook it to show
    if ATSWTaskScrollFrame then
      EnsureTaskListBackdrop()
    else
      HookScript(ATSWFrame, "OnShow", EnsureTaskListBackdrop)
    end
    
    -- Progress bar
    if ATSWProgressBar then
      StripTextures(ATSWProgressBar)
      ATSWProgressBar:SetStatusBarTexture("Interface\\AddOns\\pfUI\\img\\bar")
      CreateBackdrop(ATSWProgressBar)

      -- Replace the thick Blizzard-style progress border with a thin outline (no fill)
      if ATSWProgressBarBorder then
        -- Hide the entire border frame (remove thick Blizzard border around task)
        ATSWProgressBarBorder:Hide()
      end

      -- Ensure glow/spark textures are hidden to keep visuals minimal
      if ATSWProgressBarGlow and ATSWProgressBarGlow.SetTexture then
        ATSWProgressBarGlow:SetTexture(nil)
      end
      if ATSWProgressBarSpark and ATSWProgressBarSpark.SetTexture then
        ATSWProgressBarSpark:SetTexture(nil)
      end
    end
    if ATSWProgressBarStop then
      SkinButton(ATSWProgressBarStop)
    end
    
    -- Dropdown menus
    if ATSWInvSlotDropDown then
      StripTextures(ATSWInvSlotDropDown)
      SkinDropDown(ATSWInvSlotDropDown, nil, nil, nil, true)
    end
    if ATSWSubClassDropDown then
      StripTextures(ATSWSubClassDropDown)
      SkinDropDown(ATSWSubClassDropDown, nil, nil, nil, true)
    end
    
    -- Rank/Skill progress bar
    if ATSWRankFrame then
      StripTextures(ATSWRankFrame)
      ATSWRankFrame:SetStatusBarTexture("Interface\\AddOns\\pfUI\\img\\bar")
      CreateBackdrop(ATSWRankFrame)
      
      if ATSWRankFrameRank then
        ATSWRankFrameRank:SetTextColor(1, 1, 1)
      end
    end
    
    -- Filter/Search boxes
    if ATSWFilterBox then
      StripTextures(ATSWFilterBox, true, "BACKGROUND")
      CreateBackdrop(ATSWFilterBox, nil, true)
    end
    if ATSWFilterBoxClear then
      SkinButton(ATSWFilterBoxClear)
    end
    if ATSWSearchBox then
      StripTextures(ATSWSearchBox, true, "BACKGROUND")
      CreateBackdrop(ATSWSearchBox, nil, true)
    end
    if ATSWSearchHelpButton then
      SkinButton(ATSWSearchHelpButton)
    end
    
    -- Sort checkboxes
    local sortCheckboxes = {
      "ATSWCustomSortCheckbox",
      "ATSWNameSortCheckbox",
      "ATSWDifficultySortCheckbox",
      "ATSWCategorySortCheckbox"
    }
    for _, cbName in ipairs(sortCheckboxes) do
      local cb = getglobal(cbName)
      if cb then SkinCheckbox(cb) end
    end
    
    -- Collapse all button
    if ATSWCollapseAllButton then
      StripTextures(ATSWCollapseAllButton)
      SkinCollapseButton(ATSWCollapseAllButton, true)
      HookScript(ATSWCollapseAllButton, "OnClick", function()
        ATSWCollapseAllButton:SetNormalTexture(ATSWCollapseAllButton.collapsed and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up")
      end)
      ATSWCollapseAllButton:SetNormalTexture(ATSWCollapseAllButton.collapsed and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up")
    end
    
    -- Recipe buttons
    for i = 1, ATSW_RECIPES_DISPLAYED do
      local btn = getglobal("ATSWRecipe"..i)
      if btn then
        StripTextures(btn)
        SkinCollapseButton(btn)

        -- Recipe tooltip skinning is WIP and temporarily removed to avoid unexpected behavior.
        -- TODO: Revisit and implement a robust skinning approach for `ATSWRecipeTooltip` and
        -- `ATSWRecipeItemTooltip` later. (Currently handled by ATSW extras.)
      end
    end
    
    -- Recipe icon (main selected recipe)
    if ATSWRecipeIcon then
      local texture = getglobal("ATSWRecipeIconTexture")
      StripTextures(ATSWRecipeIcon)
      CreateBackdrop(ATSWRecipeIcon, nil, nil, .75)
      SetHighlight(ATSWRecipeIcon)
      
      if texture then
        texture:SetTexCoord(.08, .92, .08, .92)
        texture:SetDrawLayer("ARTWORK")
      end
    end
    
    -- Reagents display (icon buttons with backdrops)
    local function SkinReagentButton(i)
      local btn = getglobal("ATSWReagent"..i)
      if not btn then return end
      
      local btnIcon = getglobal("ATSWReagent"..i.."Texture")
      local btnAmount = getglobal("ATSWReagent"..i.."Amount")
      local btnTitle = getglobal("ATSWReagent"..i.."Title")
      local btnQuality = getglobal("ATSWReagent"..i.."QualityTexture")
      
      -- One-time skinning setup
      if not btn.pfuiSkinned then
        -- Don't use StripTextures - it removes the icon texture too!
        -- Instead, manually hide unwanted textures
        if btnQuality then
          btnQuality:Hide()
        end
        
        CreateBackdrop(btn, nil, nil, .75)
        SetHighlight(btn)
        
        -- Fix backdrop layering - must be behind icon
        if btn.backdrop then
          btn.backdrop:SetFrameLevel(btn:GetFrameLevel() - 1)
        end
        
        if btnIcon then
          btnIcon:SetTexCoord(.08, .92, .08, .92)
          btnIcon:SetDrawLayer("ARTWORK")
        end
        
        if btnAmount then
          btnAmount:SetDrawLayer("OVERLAY")
        end
        
        btn.pfuiSkinned = true
      end
      
      -- Always fix text color after ATSW sets it to black
      if btnTitle then
        btnTitle:SetTextColor(1, 0.82, 0)
      end
    end
    
    -- Initial skin
    for i = 1, ATSW_NECESSARIES_DISPLAYED do
      SkinReagentButton(i)
    end
    
    -- Hook ATSW_ShowRecipe which updates reagents and hardcodes black text
    if ATSW_ShowRecipe and not ATSWFrame.pfuiShowRecipeHooked then
      local original_ATSW_ShowRecipe = ATSW_ShowRecipe
      ATSW_ShowRecipe = function(...)
        original_ATSW_ShowRecipe(unpack(arg))
        -- Skin reagent buttons after they're updated
        for i = 1, ATSW_NECESSARIES_DISPLAYED do
          SkinReagentButton(i)
        end
      end
      ATSWFrame.pfuiShowRecipeHooked = true
    end

    -- Ensure progress bar and Stop button sit above any backdrops when processing starts
    if ATSW_InitializeProgressBar and not ATSWFrame.pfuiInitProgressHooked then
      local orig_init = ATSW_InitializeProgressBar
      ATSW_InitializeProgressBar = function(StartTime, EndTime)
        orig_init(StartTime, EndTime)

        -- Ensure bar visibility and framelevel
        if ATSWProgressBar then
          ATSWProgressBar:Show()
          local baseFL = ATSWTaskScrollFrame and ATSWTaskScrollFrame.backdrop and ATSWTaskScrollFrame.backdrop:GetFrameLevel() or ATSWFrame:GetFrameLevel()
          ATSWProgressBar:SetFrameLevel(baseFL + 50)
        end

        -- Re-anchor Stop button to the bar and make sure it's visible
        if ATSWProgressBarStop then
          ATSWProgressBarStop:ClearAllPoints()
          ATSWProgressBarStop:SetParent(ATSWProgressBar)
          ATSWProgressBarStop:SetPoint("RIGHT", ATSWProgressBar, "RIGHT", 0, 0)
          ATSWProgressBarStop:SetFrameLevel(ATSWProgressBar:GetFrameLevel() + 3)
          ATSWProgressBarStop:Show()
        end
      end
      ATSWFrame.pfuiInitProgressHooked = true
    end
    
    -- Amount input box - hide MouseWheelCursor texture
    if ATSWAmountBox then
      StripTextures(ATSWAmountBox, true, "BACKGROUND")
      CreateBackdrop(ATSWAmountBox, nil, true)
      -- Override cursor to remove custom texture
      ATSWAmountBox:SetScript("OnEnter", function()
        -- Don't set custom cursor
      end)
    end
    
    -- Fix black text colors for recipe name and description
    if ATSWRecipeName then
      ATSWRecipeName:SetTextColor(1, 0.82, 0)
    end
    if ATSWCraftDescription then
      ATSWCraftDescription:SetTextColor(1, 1, 1)
    end
    
    -- Fix tool text colors
    for i = 1, ATSW_TOOLS_DISPLAYED do
      local toolText = getglobal("ATSWTool"..i.."Text")
      if toolText then
        toolText:SetTextColor(1, 0.82, 0)
      end
    end
    
    -- Buttons
    local buttons = {"ATSWCreateButton","ATSWCreateAllButton","ATSWCancelButton","ATSWCustomEditorButton","ATSWReagentsButton","ATSWTaskButton"}
    ApplySkin(SkinButton, buttons)
    
    -- Attributes is a checkbox
    if ATSWAttributesButton then
      SkinCheckbox(ATSWAttributesButton)
    end
    
    -- Make Create button match Task button width exactly
    if ATSWCreateButton and ATSWTaskButton then
      local taskW = ATSWTaskButton:GetWidth()
      local taskH = ATSWTaskButton:GetHeight()
      ATSWCreateButton:SetWidth(taskW)
      ATSWCreateButton:SetHeight(taskH)
    end
    
    -- Previous Item Button - use new return icon (return64.tga in img folder)
    if ATSWPreviousItemButton then
      local normalTex = ATSWPreviousItemButton:GetNormalTexture()
      local pushedTex = ATSWPreviousItemButton:GetPushedTexture()
      local highlightTex = ATSWPreviousItemButton:GetHighlightTexture()

      StripTextures(ATSWPreviousItemButton)
      SkinButton(ATSWPreviousItemButton)

      -- Reduce button size by 4px (2px each side)
      local bw, bh = ATSWPreviousItemButton:GetWidth(), ATSWPreviousItemButton:GetHeight()
      if bw and bh then
        ATSWPreviousItemButton:SetWidth(math.max(8, bw - 4))
        ATSWPreviousItemButton:SetHeight(math.max(8, bh - 4))
      end

      -- Use custom return icon (64x64) and inset it by 7px on every side
      local iconPath = "Interface\\AddOns\\pfUI-addonskinner\\media\\img\\return64.tga"
      if normalTex then
        normalTex:SetTexture(iconPath)
        normalTex:ClearAllPoints()
        normalTex:SetPoint("TOPLEFT", ATSWPreviousItemButton, "TOPLEFT", 7, -7)
        normalTex:SetPoint("BOTTOMRIGHT", ATSWPreviousItemButton, "BOTTOMRIGHT", -7, 7)
        normalTex:SetTexCoord(.08, .92, .08, .92)
      end
      if pushedTex then
        pushedTex:SetTexture(iconPath)
        pushedTex:ClearAllPoints()
        pushedTex:SetPoint("TOPLEFT", ATSWPreviousItemButton, "TOPLEFT", 7, -7)
        pushedTex:SetPoint("BOTTOMRIGHT", ATSWPreviousItemButton, "BOTTOMRIGHT", -7, 7)
        pushedTex:SetTexCoord(.08, .92, .08, .92)
        pushedTex:SetVertexColor(0.9, 0.9, 0.9)
      end
    end
    
    -- Input box for quantity
    if ATSWInputBox then
      StripTextures(ATSWInputBox, true, "BACKGROUND")
      CreateBackdrop(ATSWInputBox, nil, true)
    end
    if ATSWIncrementButton then
      SkinArrowButton(ATSWIncrementButton, "right", 16)
    end
    if ATSWDecrementButton then
      SkinArrowButton(ATSWDecrementButton, "left", 16)
    end
    
    -- Task delete buttons (dynamically created)
    local function SkinTaskDeleteButtons()
      for i = 1, ATSW_TASKS_DISPLAYED or 8 do
        local deleteBtn = getglobal("ATSWTask"..i.."DeleteButton")
        if deleteBtn and not deleteBtn.pfuiSkinned then
          SkinCloseButton(deleteBtn)
          deleteBtn.pfuiSkinned = true
        end
      end
    end
    
    -- Hook frame show to skin delete buttons
    if ATSWFrame.pfuiTaskHooked ~= true then
      HookScript(ATSWFrame, "OnShow", SkinTaskDeleteButtons)
      ATSWFrame.pfuiTaskHooked = true
    end
    
    -- Skin immediately if frame is visible
    if ATSWFrame:IsVisible() then
      SkinTaskDeleteButtons()
    end
  end
  
  -- Reagents Frame
  StripAndBackdrop(ATSWReagentsFrame, .75)
  SafeSkinClose(ATSWReagentsFrame, ATSWReagentsFrameCloseButton)
  SafeSkinScrollbar(ATSWRFScrollFrame, ATSWRFScrollFrameScrollBar)
  do
    local _rfButtons = {"ATSWRFBuyButton","ATSWRFCloseButton"}
    ApplySkin(SkinButton, _rfButtons)
  end
  
  -- Config Frame
  SafeStripAndBackdrop(ATSWConfigFrame, .75)
  SafeSkinClose(ATSWConfigFrame, ATSWConfigFrameCloseButton)
  
  -- Checkboxes (config options)
  local checkboxes = {"ATSWCFDisplaySideTabsButton","ATSWCFDisplayRecipeTooltipsButton","ATSWCFDisplayMerchantButton","ATSWCFDisplayShoppingListButton","ATSWCFDisplayItemCountsButton","ATSWCFDisplayBankCountsButton","ATSWCFDisplayAltsCountsButton","ATSWCFDisplayMerchantCountsButton","ATSWCFAutoBuyButton","ATSWCFDisplayToolsButton","ATSWCFLinkRecipeButton"}
  ApplySkin(SkinCheckbox, checkboxes)
  
  do
    local _cfgButtons = {"ATSWConfigFrameOKButton","ATSWConfigFrameCancelButton"}
    ApplySkin(SkinButton, _cfgButtons)
  end
  
  -- Shopping List Frame
  StripAndBackdrop(ATSWShoppingListFrame, .75)
  SafeSkinClose(ATSWShoppingListFrame, ATSWShoppingListFrameCloseButton)

  -- Small, tweakable sizing and hit-rect for the shopping list frame.
  -- Adjust these values to fine-tune the frame size and interactive area.
  local BACKDROP_INSET_TL_X, BACKDROP_INSET_TL_Y = 0, 0
  local BACKDROP_INSET_BR_X, BACKDROP_INSET_BR_Y = 0, 0

  ATSWShoppingListFrame:SetWidth(460)
  ATSWShoppingListFrame:SetHeight(140)

  SafeSkinScrollbar(ATSWSLScrollFrame, ATSWSLScrollFrameScrollBar)
  do
    local _slButtons = {"ATSWSLCloseButton"}
    ApplySkin(SkinButton, _slButtons)
  end
  
  -- Buy Necessary Frame
  StripAndBackdrop(ATSWBuyNecessaryFrame, .75)
  SafeSkinScrollbar(ATSWBNScrollFrame, ATSWBNScrollFrameScrollBar)
  do
    local _bnButtons = {"ATSWBNBuyButton","ATSWBNCancelButton","ATSWBuyButton"}
    ApplySkin(SkinButton, _bnButtons)
  end
  
  -- Search Help Frame
  SafeStripAndBackdrop(ATSWSearchHelpFrame, .75)
  SafeSkinClose(ATSWSearchHelpFrame, ATSWSearchHelpFrameCloseButton)
  
  -- Custom Sorting Editor Frame
  SafeStripAndBackdrop(ATSWCSFrame, .75)
  SafeSkinClose(ATSWCSFrame, ATSWCSFrameCloseButton)

  -- Apply same backdrop offsets as main frame
  if ATSWCSFrame and ATSWCSFrame.backdrop then
    ATSWCSFrame.backdrop:SetPoint("TOPLEFT", ATSWCSFrame, "TOPLEFT", 12, -12)
    ATSWCSFrame.backdrop:SetPoint("BOTTOMRIGHT", ATSWCSFrame, "BOTTOMRIGHT", -34, 12)
  end

  if ATSWCSFrameTitleText then
    ATSWCSFrameTitleText:SetPoint("TOP", ATSWCSFrame.backdrop, "TOP", 0, -5)
  end

  -- Portrait icon (profession icon)
  if ATSWCSFramePortrait then
    local backdrop = CreateFrame("Frame", nil, ATSWCSFrame)
    backdrop:SetWidth(44)
    backdrop:SetHeight(44)
    backdrop:SetPoint("TOPLEFT", ATSWCSFrame.backdrop, "TOPLEFT", 10, -10)
    CreateBackdrop(backdrop, nil, nil, .75)

    ATSWCSFramePortrait:SetParent(backdrop)
    ATSWCSFramePortrait:SetAllPoints(backdrop)
    ATSWCSFramePortrait:SetTexCoord(.08, .92, .08, .92)
    ATSWCSFramePortrait:SetDrawLayer("ARTWORK")
  end

  SafeSkinScrollbar(ATSWCSRecipesListScrollFrame, ATSWCSRecipesListScrollFrameScrollBar)
  if ATSWCSRecipesListScrollFrameBackground then
    StripTextures(ATSWCSRecipesListScrollFrameBackground)
    ATSWCSRecipesListScrollFrameBackground:Hide()
  end

  SafeSkinScrollbar(ATSWCSCategoriesListScrollFrame, ATSWCSCategoriesListScrollFrameScrollBar)
  if ATSWCSCategoriesListScrollFrameBackground then
    StripTextures(ATSWCSCategoriesListScrollFrameBackground)
    ATSWCSCategoriesListScrollFrameBackground:Hide()
  end

  do
    local _csButtons = {"ATSWCSFrameRename","ATSWCSRenameButton","ATSWCSAddButton"}
    ApplySkin(SkinButton, _csButtons)
  end

  -- Category name edit box
  if ATSWCSNewCategoryBox then
    StripTextures(ATSWCSNewCategoryBox, true, "BACKGROUND")
    CreateBackdrop(ATSWCSNewCategoryBox, nil, true)
  end

  if ATSWCSFrameMoveUp then SkinArrowButton(ATSWCSFrameMoveUp, "up") end
  if ATSWCSFrameMoveDown then SkinArrowButton(ATSWCSFrameMoveDown, "down") end
  if ATSWCSFrameDelete then SkinCloseButton(ATSWCSFrameDelete) end

  pfUI.addonskinner:UnregisterSkin("AdvancedTradeSkillWindow2")
end)
