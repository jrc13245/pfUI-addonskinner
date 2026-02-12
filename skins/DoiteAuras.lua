pfUI.addonskinner:RegisterSkin("DoiteAuras", function()
  -- ============================================
  -- ENVIRONMENT & FONT SETUP
  -- ============================================
  local penv = pfUI:GetEnvironment()
  local StripTextures = penv.StripTextures
  local CreateBackdrop = penv.CreateBackdrop
  local SkinButton = penv.SkinButton
  local SkinCheckbox = penv.SkinCheckbox
  local SkinCloseButton = penv.SkinCloseButton
  local SkinScrollbar = penv.SkinScrollbar
  local SkinDropDown = penv.SkinDropDown
  local SkinSlider = penv.SkinSlider
  local SkinCollapseButton = penv.SkinCollapseButton
  
  local font = pfUI_config.global.font_default
  local font_size = tonumber(pfUI_config.global.font_size) or 12
  
  -- ============================================
  -- UTILITY FUNCTIONS
  -- ============================================
  
  -- Strip default backdrop and apply pfUI backdrop
  local function ApplyPfUIFrame(frame, alpha)
    if not frame then return end
    frame:SetBackdrop(nil)
    StripTextures(frame, true)
    CreateBackdrop(frame, nil, nil, alpha or .75)
  end
  
  -- Skin edit boxes (input fields)
  local function SkinEditBox(editbox)
    if not editbox then return end
    StripTextures(editbox, true, "BACKGROUND")
    CreateBackdrop(editbox, nil, true)
  end
  
  -- ============================================
  -- MAIN FRAME (DoiteAurasFrame)
  -- ============================================
  local function SkinMainFrame()
    local frame = DoiteAurasFrame
    if not frame or frame.pfui_skinned then return end
    
    ApplyPfUIFrame(frame)
    
    -- Close button
    local children = {frame:GetChildren()}
    for i = 1, table.getn(children) do
      local child = children[i]
      if child and child:GetObjectType() == "Button" then
        if not child:GetName() then
          -- Unnamed close button
          local point = child:GetPoint(1)
          if point == "TOPRIGHT" then
            SkinCloseButton(child, frame.backdrop, -5, -6)
          end
        end
      end
    end
    
    -- Named buttons
    if DoiteAurasExportButton then SkinButton(DoiteAurasExportButton) end
    if DoiteAurasImportButton then SkinButton(DoiteAurasImportButton) end
    if DoiteAurasSettingsButton then SkinButton(DoiteAurasSettingsButton) end
    if DoiteAurasAddBtn then SkinButton(DoiteAurasAddBtn) end
    
    -- Input box
    if DoiteAurasInput then
      SkinEditBox(DoiteAurasInput)
    end
    
    -- Dropdowns - DON'T skin them, they have issues
    -- Let DoiteAurasAbilityDropDown, DoiteAurasItemDropDown, DoiteAurasBarDropDown stay default
    
    -- Scrollbar
    if DoiteAurasScrollScrollBar then
      SkinScrollbar(DoiteAurasScrollScrollBar)
    end
    
    -- Remove list container backdrop (frame already has one)
    for i = 1, table.getn(children) do
      local child = children[i]
      if child and child.SetBackdrop and child:GetObjectType() == "Frame" then
        local subChildren = {child:GetChildren()}
        for j = 1, table.getn(subChildren) do
          if subChildren[j]:GetObjectType() == "ScrollFrame" then
            child:SetBackdrop(nil)
            break
          end
        end
      end
    end
    
    frame.pfui_skinned = true
  end
  
  -- ============================================
  -- DYNAMIC LIST ELEMENTS (GROUPS & AURAS)
  -- ============================================
  local function SkinListElements()
    local listContent = DoiteAurasListContent
    if not listContent then return end
    
    local children = {listContent:GetChildren()}
    for i = 1, table.getn(children) do
      local row = children[i]
      if row then
        -- Toggle button (collapse/expand for groups)
        if row.toggleBtn and not row.toggleBtn.pfui_skinned then
          SkinButton(row.toggleBtn)
          row.toggleBtn.pfui_skinned = true
        end
        
        -- Edit button
        if row.editBtn and not row.editBtn.pfui_skinned then
          SkinButton(row.editBtn)
          row.editBtn.pfui_skinned = true
        end
        
        -- Remove button
        if row.removeBtn and not row.removeBtn.pfui_skinned then
          SkinButton(row.removeBtn)
          row.removeBtn.pfui_skinned = true
        end
        
        -- Up/Down arrows
        if row.upBtn and not row.upBtn.pfui_skinned then
          CreateBackdrop(row.upBtn, nil, nil, .75)
          if row.upBtn.backdrop then
            row.upBtn.backdrop:SetFrameLevel(row.upBtn:GetFrameLevel() - 1)
          end
          local tex = row.upBtn:GetNormalTexture()
          if tex then tex:SetTexCoord(.2, .8, .2, .8) end
          row.upBtn.pfui_skinned = true
        end
        
        if row.downBtn and not row.downBtn.pfui_skinned then
          CreateBackdrop(row.downBtn, nil, nil, .75)
          if row.downBtn.backdrop then
            row.downBtn.backdrop:SetFrameLevel(row.downBtn:GetFrameLevel() - 1)
          end
          local tex = row.downBtn:GetNormalTexture()
          if tex then tex:SetTexCoord(.2, .8, .2, .8) end
          row.downBtn.pfui_skinned = true
        end
        
        -- Checkboxes
        if row.disableCheck and not row.disableCheck.pfui_skinned then
          SkinCheckbox(row.disableCheck, 14)
          row.disableCheck.pfui_skinned = true
        end
        
        if row.sortTime and not row.sortTime.pfui_skinned then
          SkinCheckbox(row.sortTime, 14)
          row.sortTime.pfui_skinned = true
        end
        
        if row.sortPrio and not row.sortPrio.pfui_skinned then
          SkinCheckbox(row.sortPrio, 14)
          row.sortPrio.pfui_skinned = true
        end
        
        if row.fixedCheck and not row.fixedCheck.pfui_skinned then
          SkinCheckbox(row.fixedCheck, 14)
          row.fixedCheck.pfui_skinned = true
        end
      end
    end
  end
  
  -- ============================================
  -- EDIT/CONDITIONS FRAME (DoiteConditionsFrame)
  -- ============================================
  local function SkinEditFrame()
    local frame = DoiteConditionsFrame
    if not frame or frame.pfui_skinned then return end
    
    ApplyPfUIFrame(frame)
    
    -- Close button
    local closeBtn = frame.closeBtn
    if closeBtn then
      SkinCloseButton(closeBtn, frame.backdrop, -5, -6)
    end
    
    -- Dropdowns - DON'T skin them (they have visibility issues)
    -- DoiteConditions_GroupDD, DoiteConditions_GrowthDD, DoiteConditions_NumAurasDD
    -- and all the condition dropdowns - leave them default
    
    -- Sliders
    if DoiteConditions_SpacingSlider then SkinSlider(DoiteConditions_SpacingSlider) end
    if DoiteConditions_SliderX then SkinSlider(DoiteConditions_SliderX) end
    if DoiteConditions_SliderY then SkinSlider(DoiteConditions_SliderY) end
    if DoiteConditions_SliderSize then SkinSlider(DoiteConditions_SliderSize) end
    
    -- Grid button
    if DoiteConditions_GridBtn then SkinButton(DoiteConditions_GridBtn) end
    
    -- Checkboxes
    if frame.leaderCB then SkinCheckbox(frame.leaderCB, 20) end
    if frame.categoryCheck then SkinCheckbox(frame.categoryCheck, 20) end
    
    -- Edit boxes
    if frame.categoryInput then SkinEditBox(frame.categoryInput) end
    if frame.sliderXBox then SkinEditBox(frame.sliderXBox) end
    if frame.sliderYBox then SkinEditBox(frame.sliderYBox) end
    if frame.sliderSizeBox then SkinEditBox(frame.sliderSizeBox) end
    if frame.spacingEdit then SkinEditBox(frame.spacingEdit) end
    
    -- Category button
    if frame.categoryButton then SkinButton(frame.categoryButton) end
    
    -- Test All button
    if frame.testAllBtn then SkinButton(frame.testAllBtn) end
    
    frame.pfui_skinned = true
  end
  
  -- ============================================
  -- CONDITION ROWS (DYNAMIC)
  -- ============================================
  local function SkinConditionRows()
    local frame = DoiteConditionsFrame
    if not frame then return end
    
    local anchors = {frame.abilityAuraAnchor, frame.auraAuraAnchor, frame.itemAuraAnchor}
    for _, anchor in ipairs(anchors) do
      if anchor then
        local children = {anchor:GetChildren()}
        for i = 1, table.getn(children) do
          local row = children[i]
          if row then
            -- Buttons
            if row.btn1 and not row.btn1.pfui_skinned then
              SkinButton(row.btn1)
              row.btn1.pfui_skinned = true
            end
            
            if row.btn2 and not row.btn2.pfui_skinned then
              SkinButton(row.btn2)
              row.btn2.pfui_skinned = true
            end
            
            if row.btn3 and not row.btn3.pfui_skinned then
              SkinButton(row.btn3)
              row.btn3.pfui_skinned = true
            end
            
            if row.closeBtn and not row.closeBtn.pfui_skinned then
              SkinButton(row.closeBtn)
              row.closeBtn.pfui_skinned = true
            end
            
            if row.addButton and not row.addButton.pfui_skinned then
              SkinButton(row.addButton)
              row.addButton.pfui_skinned = true
            end
            
            -- Edit boxes
            if row.editBox and not row.editBox.pfui_skinned then
              SkinEditBox(row.editBox)
              row.editBox.pfui_skinned = true
            end
            
            -- Checkboxes
            if row.checkBox and not row.checkBox.pfui_skinned then
              SkinCheckbox(row.checkBox, 16)
              row.checkBox.pfui_skinned = true
            end
            
            -- DON'T skin row dropdowns - they break
          end
        end
      end
    end
  end
  
  -- ============================================
  -- EXPORT FRAME
  -- ============================================
  local function SkinExportFrame()
    local frame = DoiteAurasExportFrame
    if not frame or frame.pfui_skinned then return end
    
    ApplyPfUIFrame(frame)
    
    -- Close button
    local children = {frame:GetChildren()}
    for i = 1, table.getn(children) do
      local child = children[i]
      if child and child:GetObjectType() == "Button" and not child:GetName() then
        SkinCloseButton(child, frame.backdrop, -5, -6)
        break
      end
    end
    
    -- Scrollbar
    if DoiteAurasExportScrollScrollBar then
      SkinScrollbar(DoiteAurasExportScrollScrollBar)
    end
    
    -- Edit box
    if DoiteAurasExportEditBox then
      SkinEditBox(DoiteAurasExportEditBox)
    end
    
    -- Buttons
    if DoiteAurasCreateExportButton then SkinButton(DoiteAurasCreateExportButton) end
    if DoiteAurasClearExportButton then SkinButton(DoiteAurasClearExportButton) end
    if DoiteAurasCopyExportButton then SkinButton(DoiteAurasCopyExportButton) end
    
    frame.pfui_skinned = true
  end
  
  -- ============================================
  -- IMPORT FRAME
  -- ============================================
  local function SkinImportFrame()
    local frame = DoiteAurasImportFrame
    if not frame or frame.pfui_skinned then return end
    
    ApplyPfUIFrame(frame)
    
    -- Close button
    local children = {frame:GetChildren()}
    for i = 1, table.getn(children) do
      local child = children[i]
      if child and child:GetObjectType() == "Button" and not child:GetName() then
        SkinCloseButton(child, frame.backdrop, -5, -6)
        break
      end
    end
    
    -- Scrollbar
    if DoiteAurasImportScrollScrollBar then
      SkinScrollbar(DoiteAurasImportScrollScrollBar)
    end
    
    -- Edit box
    if DoiteAurasImportEditBox then
      SkinEditBox(DoiteAurasImportEditBox)
    end
    
    -- Button
    if DoiteAurasImportDoButton then SkinButton(DoiteAurasImportDoButton) end
    
    frame.pfui_skinned = true
  end
  
  -- ============================================
  -- SETTINGS FRAME
  -- ============================================
  local function SkinSettingsFrame()
    local frame = DoiteAurasSettingsFrame
    if not frame or frame.pfui_skinned then return end
    
    ApplyPfUIFrame(frame)
    
    -- Close button and other buttons
    local children = {frame:GetChildren()}
    local unnamedCount = 0
    for i = 1, table.getn(children) do
      local child = children[i]
      if child and child:GetObjectType() == "Button" then
        if not child:GetName() then
          unnamedCount = unnamedCount + 1
          if unnamedCount == 1 then
            SkinCloseButton(child, frame.backdrop, -5, -6)
          else
            SkinButton(child)
          end
        else
          SkinButton(child)
        end
      end
    end
    
    frame.pfui_skinned = true
  end
  
  -- ============================================
  -- CATEGORY CONFIRM DIALOG
  -- ============================================
  local function SkinCategoryConfirm()
    local frame = DoiteCond_CategoryConfirmFrame
    if not frame or frame.pfui_skinned then return end
    
    ApplyPfUIFrame(frame)
    
    -- Inner frame and buttons
    local children = {frame:GetChildren()}
    for i = 1, table.getn(children) do
      local child = children[i]
      if child and child:GetObjectType() == "Frame" then
        StripTextures(child, true)
        CreateBackdrop(child, nil, nil, .85)
        
        local buttons = {child:GetChildren()}
        for j = 1, table.getn(buttons) do
          local btn = buttons[j]
          if btn and btn:GetObjectType() == "Button" then
            SkinButton(btn)
          end
        end
      end
    end
    
    frame.pfui_skinned = true
  end
  
  -- ============================================
  -- MAIN SKINNING LOOP
  -- ============================================
  local updateFrame = CreateFrame("Frame")
  updateFrame.elapsed = 0
  updateFrame:SetScript("OnUpdate", function()
    this.elapsed = this.elapsed + arg1
    if this.elapsed > 0.2 then  -- Check every 0.2 seconds (faster than 0.5)
      this.elapsed = 0
      
      -- Skin all frames
      SkinMainFrame()
      SkinListElements()
      SkinEditFrame()
      SkinConditionRows()
      SkinExportFrame()
      SkinImportFrame()
      SkinSettingsFrame()
      SkinCategoryConfirm()
    end
  end)
  
  pfUI.addonskinner:UnregisterSkin("DoiteAuras")
end)
