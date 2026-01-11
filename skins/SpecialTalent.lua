
pfUI.addonskinner:RegisterSkin("SpecialTalentUI", function()
  -- upvalue the pfUI methods we use to avoid repeated lookups
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, SkinCloseButton, SkinButton, SkinArrowButton, 
    SkinCheckbox, SkinScrollbar, SetAllPointsOffset, SkinDropDown, HookScript = 
  penv.StripTextures, penv.CreateBackdrop, penv.SkinCloseButton, penv.SkinButton, penv.SkinArrowButton, 
  penv.SkinCheckbox, penv.SkinScrollbar, penv.SetAllPointsOffset, penv.SkinDropDown, penv.HookScript
  
  -- Get pfUI config
  local C = penv.C or pfUI_config

  -- Hook the minimize/maximize functions to apply our custom sizing
  local OriginalMinimize = SpecialTalentFrame_Minimize
  local OriginalMaximize = SpecialTalentFrame_Maximize
  
  -- Store original positions on first access
  local originalPositions = {}
  local function SaveOriginalPosition(elementName)
    if not originalPositions[elementName] then
      local element = getglobal(elementName)
      if element then
        local point, relativeTo, relativePoint, xOfs, yOfs = element:GetPoint()
        if point then
          originalPositions[elementName] = {
            point = point,
            relativeTo = relativeTo,
            relativePoint = relativePoint,
            xOfs = xOfs or 0,
            yOfs = yOfs or 0
          }
        end
      end
    end
  end
  
  -- Helper function to reposition talent frames with reduced left padding
  local function RepositionTalentFrames()
    local leftOffset = -10  -- Move 10px to the left to reduce left border
    for i = 1, 3 do
      local frame = getglobal("SpecialTalentFrameTabFrame"..i)
      if frame then
        -- Reposition horizontally
        local point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint()
        if point then
          frame:ClearAllPoints()
          frame:SetPoint(point, relativeTo, relativePoint, (xOfs or 0) + leftOffset, yOfs)
        end
        
        -- Increase height to stretch artwork upward
        local currentHeight = frame:GetHeight()
        if currentHeight then
          frame:SetHeight(currentHeight + 10)
        end
      end
    end
  end
  
  -- Helper function to reposition right-side elements
  local function RepositionRightElements(mode)
    -- Positioning offsets: {horizontalOffset, verticalOffset, extraHorizontalInExpanded}
    local offsets = {
      SpecialTalentFrameMinimizeButton = {0, 10, 0},
      SpecialTalentRename = {0, 10, 0},
      SpecialTalentFrameNextButtonLarge = {0, 10, 0},
      SpecialTalentFramePreviousButtonLarge = {0, 10, 0},
      SpecialTalentFrameTab1 = {0, 14, 0},
      SpecialTalentFrameResetButton = {0, 0, 0},
    }
    
    local rightOffset = (mode == "compact") and 34 or 22
    
    for elementName, offset in pairs(offsets) do
      SaveOriginalPosition(elementName)
      local element = getglobal(elementName)
      if element and originalPositions[elementName] then
        local orig = originalPositions[elementName]
        local extraH = (mode == "expanded" and offset[3] > 0) and offset[3] or 0
        local upOffset = (elementName == "SpecialTalentUI_RenamePanel" and mode == "expanded") and 10 or offset[2]
        
        element:ClearAllPoints()
        element:SetPoint(orig.point, orig.relativeTo, orig.relativePoint, orig.xOfs + rightOffset + extraH, orig.yOfs + upOffset)
      end
    end
    
    -- Special handling for ResetConfirmationPanel - anchor to main frame for flush alignment
    local resetPanel = getglobal("SpecialTalentUI_ResetConfirmationPanel")
    if resetPanel then
      resetPanel:ClearAllPoints()
      resetPanel:SetPoint("TOPLEFT", SpecialTalentFrame, "TOPRIGHT", 0, 0)
    end
    
    -- Special handling for RenamePanel - anchor to main frame for flush alignment
    local renamePanel = getglobal("SpecialTalentUI_RenamePanel")
    if renamePanel then
      renamePanel:ClearAllPoints()
      renamePanel:SetPoint("TOPLEFT", SpecialTalentFrame, "TOPRIGHT", 0, 0)
    end
    
    -- Special handling for small navigation buttons - anchor to main frame
    local nextSmall = getglobal("SpecialTalentFrameNextButtonSmall")
    local prevSmall = getglobal("SpecialTalentFramePreviousButtonSmall")
    if nextSmall then
      nextSmall:ClearAllPoints()
      nextSmall:SetPoint("TOPLEFT", SpecialTalentFrame, "TOPRIGHT", 2, 0)
    end
    if prevSmall and nextSmall then
      prevSmall:ClearAllPoints()
      prevSmall:SetPoint("TOPLEFT", nextSmall, "BOTTOMLEFT", 0, -2)
    end
  end
  
  SpecialTalentFrame_Minimize = function()
    OriginalMinimize()
    -- Adjust compact mode: original 345x586, reduce height by 76px
    SpecialTalentFrame:SetWidth(306)
    SpecialTalentFrame:SetHeight(520)
    RepositionTalentFrames()
    RepositionRightElements("compact")
  end
  
  SpecialTalentFrame_Maximize = function()
    OriginalMaximize()
    -- Adjust expanded mode: original 900x586, reduce width by 30px and height by 76px
    SpecialTalentFrame:SetWidth(862)
    SpecialTalentFrame:SetHeight(520)
    RepositionTalentFrames()
    RepositionRightElements("expanded")
  end

  -- Main SpecialTalentFrame
  StripTextures(SpecialTalentFrame)
  
  -- Apply initial size (will be overridden by minimize/maximize but needed for first load)
  SpecialTalentFrame:SetWidth(862)
  SpecialTalentFrame:SetHeight(520)
  
  CreateBackdrop(SpecialTalentFrame, nil, nil, .75)
  
  SkinCloseButton(SpecialTalentFrameCloseButton, SpecialTalentFrame.backdrop, -6, -6)
  
  -- Apply initial repositioning for talent frames
  RepositionTalentFrames()
  
  -- Apply initial repositioning for right-side elements (detect current mode)
  local initialMode = "expanded"
  if SpecialTalentFrameSaved and SpecialTalentFrameSaved.frameMinimized then
    initialMode = "compact"
  end
  RepositionRightElements(initialMode)
  
  -- Reposition portrait
  if SpecialTalentFramePortrait then
    SpecialTalentFramePortrait:ClearAllPoints()
    SpecialTalentFramePortrait:SetPoint("TOPLEFT", SpecialTalentFrame, "TOPLEFT", 7, -4)
  end
  
  -- Hide default borders
  if SpecialTalentFrameBorder_TopLeft then SpecialTalentFrameBorder_TopLeft:Hide() end
  if SpecialTalentFrameBorder_TopLeft2 then SpecialTalentFrameBorder_TopLeft2:Hide() end
  if SpecialTalentFrameBorder_TopLeft3 then SpecialTalentFrameBorder_TopLeft3:Hide() end
  if SpecialTalentFrameBorder_TopLeft4 then SpecialTalentFrameBorder_TopLeft4:Hide() end
  if SpecialTalentFrameBorder_TopRight then SpecialTalentFrameBorder_TopRight:Hide() end
  if SpecialTalentFrameBorder_Left then SpecialTalentFrameBorder_Left:Hide() end
  if SpecialTalentFrameBorder_Right then SpecialTalentFrameBorder_Right:Hide() end
  if SpecialTalentFrameBorder_BotLeft then SpecialTalentFrameBorder_BotLeft:Hide() end
  if SpecialTalentFrameBorder_BotLeft2 then SpecialTalentFrameBorder_BotLeft2:Hide() end
  if SpecialTalentFrameBorder_BotLeft3 then SpecialTalentFrameBorder_BotLeft3:Hide() end
  if SpecialTalentFrameBorder_BotRight then SpecialTalentFrameBorder_BotRight:Hide() end
  
  -- Skin tabs (make them look like SpellBookSkillLineTab)
  for i = 1, 3 do
    local tab = getglobal("SpecialTalentFrameTab"..i)
    if tab then
      local texture = tab:GetNormalTexture()
      
      StripTextures(tab)
      SkinButton(tab, nil, nil, nil, texture)
      
      if texture then
        texture:SetTexCoord(.07, .93, .07, .93)
      end
      
      tab:SetScale(1.1)
      
      -- Bring tabs closer together with equal spacing
      if i == 2 then
        local point, relativeTo, relativePoint, xOfs, yOfs = tab:GetPoint()
        if point then
          tab:ClearAllPoints()
          tab:SetPoint(point, relativeTo, relativePoint, xOfs, (yOfs or 0) + 15)
        end
      elseif i == 3 then
        local point, relativeTo, relativePoint, xOfs, yOfs = tab:GetPoint()
        if point then
          tab:ClearAllPoints()
          tab:SetPoint(point, relativeTo, relativePoint, xOfs, (yOfs or 0) + 15)
        end
      end
    end
  end
  
  -- Skin checkbuttons
  if SpecialTalentFrameLearnedCheckButton then
    SkinCheckbox(SpecialTalentFrameLearnedCheckButton)
  end
  if SpecialTalentFrameForceShiftCheckButton then
    SkinCheckbox(SpecialTalentFrameForceShiftCheckButton)
  end
  if SpecialTalentFramePlannedCheckButton then
    SkinCheckbox(SpecialTalentFramePlannedCheckButton)
  end
  
  -- Skin buttons in loops
  local simpleButtons = {
    "SpecialTalentFrameResetButton",
    "SpecialTalentRename",
    "SpecialTalentFrameMinimizeButton",
    "SpecialTalentFrameNextButtonLarge",
    "SpecialTalentFramePreviousButtonLarge",
    "SpecialTalentFrameAddButton",
    "SpecialTalentFrameDeleteButton",
    "SpecialTalentFrameRenameButton",
    "SpecialTalentUI_ResetCancel"
  }
  
  for _, btnName in ipairs(simpleButtons) do
    local btn = getglobal(btnName)
    if btn then
      SkinButton(btn)
      if btnName == "SpecialTalentFrameResetButton" then
        btn:SetFrameLevel(btn:GetFrameLevel() + 2)
      end
    end
  end
  
  -- Skin arrow buttons
  if SpecialTalentFramePlanNextButton then
    SkinButton(SpecialTalentFramePlanNextButton, nil, nil, nil, nil, true)
  end
  if SpecialTalentFramePlanPrevButton then
    SkinButton(SpecialTalentFramePlanPrevButton, nil, nil, nil, nil, true)
  end
  
  -- Skin small navigation buttons (same width, anchored to main frame)
  local targetWidth = nil
  if SpecialTalentFrameNextButtonSmall then
    SkinButton(SpecialTalentFrameNextButtonSmall)
    local w = SpecialTalentFrameNextButtonSmall:GetWidth()
    targetWidth = w - 2
    SpecialTalentFrameNextButtonSmall:SetWidth(targetWidth)
  end
  if SpecialTalentFramePreviousButtonSmall and targetWidth then
    SkinButton(SpecialTalentFramePreviousButtonSmall)
    SpecialTalentFramePreviousButtonSmall:SetWidth(targetWidth)
  end
  
  -- Skin scrollbar
  if SpecialTalentFrameScrollBarScrollBar then
    SkinScrollbar(SpecialTalentFrameScrollBarScrollBar)
  end
  
  -- Skin dropdown
  if SpecialTalentFramePlanDropDown then
    SkinDropDown(SpecialTalentFramePlanDropDown)
  end
  
  -- Reset Confirmation Panel
  if SpecialTalentUI_ResetConfirmationPanel then
    StripTextures(SpecialTalentUI_ResetConfirmationPanel)
    CreateBackdrop(SpecialTalentUI_ResetConfirmationPanel, nil, nil, .75)
    
    local resetButtons = {"One", "Two", "Three", "All", "Cancel"}
    for _, suffix in ipairs(resetButtons) do
      local btn = getglobal("SpecialTalentUI_Reset"..suffix.."Button")
      if btn then SkinButton(btn) end
    end
  end
  
  -- Rename Panel
  if SpecialTalentUI_RenamePanel then
    StripTextures(SpecialTalentUI_RenamePanel)
    CreateBackdrop(SpecialTalentUI_RenamePanel, nil, nil, .75)
    
    if SpecialTalentUI_Rename then SkinButton(SpecialTalentUI_Rename) end
    if SpecialTalentUI_RenameCancel then SkinButton(SpecialTalentUI_RenameCancel) end
    
    -- Skin editbox
    if SpecialTalentUI_RenameEditBox then
      StripTextures(SpecialTalentUI_RenameEditBox)
      CreateBackdrop(SpecialTalentUI_RenameEditBox, nil, true)
      if SpecialTalentUI_RenameEditBox.backdrop then
        SpecialTalentUI_RenameEditBox.backdrop:SetPoint("TOPLEFT", -4, 0)
        SpecialTalentUI_RenameEditBox.backdrop:SetPoint("BOTTOMRIGHT", 4, 0)
      end
      SpecialTalentUI_RenameEditBox:SetTextInsets(3, 3, 3, 3)
    end
  end
  
  -- Skin talent buttons
  local function SkinTalentButton(button)
    if not button or button.pfuiSkinned then return end
    
    local icon = getglobal(button:GetName().."IconTexture")
    if not icon then return end
    
    StripTextures(button)
    SkinButton(button, nil, nil, nil, icon)
    
    -- Hide border textures and slot
    local texturesToHide = {"RankBorder", "PlannedBorder", "Slot"}
    for _, suffix in ipairs(texturesToHide) do
      local tex = getglobal(button:GetName()..suffix)
      if tex then tex:Hide() end
    end
    
    -- Set fonts
    local rank = getglobal(button:GetName().."Rank")
    if rank then rank:SetFont(pfUI.font_default, C.global.font_size, "OUTLINE") end
    
    local planned = getglobal(button:GetName().."Planned")
    if planned then planned:SetFont(pfUI.font_default, C.global.font_size, "OUTLINE") end
    
    button.pfuiSkinned = true
  end
  
  local function SkinAllTalentButtons()
    for tab = 1, 3 do
      for i = 1, 20 do
        local button = getglobal("SpecialTalentFrameTabFrame"..tab.."Talent"..i)
        if button then SkinTalentButton(button) end
      end
    end
  end
  
  -- Hook talent frame update
  if SpecialTalentFrame_Update then
    local orig_update = SpecialTalentFrame_Update
    SpecialTalentFrame_Update = function()
      orig_update()
      SkinAllTalentButtons()
    end
  end
  
  -- Skin on show
  if SpecialTalentFrame then
    HookScript(SpecialTalentFrame, "OnShow", SkinAllTalentButtons)
  end
end)
