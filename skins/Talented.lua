pfUI.addonskinner:RegisterSkin("Talented-turtle", function()
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop, SkinButton, SkinCheckbox, SkinCloseButton, HookAddonOrVariable =
    penv.StripTextures, penv.CreateBackdrop, penv.SkinButton, penv.SkinCheckbox, penv.SkinCloseButton, penv.HookAddonOrVariable
  local hooksecurefunc = penv.hooksecurefunc or _G.hooksecurefunc
  local glow_texture = "Interface\\AddOns\\pfUI-addonskinner\\media\\img\\glow"

  local function skinFrame(frame, strip)
    if not frame or frame._pfasTalentedFrameSkinned then return end
    if strip ~= false then StripTextures(frame) end
    CreateBackdrop(frame, nil, nil, .75)
    frame._pfasTalentedFrameSkinned = 1
  end

  local function skinButton(btn)
    if not btn or btn._pfasTalentedButtonSkinned then return end
    SkinButton(btn)
    btn._pfasTalentedButtonSkinned = 1
  end

  local function skinHeaderButton(btn)
    if not btn or btn._pfasTalentedHeaderSkinned then return end
    StripTextures(btn, true)
    SkinButton(btn)
    if btn.SetButtonState then
      btn.SetButtonState = function() end
    end
    btn._pfasTalentedHeaderSkinned = 1
  end

  local function skinCheckbox(btn)
    if not btn or btn._pfasTalentedCheckSkinned then return end
    SkinCheckbox(btn)
    btn:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
    local checked = btn:GetCheckedTexture()
    if checked then
      checked:ClearAllPoints()
      checked:SetPoint("TOPLEFT", btn, "TOPLEFT", 3, -3)
      checked:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -3, 3)
      checked:SetDrawLayer("OVERLAY")
    end
    btn._pfasTalentedCheckSkinned = 1
  end

  local function skinCloseButton(btn, parent)
    if not btn or btn._pfasTalentedCloseSkinned then return end
    if SkinCloseButton then -- pfUI core path
      SkinCloseButton(btn, parent, -6, -6)
    else -- fallback if helper is unavailable
      StripTextures(btn, true)
      SkinButton(btn)
    end
    btn._pfasTalentedCloseSkinned = 1
  end

  local function skinEditBox(edit)
    if not edit or edit._pfasTalentedEditSkinned then return end
    StripTextures(edit, true, "BACKGROUND")
    CreateBackdrop(edit, nil, true)
    if edit:GetHeight() < 18 then
      edit:SetHeight(18)
    end
    edit:SetTextInsets(4, 4, 2, 2)
    if edit.backdrop then
      edit.backdrop:ClearAllPoints()
      edit.backdrop:SetPoint("TOPLEFT", edit, "TOPLEFT", -2, 2)
      edit.backdrop:SetPoint("BOTTOMRIGHT", edit, "BOTTOMRIGHT", 2, -2)
    end
    edit._pfasTalentedEditSkinned = 1
  end

  local function skinTreeClearButton(btn)
    if not btn or btn._pfasTalentedTreeClearSkinned then return end
    StripTextures(btn, true)
    SkinButton(btn, nil, nil, nil, nil, true)
    btn:SetSize(18, 18)
    btn:ClearAllPoints()
    btn:SetPoint("TOPRIGHT", btn:GetParent(), "TOPRIGHT", -6, -6)

    local icon = btn._pfasIcon or btn:CreateTexture(nil, "ARTWORK")
    btn._pfasIcon = icon
    icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
    icon:SetTexCoord(.08, .92, .08, .92)
    icon:SetPoint("TOPLEFT", btn, "TOPLEFT", 3, -3)
    icon:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -3, 3)

    btn._pfasTalentedTreeClearSkinned = 1
  end

  local function skinTalentButton(btn)
    if not btn then return end

    if not btn._pfasTalentedTalentSkinned then
      if btn.texture then
        btn.texture:Show()
        btn.texture:SetDrawLayer("BORDER")
        btn.texture:SetTexCoord(.06, .94, .06, .94)
      end
      if btn.slot then
        btn.slot:Show()
        btn.slot:SetDrawLayer("BACKGROUND")
        btn.slot:SetAlpha(0)
      end
      if btn.target and btn.target.texture then
        btn.target.texture:Show()
        btn.target.texture:SetDrawLayer("OVERLAY")
      end

      local nt = btn.GetNormalTexture and btn:GetNormalTexture()
      if nt then nt:SetAlpha(0) end
      local pt = btn.GetPushedTexture and btn:GetPushedTexture()
      if pt then pt:SetAlpha(0) end
      local ht = btn.GetHighlightTexture and btn:GetHighlightTexture()
      if ht then ht:SetAlpha(0) end

      if not btn.backdrop then CreateBackdrop(btn) end
      local dim = btn._pfasDim or btn:CreateTexture(nil, "ARTWORK")
      btn._pfasDim = dim
      dim:SetTexture(0, 0, 0, .25)
      dim:ClearAllPoints()
      dim:SetPoint("TOPLEFT", btn, "TOPLEFT", 2, -2)
      dim:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -2, 2)
      dim:Hide()
      local hover = btn._pfasHover or btn:CreateTexture(nil, "ARTWORK")
      btn._pfasHover = hover
      hover:SetTexture(glow_texture)
      hover:SetVertexColor(1, 1, 1, .5)
      hover:SetBlendMode("ADD")
      hover:SetDrawLayer("ARTWORK", 7)
      hover:ClearAllPoints()
      hover:SetPoint("TOPLEFT", btn, "TOPLEFT", 0, 0)
      hover:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", 0, 0)
      hover:Hide()
      if not btn._pfasTalentedHoverHooked then
        local oldEnter = btn.GetScript and btn:GetScript("OnEnter")
        local oldLeave = btn.GetScript and btn:GetScript("OnLeave")
        if btn.SetScript then
          btn:SetScript("OnEnter", function(self)
            if self._pfasHover then self._pfasHover:Show() end
            if oldEnter then oldEnter(self) end
          end)
          btn:SetScript("OnLeave", function(self)
            if self._pfasHover then self._pfasHover:Hide() end
            if oldLeave then oldLeave(self) end
          end)
        end
        btn._pfasTalentedHoverHooked = 1
      end
      btn._pfasTalentedTalentSkinned = 1
    end

    if btn.backdrop and btn.slot and btn.slot.GetVertexColor then
      local r, g, b = btn.slot:GetVertexColor()
      btn.backdrop:SetBackdropBorderColor(r, g, b, 1)
      if btn._pfasDim then
        local locked = false
        if btn.texture and btn.texture.IsDesaturated then
          local ok, desat = pcall(btn.texture.IsDesaturated, btn.texture)
          if ok and desat then
            locked = true
          end
        end
        if not locked then
          -- Vanilla fallback: locked talents are gray/desaturated and use near-equal slot color.
          if math.abs((r or 0) - (g or 0)) < 0.03 and math.abs((g or 0) - (b or 0)) < 0.03 and (r or 0) > 0.5 and (r or 0) < 0.8 then
            locked = true
          end
        end
        if locked then
          btn._pfasDim:Show()
        else
          btn._pfasDim:Hide()
        end
      end
    end
  end

  local function skinInspectButtons()
    skinButton(_G.TalentedInspectOpenButton)
    skinButton(_G.TalentedSuperInspectOpenButton)
  end

  local function applySkin()
    local targets = Talented:GetSkinTargets()

    skinFrame(_G.TalentedFrame)
    skinFrame(_G.TalentedAltFrame)
    skinFrame(_G.TalentedOptionsFrame)

    for _, frame in ipairs(targets.treeFrames or {}) do
      -- Do NOT add a per-tree backdrop: Talented tree art uses transparency and
      -- split quadrants, and an extra backdrop causes visible seam/patch artifacts.
      -- Keep native tree artwork/branches/arrows untouched for stable rendering.
      if frame.topleft then frame.topleft:SetAlpha(1) end
      if frame.topright then frame.topright:SetAlpha(1) end
      if frame.bottomleft then frame.bottomleft:SetAlpha(1) end
      if frame.bottomright then frame.bottomright:SetAlpha(1) end
      skinTreeClearButton(frame.clear)
    end

    local talentLookup = {}
    for _, button in ipairs(targets.talentButtons or {}) do
      talentLookup[button] = true
      skinTalentButton(button)
    end
    for _, button in ipairs(targets.buttons or {}) do
      if not talentLookup[button] and not button.slot and not button.rank and not button.texture then
        skinButton(button)
      end
    end
    for _, edit in ipairs(targets.edits or {}) do
      skinEditBox(edit)
    end

    if Talented.base then
      skinHeaderButton(Talented.base.bactions)
      skinHeaderButton(Talented.base.bmode)
      skinCloseButton(Talented.base.close, Talented.base.backdrop or Talented.base)
      skinCheckbox(Talented.base.checkbox)
      skinEditBox(Talented.base.editname)
    end
    skinInspectButtons()
  end

  local function skinOptionsFrame()
    local frame = _G.TalentedOptionsFrame or Talented.optionsFrame
    if not frame then return end

    skinFrame(frame)

    for _, row in ipairs(frame._rows or {}) do
      if row.kind == "toggle" then
        skinCheckbox(row.widget)
      elseif row.kind == "range" then
        skinButton(row.minus)
        skinButton(row.plus)
      end
    end

    for _, child in ipairs({ frame:GetChildren() }) do
      if child and child.GetObjectType and child:GetObjectType() == "Button" and not child._pfasTalentedOptionsChildSkinned then
        local nt = child.GetNormalTexture and child:GetNormalTexture()
        local tex = nt and nt.GetTexture and nt:GetTexture()
        if type(tex) == "string" and string.find(tex, "UI%-Panel%-MinimizeButton") then
          skinCloseButton(child, frame.backdrop or frame)
        else
          skinButton(child)
        end
        child._pfasTalentedOptionsChildSkinned = 1
      end
    end
  end

  local function syncTalentBorders()
    local targets = Talented:GetSkinTargets()
    for _, button in ipairs(targets.talentButtons or {}) do
      skinTalentButton(button)
    end
  end

  local function register()
    if Talented.RegisterSkinCallback and not Talented._pfasSkinRegistered then
      Talented:RegisterSkinCallback("pfui_addonskinner", function(_, reason)
        if reason == "view-set-class" or reason == "view-set-template" or reason == "base-created" then
          applySkin()
        else
          syncTalentBorders()
        end
      end)
      Talented._pfasSkinRegistered = 1
    end

    local TV = Talented.TalentView and Talented.TalentView.__index
    if hooksecurefunc and TV and not Talented._pfasTalentColorHooked then
      hooksecurefunc(TV, "Update", function()
        syncTalentBorders()
      end)
      hooksecurefunc(TV, "UpdateTalent", function()
        syncTalentBorders()
      end)
      hooksecurefunc(TV, "ClearTalentTab", function()
        syncTalentBorders()
      end)
      Talented._pfasTalentColorHooked = 1
    end

    if hooksecurefunc and not Talented._pfasOptionsSkinHooked then
      hooksecurefunc(Talented, "CreateOptionsFrame", function()
        skinOptionsFrame()
      end)
      hooksecurefunc(Talented, "OpenOptionsFrame", function()
        skinOptionsFrame()
      end)
      hooksecurefunc(Talented, "RefreshOptionsFrame", function()
        skinOptionsFrame()
      end)
      Talented._pfasOptionsSkinHooked = 1
    end

    if hooksecurefunc and not Talented._pfasInspectButtonSkinHooked then
      hooksecurefunc(Talented, "EnsureInspectButtons", function()
        skinInspectButtons()
      end)
      hooksecurefunc(Talented, "UpdateInspectButtons", function()
        skinInspectButtons()
      end)
      Talented._pfasInspectButtonSkinHooked = 1
    end

    applySkin()
    skinOptionsFrame()
    pfUI.addonskinner:UnregisterSkin("Talented-turtle")
  end

  if HookAddonOrVariable then -- wait until global Talented table exists
    HookAddonOrVariable("Talented", register)
  else
    register()
  end
end)
