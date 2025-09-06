pfUI.addonskinner:RegisterSkin("MTLove", function()
  local penv = pfUI:GetEnvironment()
  local CreateBackdrop, CreateBackdropShadow, StripTextures, SkinButton, SkinSlider, SkinCheckbox = 
  penv.CreateBackdrop, penv.CreateBackdropShadow, penv.StripTextures, penv.SkinButton, penv.SkinSlider, penv.SkinCheckbox

  local noop = function() end
  local default_border = pfUI_config.appearance.border.default
  local tooltip_alpha = pfUI_config.tooltip.alpha
  
  -- tooltip
  if MTLove_TT_Frame then
    CreateBackdrop(MTLove_TT_Frame,nil,nil,tonumber(pfUI_config.tooltip.alpha))
    CreateBackdrop(MTLove_TT_Frame_StatusBar)
    MTLove_TT_Frame_StatusBar:SetStatusBarTexture(pfUI.media["img:bar"])
    MTLove_TT_Frame_StatusBar:SetPoint("TOPLEFT",MTLove_TT_Frame,"BOTTOMLEFT",0,-1)
    MTLove_TT_Frame_StatusBar:SetPoint("TOPRIGHT",MTLove_TT_Frame,"BOTTOMRIGHT",0,-1)
    MTLove_TT_Frame_StatusBar:SetHeight(6)
    CreateBackdropShadow(MTLove_TT_Frame)
    CreateBackdropShadow(MTLove_TT_Frame_StatusBar)
    MTLove_TT_Frame:ClearAllPoints()
    local anchor_to = getglobal("TipBuddyTooltip") and "TipBuddyTooltip" or "GameTooltip"
    MTLove_TT_Frame:SetPoint("TOPLEFT", anchor_to, "BOTTOMLEFT", 0, -2*default_border)
    MTLove_TT_Frame.SetPoint = noop
  end
  -- frame
  if MTLove_Frame then
    CreateBackdrop(MTLove_Frame,nil,nil,tonumber(pfUI_config.tooltip.alpha))
    CreateBackdropShadow(MTLove_Frame)
    MTLove_Frame_StatusBar0:SetStatusBarTexture(pfUI.media["img:bar"])
    MTLove_Frame_StatusBar1:SetStatusBarTexture(pfUI.media["img:bar"])
    MTLove_Frame_StatusBar0:SetPoint("TOPLEFT",MTLove_Frame,"TOPLEFT",0,2)
    MTLove_Frame_StatusBar0:SetPoint("TOPRIGHT",MTLove_Frame,"TOPRIGHT",0,2)
    MTLove_Frame_StatusBar1:SetPoint("TOPLEFT",MTLove_Frame,"BOTTOMLEFT",0,1)
    MTLove_Frame_StatusBar1:SetPoint("TOPRIGHT",MTLove_Frame,"BOTTOMRIGHT",0,1)
    CreateBackdrop(MTLove_Frame_StatusBar0)
    CreateBackdropShadow(MTLove_Frame_StatusBar0)
    CreateBackdrop(MTLove_Frame_StatusBar1)
    CreateBackdropShadow(MTLove_Frame_StatusBar1)
  end
  -- options
  if MTLove_GUI_Frame then
    StripTextures(MTLove_GUI_Frame)
    CreateBackdrop(MTLove_GUI_Frame, nil, nil, .75)
    CreateBackdropShadow(MTLove_GUI_Frame)
    SkinCheckbox(MTLove_Toggle_Frame,24)
    SkinCheckbox(MTLove_Toggle_MotBar,24)
    SkinCheckbox(MTLove_Toggle_MoBar,24)
    SkinCheckbox(MTLove_Toggle_TT,24)
    SkinCheckbox(MTLove_Toggle_HealerHighlighte,24)
    SkinCheckbox(MTLove_Toggle_Self,24)
    SkinCheckbox(MTLove_Toggle_Pet,24)
    SkinCheckbox(MTLove_Toggle_NPC,24)
    SkinCheckbox(MTLove_Toggle_Party,24)
    SkinCheckbox(MTLove_Toggle_PVP,24)
    SkinCheckbox(MTLove_Toggle_Aliens,24)
    SkinSlider(MTLove_XSlider)
    SkinSlider(MTLove_YSlider)
    SkinButton(MTLove_GUI_Reset_Offset)
    SkinButton(MTLove_GUI_Done)
  end

  pfUI.addonskinner:UnregisterSkin("MTLove")
end)