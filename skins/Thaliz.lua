pfUI.addonskinner:RegisterSkin("Thaliz", function() 
  
  -- options
  pfUI.api.StripTextures(ThalizFrame)
  pfUI.api.CreateBackdrop(ThalizFrame, nil, nil, .75)
  pfUI.api.StripTextures(ThalizFrameTableList)
  pfUI.api.SkinScrollbar(ThalizFrameTableListScrollBar)
  pfUI.api.SkinCheckbox(ThalizFrameCheckbuttonRaid,18)
  pfUI.api.SkinCheckbox(ThalizFrameCheckbuttonSay,18)
  pfUI.api.SkinCheckbox(ThalizFrameCheckbuttonYell,18)
  pfUI.api.SkinCheckbox(ThalizFrameCheckbuttonIncludeDefault,18)
  pfUI.api.SkinCheckbox(ThalizFrameCheckbuttonPerCharacter,18)
  pfUI.api.SkinCheckbox(ThalizFrameCheckbuttonWhisper,18)
  pfUI.api.SkinCheckbox(ThalizFrameCheckbuttonColours,18)
  pfUI.api.StripTextures(ThalizFrameWhisper, true, "BACKGROUND")
  pfUI.api.CreateBackdrop(ThalizFrameWhisper, nil, true)
  for _, child in pairs ({ThalizFrame:GetChildren()}) do
    if child.IsObjectType then
      if child:IsObjectType("Button") then
        pfUI.api.SkinButton(child)
      end
    end
  end
  -- message edit
  pfUI.api.StripTextures(ThalizMsgEditorFrame)
  pfUI.api.CreateBackdrop(ThalizMsgEditorFrame, nil, nil, .75)
  ThalizMsgEditorFrame.backdrop:SetPoint("TOPLEFT", ThalizMsgEditorFrame, "TOPLEFT", 10, -10)
  ThalizMsgEditorFrame.backdrop:SetPoint("BOTTOMRIGHT", ThalizMsgEditorFrame, "BOTTOMRIGHT", -10, 0)
  ThalizMsgEditorFrame:SetHitRectInsets(10, 10, 10, 0)
  pfUI.api.SkinCheckbox(ThalizMsgEditorFrameCheckbuttonAlways,18)
  pfUI.api.SkinCheckbox(ThalizMsgEditorFrameCheckbuttonGuild,18)
  pfUI.api.SkinCheckbox(ThalizMsgEditorFrameCheckbuttonCharacter,18)
  pfUI.api.SkinCheckbox(ThalizMsgEditorFrameCheckbuttonClass,18)
  pfUI.api.SkinCheckbox(ThalizMsgEditorFrameCheckbuttonRace,18)
  pfUI.api.StripTextures(ThalizMsgEditorFrameMessage, true, "BACKGROUND")
  pfUI.api.CreateBackdrop(ThalizMsgEditorFrameMessage, nil, true)
  pfUI.api.StripTextures(ThalizMsgEditorFrameGroupValue, true, "BACKGROUND")
  pfUI.api.CreateBackdrop(ThalizMsgEditorFrameGroupValue, nil, true)
  for _, child in pairs ({ThalizMsgEditorFrame:GetChildren()}) do
    if child.IsObjectType then
      if child:IsObjectType("Button") then
        pfUI.api.SkinButton(child)
      end
    end
  end

  pfUI.addonskinner:UnregisterSkin("Thaliz")
end)