pfUI.addonskinner:RegisterSkin("VCB", function()
  local penv = pfUI:GetEnvironment()
  local StripTextures = penv.StripTextures
  local CreateBackdrop = penv.CreateBackdrop
  local CreateBackdropShadow = penv.CreateBackdropShadow
  local SetAllPointsOffset = penv.SetAllPointsOffset
  local HookAddonOrVariable = penv.HookAddonOrVariable

  local ICON_INSET = -3
  local COUNT_LAYER_DEFAULT = 320
  local COUNT_LAYER_CONSOLIDATED = 340

  -- NOTE: Avoid using varargs ('...') in function definitions or overrides in this skin.
  -- Varargs have caused syntax/runtime issues in the target (vanilla 1.12) environment.
  -- Use `hooksecurefunc` or explicit-argument wrappers instead of `function(self, ...)`.

  local function applyCountLayer(count, parent, frameLevel, drawLayer)
    if not count then return end
    pcall(function()
      if count.SetParent then count:SetParent(parent) end
      if count.SetDrawLayer then count:SetDrawLayer("OVERLAY", drawLayer) end
      if count.SetFrameLevel then count:SetFrameLevel(frameLevel) end
    end)
  end

  local function fixChildButtonLayers(b, parentLvl)
    if not b then return end
    if b.SetFrameLevel then b:SetFrameLevel(parentLvl + 20) end
    if b.backdrop and b.backdrop.SetFrameLevel then b.backdrop:SetFrameLevel(parentLvl + 10) end
    local n = b:GetName() or ""
    local ic = _G[n .. "Icon"]
    if ic and ic.SetDrawLayer then ic:SetDrawLayer("OVERLAY", 250) end
    if ic and ic.SetFrameLevel then ic:SetFrameLevel(parentLvl + 30) end
    applyCountLayer(_G[n .. "Count"], b, parentLvl + 50, COUNT_LAYER_CONSOLIDATED)
  end

  local function skinButton(btn)
    if btn._pfuiSkinned then return end

    -- aggressively strip and reapply pfUI visuals (use ICON_INSET for icon inset)
    StripTextures(btn, true)
    CreateBackdrop(btn, ICON_INSET)
    CreateBackdropShadow(btn)
    pcall(function() btn.backdrop:SetBackdropBorderColor(0,0,0,1) end)

    -- ensure backdrop sits behind: lower its frame level and draw layer slightly below button
    pcall(function()
      local lvl = btn:GetFrameLevel() or 0
      if btn.backdrop and btn.backdrop.SetFrameLevel then btn.backdrop:SetFrameLevel(math.max(0, lvl - 6)) end
      if btn.backdrop and btn.backdrop.SetDrawLayer then btn.backdrop:SetDrawLayer("BACKGROUND", 0) end
    end)

    -- crop & attach icon (wrapped in pcall to stay minimal without existence checks)
    local name = btn:GetName() or ""
    local icon = _G[name .. "Icon"]
    pcall(function()
      icon:SetTexCoord(.08, .92, .08, .92)
      if btn.backdrop then
        SetAllPointsOffset(icon, btn.backdrop, ICON_INSET + 4)
      else
        icon:SetAllPoints(btn)
      end
      icon:SetParent(btn)
      pcall(function() if icon.SetAlpha then icon:SetAlpha(1) end end)
      if icon.SetDrawLayer then icon:SetDrawLayer("OVERLAY", 250) end
      if icon.SetFrameLevel then icon:SetFrameLevel((btn:GetFrameLevel() or 0) + 10) end
      pcall(function() if icon.Show then icon:Show() end end)
    end)
    -- ensure the stack/count text sits above icons and backdrops for visibility
    do
      local count = _G[name .. "Count"]
      if count then
        local lvl = (btn:GetFrameLevel() or 0) + 40
        applyCountLayer(count, btn, lvl, COUNT_LAYER_DEFAULT)
      end
    end
    -- If this is a regular buff button, force a black border and skip VCB color forwarding.
    if name and string.match(name, "^VCB_BF_BUFF_BUTTON") then
      pcall(function() if btn.backdrop and btn.backdrop.SetBackdropBorderColor then btn.backdrop:SetBackdropBorderColor(0,0,0,1) end end)
    else
      -- If VCB uses a separate border texture (e.g. VCB_BF_DEBUFF_BUTTON#Border), forward its color/alpha
      -- into the pfUI backdrop so debuff borders inherit VCB's configured colors with minimal overhead.
      local border = _G[name .. "Border"]
      if border and hooksecurefunc then
        -- apply current color immediately
        pcall(function()
          local ok, r,g,b = pcall(function() return border:GetVertexColor() end)
          local a = border.GetAlpha and border:GetAlpha() or 1
          if ok and r and btn.backdrop and btn.backdrop.SetBackdropBorderColor then btn.backdrop:SetBackdropBorderColor(r,g,b,a) end
        end)

        -- forward future color changes
        hooksecurefunc(border, "SetVertexColor", function(self, r, g, b, a)
          pcall(function()
            local ra,ga,ba = r or 1, g or 1, b or 1
            local aa = self.GetAlpha and self:GetAlpha() or a or 1
            if btn.backdrop and btn.backdrop.SetBackdropBorderColor then btn.backdrop:SetBackdropBorderColor(ra,ga,ba,aa) end
          end)
        end)

        -- forward alpha changes too
        hooksecurefunc(border, "SetAlpha", function(self, a)
          pcall(function()
            local r,g,b = self:GetVertexColor()
            if btn.backdrop and btn.backdrop.SetBackdropBorderColor then btn.backdrop:SetBackdropBorderColor(r or 1,g or 1,b or 1,a or 1) end
          end)
        end)
      end
    end

    btn._pfuiSkinned = true
  end

  -- Reapply layering & icon settings without recreating backdrops.
  -- Used when VCB updates buttons (dummy mode toggle / config close) which may reset parents/levels.
  local function reapplyButton(btn)
    if not btn or not btn._pfuiSkinned then return end
    local name = btn:GetName() or ""
    local icon = _G[name .. "Icon"]
    pcall(function()
      local lvl = btn:GetFrameLevel() or 0
      if btn.backdrop and btn.backdrop.SetFrameLevel then btn.backdrop:SetFrameLevel(math.max(0, lvl - 6)) end
      if btn.backdrop and btn.backdrop.SetDrawLayer then btn.backdrop:SetDrawLayer("BACKGROUND", 0) end

      -- regular buff buttons keep a forced black border
      if name and string.match(name, "^VCB_BF_BUFF_BUTTON") then
        if btn.backdrop and btn.backdrop.SetBackdropBorderColor then btn.backdrop:SetBackdropBorderColor(0,0,0,1) end
      end

      if icon then
        if icon.SetTexCoord then icon:SetTexCoord(.08, .92, .08, .92) end
        if btn.backdrop then
          SetAllPointsOffset(icon, btn.backdrop, ICON_INSET + 4)
        else
          icon:SetAllPoints(btn)
        end
        icon:SetParent(btn)
        if icon.SetDrawLayer then icon:SetDrawLayer("OVERLAY", 250) end
        if icon.SetFrameLevel then icon:SetFrameLevel((btn:GetFrameLevel() or 0) + 10) end
        if icon.Show then icon:Show() end
        -- ensure the stack/count text sits above icons and backdrops for visibility
        local count = _G[name .. "Count"]
        if count then
          local lvl = (btn:GetFrameLevel() or 0) + 40
          applyCountLayer(count, btn, lvl, COUNT_LAYER_DEFAULT)
        end
      end
    end)
  end

  local function skinAll()
    -- assume VCB defines indices (minimal checks)
    for i = 0, VCB_MAXINDEX.buff do skinButton(_G["VCB_BF_BUFF_BUTTON" .. i]) end
    for i = 0, VCB_MAXINDEX.debuff do skinButton(_G["VCB_BF_DEBUFF_BUTTON" .. i]) end
    for i = 0, VCB_MAXINDEX.weapon do skinButton(_G["VCB_BF_WEAPON_BUTTON" .. i]) end

    -- consolidated icon/frame (no pre-checks; pcall guards any missing internals)
    pcall(function()
      StripTextures(VCB_BF_CONSOLIDATED_ICON, true)
      CreateBackdrop(VCB_BF_CONSOLIDATED_ICON, ICON_INSET)
      CreateBackdropShadow(VCB_BF_CONSOLIDATED_ICON)
      pcall(function() VCB_BF_CONSOLIDATED_ICON.backdrop:SetBackdropBorderColor(1,0.85,0,1) end)

      local lvl = VCB_BF_CONSOLIDATED_ICON:GetFrameLevel() or 0
      -- ensure backdrop sits behind (match button behaviour)
      if VCB_BF_CONSOLIDATED_ICON.backdrop and VCB_BF_CONSOLIDATED_ICON.backdrop.SetFrameLevel then VCB_BF_CONSOLIDATED_ICON.backdrop:SetFrameLevel(math.max(0, lvl - 6)) end
      if VCB_BF_CONSOLIDATED_ICON.backdrop and VCB_BF_CONSOLIDATED_ICON.backdrop.SetDrawLayer then VCB_BF_CONSOLIDATED_ICON.backdrop:SetDrawLayer("BACKGROUND", 0) end

      -- icon: crop, inset, ensure visibility above backdrops (use stronger crop for consolidated icon)
      VCB_BF_CONSOLIDATED_ICONIcon:SetTexCoord(.14, .86, .14, .86)
      SetAllPointsOffset(VCB_BF_CONSOLIDATED_ICONIcon, VCB_BF_CONSOLIDATED_ICON.backdrop or VCB_BF_CONSOLIDATED_ICON, ICON_INSET + 4)
      VCB_BF_CONSOLIDATED_ICONIcon:SetParent(VCB_BF_CONSOLIDATED_ICON)
      pcall(function() VCB_BF_CONSOLIDATED_ICONIcon:SetVertexColor(1,1,1,1) end)
      pcall(function() VCB_BF_CONSOLIDATED_ICONIcon:SetAlpha(1) end)
      pcall(function() if VCB_BF_CONSOLIDATED_ICONIcon.Show then VCB_BF_CONSOLIDATED_ICONIcon:Show() end end)
      if VCB_BF_CONSOLIDATED_ICONIcon.SetDrawLayer then VCB_BF_CONSOLIDATED_ICONIcon:SetDrawLayer("OVERLAY", 250) end
      if VCB_BF_CONSOLIDATED_ICONIcon.SetFrameLevel then VCB_BF_CONSOLIDATED_ICONIcon:SetFrameLevel(lvl + 200) end

      -- set pfUI backdrop border color (handle both backdrop and backdrop_border for blizz mode)
      pcall(function()
        if VCB_BF_CONSOLIDATED_ICON.backdrop and VCB_BF_CONSOLIDATED_ICON.backdrop.SetBackdropBorderColor then
          VCB_BF_CONSOLIDATED_ICON.backdrop:SetBackdropBorderColor(1,0.85,0,1)
        end
        if VCB_BF_CONSOLIDATED_ICON.backdrop_border and VCB_BF_CONSOLIDATED_ICON.backdrop_border.SetBackdropBorderColor then
          VCB_BF_CONSOLIDATED_ICON.backdrop_border:SetBackdropBorderColor(1,0.85,0,1)
        end
        -- hide the shadow border (it creates a thin black rim outside the main border)
        if VCB_BF_CONSOLIDATED_ICON.backdrop_shadow and VCB_BF_CONSOLIDATED_ICON.backdrop_shadow.SetBackdropBorderColor then
          VCB_BF_CONSOLIDATED_ICON.backdrop_shadow:SetBackdropBorderColor(0,0,0,0)
        end

        -- do not modify consolidated buffframe backdrop here; leave VCB to manage it

        -- ensure consolidated buffframe sits above minimap but below its child elements
        pcall(function()
          if VCB_BF_CONSOLIDATED_BUFFFRAME and VCB_BF_CONSOLIDATED_BUFFFRAME.SetFrameStrata then
            VCB_BF_CONSOLIDATED_BUFFFRAME:SetFrameStrata("HIGH")
            if VCB_BF_CONSOLIDATED_BUFFFRAME.SetFrameLevel then
              VCB_BF_CONSOLIDATED_BUFFFRAME:SetFrameLevel(math.max(0, (VCB_BF_CONSOLIDATED_BUFFFRAME:GetFrameLevel() or 0) + 10))
            end
          end

          -- ensure consolidated icon count sits above the icon
          pcall(function()
            if VCB_BF_CONSOLIDATED_ICONCount and VCB_BF_CONSOLIDATED_ICONCount.SetDrawLayer then VCB_BF_CONSOLIDATED_ICONCount:SetDrawLayer("OVERLAY", 320) end
            if VCB_BF_CONSOLIDATED_ICONCount and VCB_BF_CONSOLIDATED_ICONCount.SetFrameLevel then VCB_BF_CONSOLIDATED_ICONCount:SetFrameLevel((VCB_BF_CONSOLIDATED_ICON:GetFrameLevel() or 0) + 40) end
          end)
        end)
      end)
    end)
  end

  HookAddonOrVariable("VCB", function()
    pcall(skinAll)

    -- minimal: replace consolidated frame backdrop edgeFile with pfUI's border texture (simple, fixed behavior)
    pcall(function()
      local f = VCB_BF_CONSOLIDATED_BUFFFRAME
      if not (f and f.SetBackdrop) or f._pfui_edgehooked then return end
      f._pfui_edgehooked = true

      if hooksecurefunc then
        local orig = f.SetBackdrop
        hooksecurefunc(f, "SetBackdrop", function(self, backdrop)
          if type(backdrop) ~= "table" then return end
          local nb = {}
          for k,v in pairs(backdrop) do nb[k]=v end
          if pfUI and pfUI.backdrop_thin and pfUI.backdrop_thin.edgeFile then
            nb.edgeFile = pfUI.backdrop_thin.edgeFile
            nb.edgeSize = pfUI and pfUI.pixel or 1
            nb.insets = pfUI and pfUI.backdrop_thin and pfUI.backdrop_thin.insets or {left=0,right=0,top=0,bottom=0}
          end
          -- apply modified backdrop
          pcall(function() orig = orig or self.SetBackdrop; orig(self, nb) end)

          -- enforce black background and yellow border (1,0.85,0,1)
          pcall(function()
            if self.SetBackdropColor then self:SetBackdropColor(0,0,0,1) end
            if self.SetBackdropBorderColor then self:SetBackdropBorderColor(1,0.85,0,1) end
          end)
        end)

        -- reapply current backdrop now (if any) so changes are visible right away
        pcall(function() if f.GetBackdrop and f:GetBackdrop() then f:SetBackdrop(f:GetBackdrop()) end end)
      end
    end)


    -- ensure future texture assignments keep pfUI styling (VCB sets textures on hover and elsewhere)
    pcall(function()
      local icon = VCB_BF_CONSOLIDATED_ICONIcon
      if icon and hooksecurefunc then
        hooksecurefunc(icon, "SetTexture", function(self)
          pcall(function()
            self:SetTexCoord(.14, .86, .14, .86)
            if VCB_BF_CONSOLIDATED_ICON and VCB_BF_CONSOLIDATED_ICON.backdrop and VCB_BF_CONSOLIDATED_ICON.backdrop.SetBackdropBorderColor then
              VCB_BF_CONSOLIDATED_ICON.backdrop:SetBackdropBorderColor(1,0.85,0,1)
            end
            if VCB_BF_CONSOLIDATED_ICON and VCB_BF_CONSOLIDATED_ICON.backdrop_shadow and VCB_BF_CONSOLIDATED_ICON.backdrop_shadow.SetBackdropBorderColor then
              VCB_BF_CONSOLIDATED_ICON.backdrop_shadow:SetBackdropBorderColor(0,0,0,0)
            end
          end)
        end)
      end

      -- no backdrop manipulation here; leave VCB's consolidated buffframe backdrop handling to VCB

    end)

    if VCB_BF_CreateBuffButtons then
      local orig = VCB_BF_CreateBuffButtons
      VCB_BF_CreateBuffButtons = function()
        orig()
        pcall(skinAll)
      end
    end

    -- Ensure reapply after individual buff updates (VCB may change parents/levels during dummy toggles)
    if VCB_BF_BUFF_BUTTON_Update then
      local orig = VCB_BF_BUFF_BUTTON_Update
      VCB_BF_BUFF_BUTTON_Update = function(button)
        orig(button)
        pcall(reapplyButton, button)
      end
    end

    -- Re-skin all on entering/exiting dummy mode to fix transient layer resets
    if VCB_BF_DummyConfigMode_Enable then
      local orig = VCB_BF_DummyConfigMode_Enable
      VCB_BF_DummyConfigMode_Enable = function()
        orig()
        pcall(skinAll)
      end
    end
    if VCB_BF_DummyConfigMode_Disable then
      local orig = VCB_BF_DummyConfigMode_Disable
      VCB_BF_DummyConfigMode_Disable = function()
        orig()
        pcall(skinAll)
      end
    end

    -- reapply consolidated icon layout on show (compact)
    local origOnShow = VCB_BF_CONSOLIDATED_BUFFFRAME:GetScript("OnShow")
    VCB_BF_CONSOLIDATED_BUFFFRAME:SetScript("OnShow", function(self)
      if origOnShow then origOnShow(self) end
      pcall(function()
        SetAllPointsOffset(VCB_BF_CONSOLIDATED_ICONIcon, VCB_BF_CONSOLIDATED_ICON.backdrop or VCB_BF_CONSOLIDATED_ICON, ICON_INSET + 4)
        VCB_BF_CONSOLIDATED_ICONIcon:SetParent(VCB_BF_CONSOLIDATED_ICON)
        pcall(function() VCB_BF_CONSOLIDATED_ICONIcon:SetVertexColor(1,1,1,1) end)
        pcall(function() VCB_BF_CONSOLIDATED_ICONIcon:SetAlpha(1) end)
        pcall(function() if VCB_BF_CONSOLIDATED_ICONIcon.Show then VCB_BF_CONSOLIDATED_ICONIcon:Show() end end)
        pcall(function() VCB_BF_CONSOLIDATED_ICONIcon:SetTexCoord(.14, .86, .14, .86) end)
        if VCB_BF_CONSOLIDATED_ICONIcon.SetDrawLayer then VCB_BF_CONSOLIDATED_ICONIcon:SetDrawLayer("OVERLAY", 250) end
        if VCB_BF_CONSOLIDATED_ICONIcon.SetFrameLevel then VCB_BF_CONSOLIDATED_ICONIcon:SetFrameLevel((VCB_BF_CONSOLIDATED_ICON:GetFrameLevel() or 0) + 10) end

        -- fix child buff button layers when consolidated (ensure icons render above backdrops)
        pcall(function()
          for i = 0, (VCB_MAXINDEX and VCB_MAXINDEX.buff or 15) do
            local b = _G["VCB_BF_BUFF_BUTTON" .. i]
            if b and b:GetParent() == VCB_BF_CONSOLIDATED_BUFFFRAME then
              local parentLvl = VCB_BF_CONSOLIDATED_BUFFFRAME:GetFrameLevel() or 0
              -- ensure button sits above the consolidated frame backdrop but below overlays like the icon and text
              fixChildButtonLayers(b, parentLvl)
            end
          end

          -- ensure debuff child counts are layered above when consolidated
          for i = 0, (VCB_MAXINDEX and VCB_MAXINDEX.debuff or 15) do
            local b = _G["VCB_BF_DEBUFF_BUTTON" .. i]
            if b and b:GetParent() == VCB_BF_CONSOLIDATED_BUFFFRAME then
              local parentLvl = VCB_BF_CONSOLIDATED_BUFFFRAME:GetFrameLevel() or 0
              fixChildButtonLayers(b, parentLvl)
            end
          end

          -- ensure weapon child counts are layered above when consolidated
          for i = 0, (VCB_MAXINDEX and VCB_MAXINDEX.weapon or 15) do
            local b = _G["VCB_BF_WEAPON_BUTTON" .. i]
            if b and b:GetParent() == VCB_BF_CONSOLIDATED_BUFFFRAME then
              local parentLvl = VCB_BF_CONSOLIDATED_BUFFFRAME:GetFrameLevel() or 0
              fixChildButtonLayers(b, parentLvl)
            end
          end
        end)

        -- ensure consolidated icon count sits above the consolidated frame content (redundant safe-guard)
        pcall(function()
          if VCB_BF_CONSOLIDATED_ICONCount and VCB_BF_CONSOLIDATED_ICONCount.SetDrawLayer then VCB_BF_CONSOLIDATED_ICONCount:SetDrawLayer("OVERLAY", 320) end
          if VCB_BF_CONSOLIDATED_ICONCount and VCB_BF_CONSOLIDATED_ICONCount.SetFrameLevel then VCB_BF_CONSOLIDATED_ICONCount:SetFrameLevel((VCB_BF_CONSOLIDATED_ICON:GetFrameLevel() or 0) + 40) end
        end)
      end)
    end)
  end)

  pfUI.addonskinner:UnregisterSkin("VCB")
end)
