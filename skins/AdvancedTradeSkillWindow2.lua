-- Work in Progress skin for AdvancedTradeSkillWindow2 (ATSW2)
pfUI.addonskinner:RegisterSkin("AdvancedTradeSkillWindow2", function()
  -- upvalue the pfUI methods we use to avoid repeated lookups
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, CreateBackdropShadow, SkinCloseButton, SkinButton, SkinArrowButton, 
    SkinCheckbox, SkinCollapseButton, SetAllPointsOffset, SetHighlight, SkinScrollbar, 
    HookScript, SkinDropDown = 
  penv.StripTextures, penv.CreateBackdrop, penv.CreateBackdropShadow, penv.SkinCloseButton, penv.SkinButton, penv.SkinArrowButton, 
  penv.SkinCheckbox, penv.SkinCollapseButton, penv.SetAllPointsOffset, penv.SetHighlight, penv.SkinScrollbar, 
  penv.HookScript, penv.SkinDropDown

  -- Helper utilities to reduce duplication
  local function StripAndBackdrop(frame, alpha, inset)
    StripTextures(frame)
    CreateBackdrop(frame, nil, nil, alpha or .75)
    if inset and frame.backdrop then SetAllPointsOffset(frame.backdrop, frame, inset) end
  end

  -- Ensure a pfUI backdrop exists on the given frame (used to centralize OnShow reapply logic)
  local function EnsureBackdrop(frame, alpha, useShadow)
    if not frame then return end
    if frame.backdrop == nil then
      StripTextures(frame)
      frame:SetBackdrop(nil)
      CreateBackdrop(frame, nil, nil, alpha or .85)
      if useShadow and CreateBackdropShadow then CreateBackdropShadow(frame) end
    end
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

  local function GetLinkColor(link)
    if not link then return end
    local color = string.match(link, "|c(%x%x%x%x%x%x%x%x)")
    if not color then return end
    local len = string.len(color)
    local r, g, b
    if len == 8 then
      -- color is AARRGGBB, skip alpha
      r = tonumber(string.sub(color, 3, 4), 16) / 255
      g = tonumber(string.sub(color, 5, 6), 16) / 255
      b = tonumber(string.sub(color, 7, 8), 16) / 255
    else
      r = tonumber(string.sub(color, 1, 2), 16) / 255
      g = tonumber(string.sub(color, 3, 4), 16) / 255
      b = tonumber(string.sub(color, 5, 6), 16) / 255
    end
    return r, g, b
  end

  local function SetQualityBorder(frame, link)
    if not frame or not frame.backdrop or not frame.backdrop.SetBackdropBorderColor then return end

    local quality = nil
    if link then
      local _, _, q = GetItemInfo(link)
      if q then quality = q end
    end

    local r, g, b = nil, nil, nil
    if quality and quality > 0 then
      r, g, b = GetItemQualityColor(quality)
    else
      r, g, b = GetLinkColor(link)
    end

    if r and g and b then
      frame.backdrop:SetBackdropBorderColor(r, g, b, 1)
      frame.rr, frame.rg, frame.rb, frame.ra = r, g, b, 1
      frame.cr, frame.cg, frame.cb, frame.ca = r, g, b, 1
    else
      local br, bg, bb, ba = pfUI.api.GetStringColor(pfUI_config.appearance.border.color)
      frame.backdrop:SetBackdropBorderColor(br, bg, bb, ba)
      frame.rr, frame.rg, frame.rb, frame.ra = br, bg, bb, ba
      frame.cr, frame.cg, frame.cb, frame.ca = br, bg, bb, ba
    end
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
    local border = 1
    if pfUI and pfUI.skin and pfUI.skin.GetBorderSize then
      local _, b = pfUI.skin.GetBorderSize()
      if b then border = b end
    end
    
    ATSWFrame:DisableDrawLayer("BACKGROUND")
    StripTextures(ATSWFrame)
    CreateBackdrop(ATSWFrame, nil, nil, .75)
    SkinCloseButton(ATSWFrameCloseButton, ATSWFrame.backdrop, -6, -6)
    
    -- Title
    ATSWFrameTitleText:SetPoint("TOP", ATSWFrame.backdrop, "TOP", 0, -5)
    
    -- Adjust backdrop to be narrower (reduce right padding)
    ATSWFrame.backdrop:SetPoint("TOPLEFT", ATSWFrame, "TOPLEFT", 12, -12)
    ATSWFrame.backdrop:SetPoint("BOTTOMRIGHT", ATSWFrame, "BOTTOMRIGHT", -34, 12)
    
    -- Portrait icon (profession icon)
    local backdrop = CreateFrame("Frame", nil, ATSWFrame)
    backdrop:SetWidth(44)
    backdrop:SetHeight(44)
    backdrop:SetPoint("TOPLEFT", ATSWFrame.backdrop, "TOPLEFT", 10, -10)
    CreateBackdrop(backdrop, nil, nil, .75)
    
    ATSWFramePortrait:SetParent(backdrop)
    ATSWFramePortrait:SetAllPoints(backdrop)
    ATSWFramePortrait:SetTexCoord(.07, .93, .07, .93)
    ATSWFramePortrait:SetDrawLayer("ARTWORK")
    
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
          texture:SetTexCoord(.07, .93, .07, .93)
        end
        
        -- Apply customizable selection highlight color and alpha
        if tab.backdrop then
          tab.backdrop:SetBackdropColor(TAB_SELECTED_COLOR.r, TAB_SELECTED_COLOR.g, TAB_SELECTED_COLOR.b, TAB_SELECTED_ALPHA)
        end
        
        tab:SetFrameLevel(ATSWFrame:GetFrameLevel() + 5)
      end
    end

    -- Ensure Disguise tab icons are cropped and skinned like SpellBookSkillLineTab (pfUI style)
    local function ReskinDisguiseTabIcons()
      local disguiseTex = 'Interface\\Icons\\Ability_Rogue_Disguise'
      for i = 1, ATSW_MAX_TRADESKILL_TABS do
        local tab = getglobal('ATSWFrameTab' .. i)
        if tab then
          local tex = tab:GetNormalTexture()
          local name = tab.Name
          local tpath = nil
          if tex and tex.GetTexture then
            local ok, val = pcall(function() return tex:GetTexture() end)
            if ok then tpath = val end
          end

          if tpath == disguiseTex or (name and string.lower(name) == string.lower('Disguise')) then
            -- Ensure a normal texture exists so SkinButton receives a texture argument
            if not tex or not tex.GetTexture then
              tab:SetNormalTexture(disguiseTex)
              tex = tab:GetNormalTexture()
            else
              local ok2, val2 = pcall(function() return tex:GetTexture() end)
              if not ok2 or val2 == nil then
                tab:SetNormalTexture(disguiseTex)
                tex = tab:GetNormalTexture()
              end
            end

            -- Apply the same visual treatment as the other ATSW tabs (no extra scaling)
            StripTextures(tab)
            SkinButton(tab, nil, nil, nil, tex)
            -- Ensure the normal texture is set to the Disguise icon (SkinButton may replace regions)
            tab:SetNormalTexture(disguiseTex)
            local newTex = tab:GetNormalTexture()
            if newTex and newTex.SetTexCoord then
              newTex:SetTexCoord(.07, .93, .07, .93)
              newTex:Show()
            end

            -- Ensure selection backdrop uses the configured tab color
            if tab.backdrop and TAB_SELECTED_COLOR then
              tab.backdrop:SetBackdropColor(TAB_SELECTED_COLOR.r, TAB_SELECTED_COLOR.g, TAB_SELECTED_COLOR.b, TAB_SELECTED_ALPHA)
            end

            tab:SetFrameLevel(ATSWFrame:GetFrameLevel() + 5)
          end
        end
      end
    end

    -- Hook configuration function to reskin tabs if they are added/updated later
    local cfg_orig = getglobal('ATSW_ConfigureSkillButtons')
    if type(cfg_orig) == 'function' then
      local function cfg_wrapped(exception)
        cfg_orig(exception)
        ReskinDisguiseTabIcons()
      end
      rawset(_G, 'ATSW_ConfigureSkillButtons', cfg_wrapped)
    end

    -- Run once to cover the current state
    ReskinDisguiseTabIcons()

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
    StripTextures(ATSWTaskScrollFrameBackground)
    ATSWTaskScrollFrameBackground:Hide()

    -- Create a persistent backdrop around the Task list area so it is visible even with few/no tasks
    local function EnsureTaskListBackdrop()
      if ATSWTaskListBackdrop and ATSWTaskListBackdrop.pfuiCreated then return end

      -- Hide original decorative web texture
      ATSWWeb:Hide()

      -- Create a dedicated frame anchored to the task scrollframe
      local fb = CreateFrame("Frame", "ATSWTaskListBackdrop", ATSWFrame)
      fb:SetPoint("TOPLEFT", ATSWTaskScrollFrame, "TOPLEFT", 2, 3)
      fb:SetPoint("BOTTOMRIGHT", ATSWTaskScrollFrame, "BOTTOMRIGHT", 0, 1)
      CreateBackdrop(fb, nil, nil, .6)

      -- Place it behind the scrollframe content
      local fl = ATSWTaskScrollFrame:GetFrameLevel()
      fb:SetFrameLevel(math.max(1, fl - 1))

      fb.pfuiCreated = true
      ATSWTaskListBackdrop = fb
    end

    EnsureTaskListBackdrop()
    HookScript(ATSWFrame, "OnShow", EnsureTaskListBackdrop)

    -- Create a backdrop to replace the recipe background artwork (ATSWWeb) so visuals match pfUI
    local function EnsureRecipeListBackdrop()
      if ATSWRecipeListBackdrop and ATSWRecipeListBackdrop.pfuiCreated then return end

      -- Hide the original decorative background artwork if present
      ATSWWeb:Hide()

      local fb = CreateFrame("Frame", "ATSWRecipeListBackdrop", ATSWFrame)
      fb:SetPoint("TOPLEFT", ATSWListScrollFrame, "TOPLEFT", 2, 3)
      fb:SetPoint("BOTTOMRIGHT", ATSWListScrollFrame, "BOTTOMRIGHT", 0, 1)
      CreateBackdrop(fb, nil, nil, .6)

      -- Place it behind the list content
      local fl = ATSWListScrollFrame:GetFrameLevel()
      fb:SetFrameLevel(math.max(1, fl - 1))

      fb.pfuiCreated = true
      ATSWRecipeListBackdrop = fb
    end

    EnsureRecipeListBackdrop()
    HookScript(ATSWFrame, "OnShow", EnsureRecipeListBackdrop)

    -- Always clear/strip ATSW's recipe-background texture and ensure our backdrop persists
    ATSWBackground:SetTexture(nil)
    ATSWBackground:Hide()

    local original_UpdateBackground = getglobal('ATSW_UpdateBackground')
    if type(original_UpdateBackground) == 'function' then
      local function wrapped_UpdateBackground()
        -- Call original (in case other behavior runs)
        pcall(original_UpdateBackground)
        -- Remove the texture it sets and ensure pfUI backdrop is shown
        ATSWBackground:SetTexture(nil)
        ATSWBackground:Hide()
        EnsureRecipeListBackdrop()
      end
      rawset(_G, 'ATSW_UpdateBackground', wrapped_UpdateBackground)
    end

    -- Progress bar
    -- Apply pfUI statusbar styling, but preserve ATSW decorative textures so functionality remains
    StripTextures(ATSWProgressBar)
    ATSWProgressBar:SetStatusBarTexture("Interface\\AddOns\\pfUI\\img\\bar")
    CreateBackdrop(ATSWProgressBar)

    -- Keep ATSW border/glow/spark untouched so they blend with the bar; only adjust framelevel
    local barFL = ATSWTaskScrollFrame.backdrop and ATSWTaskScrollFrame.backdrop:GetFrameLevel() or ATSWFrame:GetFrameLevel()
    ATSWProgressBar:SetFrameLevel(barFL + 50)

    -- Stop button: skin with pfUI visuals but don't reparent forcibly (keeps original behavior)
    if ATSWProgressBarStop then
      -- Apply pfUI button skin and ensure it appears above the bar
      SkinButton(ATSWProgressBarStop)
      ATSWProgressBarStop:ClearAllPoints()
      if ATSWProgressBar and ATSWProgressBar.GetName and _G[ATSWProgressBar:GetName()] then
        -- anchor to the right edge of the bar if present
        ATSWProgressBarStop:SetPoint("RIGHT", ATSWProgressBar, "RIGHT", -2, 0)
        ATSWProgressBarStop:SetFrameLevel((ATSWProgressBar:GetFrameLevel() or 0) + 3)
      end

      ATSWProgressBarStop:Show()
    end
    
    -- Dropdown menus
    StripTextures(ATSWInvSlotDropDown)
    SkinDropDown(ATSWInvSlotDropDown, nil, nil, nil, true)
    StripTextures(ATSWSubClassDropDown)
    SkinDropDown(ATSWSubClassDropDown, nil, nil, nil, true)
    
    -- Rank/Skill progress bar
    StripTextures(ATSWRankFrame)
    ATSWRankFrame:SetStatusBarTexture("Interface\\AddOns\\pfUI\\img\\bar")
    CreateBackdrop(ATSWRankFrame)
    ATSWRankFrameRank:SetTextColor(1, 1, 1)
    
    -- Filter/Search boxes
    StripTextures(ATSWFilterBox, true, "BACKGROUND")
    CreateBackdrop(ATSWFilterBox, nil, true)
    if ATSWFilterBoxClear then
      SkinButton(ATSWFilterBoxClear)
    end
    StripTextures(ATSWSearchBox, true, "BACKGROUND")
    CreateBackdrop(ATSWSearchBox, nil, true)
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
      end
    end

    -- Collapse overlay helpers (tidy, idempotent)
    local function EnsureCollapseOverlay(btn)
      if not btn then return nil end
      if not btn._pfuiCollapseOverlay then
        local ov = CreateFrame("Frame", btn:GetName() .. "PfCollapse", btn)
        ov:SetWidth(14)
        ov:SetHeight(14)
        ov:SetPoint("LEFT", btn, "LEFT", 3, 0)
        CreateBackdrop(ov, nil, nil, .9)
        ov:SetFrameLevel(btn:GetFrameLevel() + 5)
        ov.text = ov:CreateFontString(nil, "OVERLAY")
        ov.text:SetFontObject(GameFontWhite)
        ov.text:SetPoint("CENTER", 0, 0)
        ov:Hide()
        btn._pfuiCollapseOverlay = ov
      end
      return btn._pfuiCollapseOverlay
    end

    local function UpdateCollapseOverlayForButton(btn)
      if not btn then return end
      local childTex = getglobal(btn:GetName() .. "Texture")

      if btn.Type == 'header' then
        -- detect +/- by inspecting ATSW's child texture (safe pcall)
        local glyph = "+"
        if childTex and childTex.GetTexture then
          local ok, tex = pcall(function() return childTex:GetTexture() end)
          if ok and type(tex) == 'string' and string.find(tex, "MinusButton") then glyph = "-" end
        end

        local ov = EnsureCollapseOverlay(btn)
        if ov then ov.text:SetText(glyph); ov:Show() end

        if childTex and childTex.Hide then childTex:Hide() end
      else
        if btn._pfuiCollapseOverlay then btn._pfuiCollapseOverlay:Hide() end
        if childTex and childTex.Show then childTex:Show() end
      end
    end

    -- Wrap ATSW_UpdateRecipes once (idempotent)
    if not _G.__pfui_wrapped_ATSW_UpdateRecipes then
      local original_UpdateRecipes = getglobal('ATSW_UpdateRecipes')
      if type(original_UpdateRecipes) == 'function' then
        rawset(_G, '__pfui_original_ATSW_UpdateRecipes', original_UpdateRecipes)
        local function pfui_wrapped_UpdateRecipes()
          pcall(original_UpdateRecipes)
          for i = 1, ATSW_RECIPES_DISPLAYED do
            UpdateCollapseOverlayForButton(getglobal("ATSWRecipe"..i))
          end
        end
        rawset(_G, 'ATSW_UpdateRecipes', pfui_wrapped_UpdateRecipes)
        rawset(_G, '__pfui_wrapped_ATSW_UpdateRecipes', true)
      end
    end

    -- Recipe icon (main selected recipe)
    local texture = getglobal("ATSWRecipeIconTexture")
    StripTextures(ATSWRecipeIcon)
    CreateBackdrop(ATSWRecipeIcon, nil, nil, .75)
    SetHighlight(ATSWRecipeIcon)
    
    if texture then
      texture:SetTexCoord(.07, .93, .07, .93)
      texture:SetDrawLayer("ARTWORK")
    end
    SetQualityBorder(ATSWRecipeIcon, ATSWRecipeIcon.Link)
    if ATSWRecipeIconQualityTexture then
      ATSWRecipeIconQualityTexture:Hide()
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
        CreateBackdrop(btn, nil, nil, .75)
        SetHighlight(btn)
        
        -- Fix backdrop layering - must be behind icon
        if btn.backdrop then
          btn.backdrop:SetFrameLevel(btn:GetFrameLevel() - 1)
        end
        
        if btnIcon then
          btnIcon:SetTexCoord(.07, .93, .07, .93)
          btnIcon:SetDrawLayer("ARTWORK")
        end
        
        if btnAmount then
          btnAmount:SetDrawLayer("OVERLAY")
        end
        
        btn.pfuiSkinned = true
      end

      if btnQuality then
        btnQuality:Hide()
      end
      
      -- Always fix text color after ATSW sets it to black
      if btnTitle then
        btnTitle:SetTextColor(1, 0.82, 0)
      end

      SetQualityBorder(btn, btn.Link)
    end
    
    -- Initial skin
    for i = 1, ATSW_NECESSARIES_DISPLAYED do
      SkinReagentButton(i)
    end
    
    -- Hook ATSW_ShowRecipe which updates reagents and hardcodes black text
    if ATSW_ShowRecipe and not ATSWFrame.pfuiShowRecipeHooked then
      local original_ATSW_ShowRecipe = ATSW_ShowRecipe
      ATSW_ShowRecipe = function(Name)
        original_ATSW_ShowRecipe(Name)
        -- Skin reagent buttons after they're updated
        for i = 1, ATSW_NECESSARIES_DISPLAYED do
          SkinReagentButton(i)
        end
        if ATSWRecipeIconQualityTexture then
          ATSWRecipeIconQualityTexture:Hide()
        end
        SetQualityBorder(ATSWRecipeIcon, ATSWRecipeIcon.Link)

        -- Ensure tool names are readable: white when available, red when missing
        for i = 1, (ATSW_TOOLS_DISPLAYED or 0) do
          local btn = getglobal('ATSWTool' .. i)
          local btnText = getglobal('ATSWTool' .. i .. 'Text')
          if btn and btnText and btn.R ~= nil then
            if btn.R == 0 then
              btnText:SetTextColor(1, 1, 1)
            else
              btnText:SetTextColor(1, 0, 0)
            end
          end
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

          -- Strip the decorative border textures for the active task to match pfUI backdrop
          if ATSWProgressBarBorder then
            for _, region in ipairs({ATSWProgressBarBorder:GetRegions()}) do
              if region and region.SetTexture then pcall(function() region:SetTexture(nil) end) end
            end
            if ATSWProgressBarBorder.Hide then pcall(function() ATSWProgressBarBorder:Hide() end) end
          end
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
    StripTextures(ATSWAmountBox, true, "BACKGROUND")
    CreateBackdrop(ATSWAmountBox, nil, true)
    -- Override cursor to remove custom texture
    ATSWAmountBox:SetScript("OnEnter", function()
      -- Don't set custom cursor
    end)
    
    -- Fix black text colors for description; allow ATSW to set recipe name color by quality
    ATSWRecipeName:SetTextColor(1, 0.82, 0)
    ATSWCraftDescription:SetTextColor(1, 1, 1)
    
    -- Tool text colors are handled dynamically in ATSW_ShowRecipe hook
    
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
        ATSWPreviousItemButton:SetWidth(math.max(8, bw - 8))
        ATSWPreviousItemButton:SetHeight(math.max(8, bh - 8))
      end

      -- Use custom return icon (64x64) and inset it by 7px on every side
      local iconPath = "Interface\\AddOns\\pfUI-addonskinner\\media\\img\\return64.tga"
      if normalTex then
        normalTex:SetTexture(iconPath)
        normalTex:ClearAllPoints()
        normalTex:SetPoint("TOPLEFT", ATSWPreviousItemButton, "TOPLEFT", 7, -7)
        normalTex:SetPoint("BOTTOMRIGHT", ATSWPreviousItemButton, "BOTTOMRIGHT", -7, 7)
        normalTex:SetTexCoord(.07, .93, .07, .93)
      end
      if pushedTex then
        pushedTex:SetTexture(iconPath)
        pushedTex:ClearAllPoints()
        pushedTex:SetPoint("TOPLEFT", ATSWPreviousItemButton, "TOPLEFT", 7, -7)
        pushedTex:SetPoint("BOTTOMRIGHT", ATSWPreviousItemButton, "BOTTOMRIGHT", -7, 7)
        pushedTex:SetTexCoord(.07, .93, .07, .93)
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

  -- Use ATSW's original XML size (keeps internal anchors consistent)
  ATSWShoppingListFrame:SetWidth(512)
  ATSWShoppingListFrame:SetHeight(200)

  -- Ensure the clickable area covers the whole frame (prevent mouse events falling through to WorldFrame)
  ATSWShoppingListFrame:SetHitRectInsets(20, 40, 0, 60) -- left, right, top, bottom

  -- Align the pfUI backdrop to match the shopping list's hit rect exactly
  ATSWShoppingListFrame.backdrop:SetPoint("TOPLEFT", ATSWShoppingListFrame, "TOPLEFT", 20, 0)
  ATSWShoppingListFrame.backdrop:SetPoint("BOTTOMRIGHT", ATSWShoppingListFrame, "BOTTOMRIGHT", -40, 60)
  ATSWShoppingListFrameTitleText:SetPoint("TOP", ATSWShoppingListFrame.backdrop, "TOP", 0, -5)

  -- Finalize scrollbar skinning and buttons
  SafeSkinScrollbar(ATSWSLScrollFrame, ATSWSLScrollFrameScrollBar)
  do
    local _slButtons = {"ATSWSLCloseButton"}
    ApplySkin(SkinButton, _slButtons)
  end

  -- Skin ATSW recipe tooltips (crafted-item tooltip + reagent info tooltip)
  -- use pfUI backdrop instead of the embedded backdrop so visuals match
  EnsureBackdrop(ATSWRecipeTooltip, .85, true)
  -- Re-apply pfUI visual on show (helps handle dynamic content updates)
  if HookScript then
    HookScript(ATSWRecipeTooltip, "OnShow", function()
      EnsureBackdrop(ATSWRecipeTooltip, .85, true)
    end)
  end

  -- Keep the inner/native item tooltip backdrop-less so it visually blends with the
  -- outer ATSW tooltip. We still strip textures and ensure no backdrop is present.
  StripTextures(ATSWRecipeItemTooltip)
  ATSWRecipeItemTooltip:SetBackdrop(nil)

  -- Do NOT create a pfUI backdrop for this inner tooltip; instead match its width
  -- to the parent ATSWRecipeTooltip on show so the text can fill the same area.
  if HookScript then
    HookScript(ATSWRecipeItemTooltip, "OnShow", function()
      StripTextures(ATSWRecipeItemTooltip)
      ATSWRecipeItemTooltip:SetBackdrop(nil)

      if ATSWRecipeTooltip and ATSWRecipeTooltip.GetWidth and ATSWRecipeItemTooltip.SetWidth then
        local pw = ATSWRecipeTooltip:GetWidth()
        if pw and pw > 0 then
          -- leave a small padding so the inner text doesn't touch the border
          ATSWRecipeItemTooltip:SetWidth(math.max(0, pw - 24))
        end
      end
    end)
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
    ATSWCSFramePortrait:SetTexCoord(.07, .93, .07, .93)
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
  local function EnsureCSNewCategoryBoxSkin()
    if not ATSWCSNewCategoryBox or ATSWCSNewCategoryBox._pfuiSkinned then return end

    -- Remove the decorative 3-part ARTWORK textures and replace with a pfUI backdrop
    StripTextures(ATSWCSNewCategoryBox, true) -- hide all regions (ARTWORK/BACKGROUND)
    CreateBackdrop(ATSWCSNewCategoryBox, nil, true)

    -- match search box font styling
    if ATSWCSNewCategoryBox.SetFont then
      ATSWCSNewCategoryBox:SetFont(pfUI.font_default, pfUI_config.global.font_size, "OUTLINE")
    end

    ATSWCSNewCategoryBox._pfuiSkinned = true
  end

  -- Try to skin now and also when the related frames show (cover creation timing)
  EnsureCSNewCategoryBoxSkin()
  if ATSWCSFrame and HookScript then
    HookScript(ATSWCSFrame, "OnShow", EnsureCSNewCategoryBoxSkin)
  elseif ATSWFrame and HookScript then
    -- as a fallback, run when main ATSW frame shows (editor is opened via buttons)
    HookScript(ATSWFrame, "OnShow", EnsureCSNewCategoryBoxSkin)
  end

  if ATSWCSFrameMoveUp then SkinArrowButton(ATSWCSFrameMoveUp, "up") end
  if ATSWCSFrameMoveDown then SkinArrowButton(ATSWCSFrameMoveDown, "down") end
  if ATSWCSFrameDelete then SkinCloseButton(ATSWCSFrameDelete) end

  pfUI.addonskinner:UnregisterSkin("AdvancedTradeSkillWindow2")
end)
