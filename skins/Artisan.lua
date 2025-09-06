pfUI.addonskinner:RegisterSkin("Artisan", function()
    -- place main code below
    local penv = pfUI:GetEnvironment()
    local StripTextures, CreateBackdrop, SkinCloseButton, SkinButton, SkinArrowButton, 
    SkinCheckbox, SkinCollapseButton, SetAllPointsOffset, SetHighlight, SkinScrollbar, 
    HookScript, hooksecurefunc, SkinDropDown, SkinSlider = 
  penv.StripTextures, penv.CreateBackdrop, penv.SkinCloseButton, penv.SkinButton, penv.SkinArrowButton, 
  penv.SkinCheckbox, penv.SkinCollapseButton, penv.SetAllPointsOffset, penv.SetHighlight, penv.SkinScrollbar, 
  penv.HookScript, penv.hooksecurefunc, penv.SkinDropDown, penv.SkinSlider
    local tooltip_alpha = tonumber(pfUI_config.tooltip.alpha)
    if tooltip_alpha > 0.75 then tooltip_alpha = 0.75 end

    local TypeColor = {
        ["optimal"] = { r = 1.00, g = 0.50, b = 0.25 },
        ["medium"]  = { r = 1.00, g = 1.00, b = 0.00 },
        ["easy"]    = { r = 0.25, g = 0.75, b = 0.25 },
        ["trivial"] = { r = 0.50, g = 0.50, b = 0.50 },
        ["header"]  = { r = 1.00, g = 0.82, b = 0.00 },
        ["used"]    = { r = 0.50, g = 0.50, b = 0.50 },
        ["none"]    = { r = 0.25, g = 0.75, b = 0.25 },
    }
    local getn = table.getn
    
    local frames = {
        --ArtisanExpandButtonFrame,
        ArtisanFrame,
        --ArtisanFrameSearchBoxIcon,
        --ArtisanHighlightFrame,
        --ArtisanRankFrame,

    }

    local buttons = {
        --craftButton,
        --ArtisanItemTemplate,
        --ArtisanSkillButtonTemplate,
        ArtisanFrameCreateButton,
        ArtisanFrameCreateAllButton,
        --ArtisanCollapseAllButton,
        --ArtisanSkillIcon,
        --ArtisanFrameCloseButton,
        ArtisanFrameCancelButton,
        -- ArtisanFrameEditButton,
        --ArtisanSideTabTemplate,
        --ArtisanFrameInputBox,
        --ArtisanFrameInputBoxLeft,
        --ArtisanFrameInputBoxMiddle,
        --ArtisanFrameInputBoxRight,
    }

    local bars = {
        ArtisanListScrollFrameScrollBar,
        ArtisanDetailScrollFrameScrollBar,
        ArtisanEditorScrollFrameLeftScrollBar,
        ArtisanEditorScrollFrameRightScrollBar
    }

    local boxes = {
        ArtisanSortDefault,
        ArtisanSortCustom,
        ArtisanHaveReagents
    }
    
    local function ReSetToolTip()
        local _r, _g, _b, _a = pfUI.api.GetStringColor(pfUI_config.appearance.border.background)
        -- DEFAULT_CHAT_FRAME:AddMessage((_r or 0) .. "/"  .. (_g or 0) .. "/" .. (_b or 0) .. "/" .. (_a or 0))

        GameTooltip.backdrop:SetBackdropColor(_r, _g, _b, _a)
        -- GameTooltip:Hide()
        -- ResetCursor()
    end

    local function SetToolTip()
        local _r _g, _b, _a = pfUI.api.GetStringColor(pfUI_config.appearance.border.background)
        -- DEFAULT_CHAT_FRAME:AddMessage((_r or 0) .. "/"  .. (_g or 0) .. "/" .. (_b or 0) .. "/" .. (_a or 0))
        GameTooltip.backdrop:SetBackdropColor(_r, _g, _b, (_a + 0 < 0.6) and 1.0 or _a)
    end
    
    local function CollapseButton(parent, editor) --https://github.com/shagu/pfUI/blob/master/api/ui-widgets.lua#L699
        local b = getglobal(parent)
        if not b then b = parent end
        if not b then return end
        local name = b:GetName() .. "CollapseButton"

        b.icon = getglobal(name) or CreateFrame("Button", name, b)
        b.icon:SetWidth(10)
        b.icon:SetHeight(10)
        b.icon:SetPoint("LEFT", 2, 2)
        CreateBackdrop(b.icon, _, _, tooltip_alpha)
        b.icon.text = b.icon:CreateFontString(nil, "OVERLAY")
        b.icon.text:SetFontObject(GameFontWhite)
        b.icon.text:SetPoint("CENTER", -1, 0)
        -- b.icon.text:SetText(strfind(b:GetNormalTexture(), "MinusButton") and "-" or "+")
        b:SetNormalTexture(nil)
        -- if not editor then b:SetFrameLevel(b:GetFrameLevel() + 1) end
        if not editor then 
            b.icon:SetFrameLevel(b:GetFrameLevel() + 1)
            -- b:SetFrameLevel(b:GetParent():GetFrameLevel()+1)
        else
            b.icon:SetFrameLevel(b:GetFrameLevel())
        end
        -- b.icon:Show()

        b.SetNormalTexture = function(self, tex)
            if not tex or tex == "" then
              self.icon:Hide()
            else
              self.icon.text:SetText(strfind(tex, "MinusButton") and "-" or "+")
              self.icon:Show()
            end
          end
        
          local highlight = getglobal(b:GetName().."Highlight")
          if highlight then
            highlight:SetTexture("")
            highlight.SetTexture = function(self, tex) return end
          end
    end

    local function HighlightButton()
        if this:GetParent().selectedSkill ~= this:GetID() then
            if this.type ~= "header" then this.backdrop:Show() end

        -- else DEFAULT_CHAT_FRAME:AddMessage(this:GetParent().selectedSkill..":"..this:GetID().."  OnEnter")
        end
        -- DEFAULT_CHAT_FRAME:AddMessage(this:GetParent().selectedSkill..":"..this:GetID())
        -- if this:IsShown() then this.backdrop:Show() end
        -- this:SetBackdropBorderColor(this.button.cr,this.button.cg,this.button.cb,1)
    end
    local function UnHighlightButton()
        if this:GetParent().selectedSkill ~= this:GetID() then
            if this.type ~= "header" then this.backdrop:Hide() end
        -- else DEFAULT_CHAT_FRAME:AddMessage(this:GetParent().selectedSkill..":"..this:GetID().."  OnLeave")
        end
        -- if this:IsShown() then this.backdrop:Hide() end
        -- this:SetBackdropBorderColor(this.button.rr,this.button.rg,this.button.rb,1)
    end
    local function HighlightClose()
        if this.locked then return end
        local c = this:GetID()--Child(int)
        local p = this:GetParent()--Parent(obj)
        local mycolor = TypeColor[p.type]
        local t = 0
        if p.type == "header" then
            for i = c + 1, 25 do
                t = getglobal("ArtisanEditorSkillRight"..i) or 0
                if t.type == "header" then break else
                    local x = getglobal("ArtisanEditorRightDelete"..i)
                    
                    t.backdrop:SetBackdropColor(1, .25, .25, tooltip_alpha)
                    t.backdrop:Show()
                    
                    x.texture:SetVertexColor(0, .75, .75, 1)
                    x:SetBackdropColor(1, .25, .25, tooltip_alpha)
                 end
            end
        else
        end
        this.texture:SetVertexColor(0, .75, .75, 1)

        this:SetBackdropColor(1, .25, .25, tooltip_alpha)
        p.backdrop:SetBackdropColor(1, .25, .25, tooltip_alpha)
        p.backdrop:Show()
    end
    local function UnHighlightClose()
        if this.locked then return end
        local c = this:GetID()--Child(int)
        local p = this:GetParent()--Parent(obj)
        local mycolor = TypeColor[p.type]
        local t = 0
        local offset = FauxScrollFrame_GetOffset(ArtisanEditorScrollFrameRight) or 0
        if p.type == "header" then
            for i = c + 1, 25 do
                t = getglobal("ArtisanEditorSkillRight"..i) or 0
                if type(t) ~= "number" then
                    if t:IsShown() then
                        if t.type == "header" then break else
                        local othercolor = TypeColor[t.type]
                        local x = getglobal("ArtisanEditorRightDelete"..i)

                        t.backdrop:SetBackdropColor(othercolor.r, othercolor.g, othercolor.b, tooltip_alpha)
                        t.backdrop:Hide()
                        
                        x.texture:SetVertexColor(1, .25, .25, 1)
                        x:SetBackdropColor(x.r, x.g, x.g, tooltip_alpha)
                        end
                    end
                end
            end
        else
        end
        this.texture:SetVertexColor(1, .25, .25, 1)

        this:SetBackdropColor(this.r, this.g, this.b, tooltip_alpha)
        p.backdrop:SetBackdropColor(mycolor.r, mycolor.g, mycolor.b, tooltip_alpha)
        p.backdrop:Hide()
    end
    local function HighlightNext()
        if this.locked then return end
        local offset = FauxScrollFrame_GetOffset(ArtisanEditorScrollFrameRight) or 0
        local c = this:GetParent():GetID()
        local tabName = ArtisanFrame.selectedTabName
        local numSkills = getn(ARTISAN_CUSTOM[tabName])
        local strt = c
        local fin = 0
        local IsHeader = false

        if (c and c < numSkills) then
            if ARTISAN_CUSTOM[tabName][c].type ~= "header" then
                if ARTISAN_CUSTOM[tabName][c + 1].type ~= "header" then fin = c + 1 else
                    for i = 1, getn(ARTISAN_CUSTOM[tabName]) do
                        if ARTISAN_CUSTOM[tabName][i].parent then
                            if ARTISAN_CUSTOM[tabName][i].parent == c + 1 then
                                fin = c + 1
                                break
                            else
                            end 
                        else
                            if ARTISAN_CUSTOM[tabName][c + 1].type == "header" then
                                fin = c + 1
                                break
                            end
                        end
                    end
                end
            else
                IsHeader = true
                local headerBelow
                if ARTISAN_CUSTOM[tabName][c + 1].type ~= "header" then
                    
                    headerBelow = c + 1 + getn(ARTISAN_CUSTOM[tabName][c].childs)
                    fin = headerBelow
                else
                    headerBelow = c + 1
                    fin = c + 1
                end
                if ARTISAN_CUSTOM[tabName][headerBelow] and ARTISAN_CUSTOM[tabName][headerBelow].type == "header" then
                else
                    fin = 0
                end
            end
        end

        if fin > 0 then
            local color = TypeColor[ARTISAN_CUSTOM[tabName][fin].type]
            this:SetBackdropColor(color.r, color.g, color.b, 1)
            this:GetParent().backdrop:SetBackdropColor(.25, .25, 1, .8)
            this:GetParent().backdrop:Show()
        else
            this:SetBackdropColor(this.rr, this.rg, this.rb, 0)
            this:SetBackdropBorderColor(this.rr, this.rg, this.rb, 0)
            this.icon:SetVertexColor(.2, .2, .2, 0)
        end

        if strt and fin > 0 then
            if IsHeader then
                local flip = false
                for i = (c) - offset, 25 do
                    local t = getglobal("ArtisanEditorSkillRight"..i - offset) or 0
                    if type(t) ~= "number" then
                        if not t:IsShown() then t = 0 break end
                        if i > fin + getn(ARTISAN_CUSTOM[tabName][fin].childs) - offset then break end

                        local othercolor = TypeColor[t.type]


                        local u = getglobal("ArtisanEditorRightUp"..i - offset)
                        local d = getglobal("ArtisanEditorRightDown"..i - offset)
                        if i == fin then
                            flip = true
                            t:SetBackdropColor(othercolor.r, othercolor.g, othercolor.b, 1)
                        end
                        
                        if flip then u:SetBackdropColor(.75, .75, 0, 1)
                        else d:SetBackdropColor(.25, .25, 1, 1) end

                        t.backdrop:Show()
                        
                        -- t.backdrop:SetBackdropColor(othercolor.r, othercolor.g, othercolor.b, 0.25)
                        
                    end
                end
            else
                strt = strt - offset
                fin = fin - offset
                local s = getglobal("ArtisanEditorSkillRight"..strt)
                if not s:IsShown() then return
                else
                    local dn = getglobal("ArtisanEditorRightDown"..strt)
                    local clr = TypeColor[s.type]
                    s.backdrop:SetBackdropColor(.25, .25, 1, .8)
                    dn:SetBackdropColor(clr.r, clr.g, clr.b, 1)
                    -- dn:Show()

                    local f = getglobal("ArtisanEditorSkillRight"..fin) or 0
                    if type(f) == "number" then return end
                    if not f:IsShown() then return
                    else
                        local othercolor = TypeColor[f.type]
                        if f.type == "header" then
                            getglobal("ArtisanEditorRightUp"..fin):SetBackdropColor(othercolor.r, othercolor.g, othercolor.b, 1)
                            for k = fin + 1, fin + (getn(ARTISAN_CUSTOM[tabName][fin + offset].childs) ) do
                                if k > 25 then break end
                                local cr = TypeColor[ARTISAN_CUSTOM[tabName][k].type]
                                local dn = getglobal("ArtisanEditorRightDown"..k)
                                dn:SetBackdropColor(cr.r, cr.g, cr.b, 1)
                                dn:GetParent().backdrop:Show()
                            end
                        else
                            local up = getglobal("ArtisanEditorRightUp"..fin)
                            local clr = TypeColor[f.type]
                            up:SetBackdropColor(clr.r, clr.g, clr.b, 1)
                        end
                        f.backdrop:SetBackdropColor(.75, .75, 0, .8)
                        f.backdrop:Show()

                    end
                end
            end
        end
    end

    local function UnHighlightNext()
        if this.locked then return end
        local offset = FauxScrollFrame_GetOffset(ArtisanEditorScrollFrameRight) or 0
        local c = this:GetParent():GetID()
        local tabName = ArtisanFrame.selectedTabName
        local numSkills = getn(ARTISAN_CUSTOM[tabName])
        local strt = c
        local fin = 0
        local IsHeader = false

        if (c and c < numSkills) then
            if ARTISAN_CUSTOM[tabName][c].type ~= "header" then
                if ARTISAN_CUSTOM[tabName][c + 1].type ~= "header" then fin = c + 1 else
                    for i = 1, getn(ARTISAN_CUSTOM[tabName]) do
                        if ARTISAN_CUSTOM[tabName][i].parent then
                            if ARTISAN_CUSTOM[tabName][i].parent == c + 1 then
                                fin = c + 1
                                break
                            else
                            end
                        else
                            if ARTISAN_CUSTOM[tabName][c + 1].type == "header" then
                                fin = c + 1
                                break
                            end
                        end
                    end
                end
            else
                IsHeader = true
                local headerBelow
                if ARTISAN_CUSTOM[tabName][c + 1].type ~= "header" then 
                    headerBelow = c + 1 + getn(ARTISAN_CUSTOM[tabName][c].childs)
                    fin = headerBelow
                else
                    headerBelow = c + 1
                    fin = c + 1
                end
                if ARTISAN_CUSTOM[tabName][headerBelow] and ARTISAN_CUSTOM[tabName][headerBelow].type == "header" then
                else fin = 0 end
            end
        end

        if fin == 0 then
            this.icon:SetVertexColor(.8, .8, .8, 1)
            this:SetBackdropBorderColor(this.rr, this.rg, this.rb, 1)
        else
            local clor = TypeColor[this:GetParent().type]
            this:GetParent().backdrop:SetBackdropColor(this:GetParent().r, this:GetParent().g, this:GetParent().b, tooltip_alpha)

        end
        this:SetBackdropColor(this.r, this.g, this.b, tooltip_alpha)
        -- this:GetParent().backdrop:Hide()

        
        if strt and fin > 0 then
            if IsHeader then
                local flip = false
                for i = (c) - offset, 25 do
                    local t = getglobal("ArtisanEditorSkillRight"..i - offset) or 0
                    if type(t) ~= "number" then
                        if not t:IsShown() then t = 0 break end
                        if i > fin + getn(ARTISAN_CUSTOM[tabName][fin].childs) - offset then break end

                        local othercolor = TypeColor[t.type]

                        
                        local u = getglobal("ArtisanEditorRightUp"..i - offset)
                        local d = getglobal("ArtisanEditorRightDown"..i - offset)
                        if i == strt then
                            d:SetBackdropColor(d.r, d.g, d.b, tooltip_alpha)
                            t.backdrop:Hide()
                        end
                        if i == fin then
                            flip = true
                            u:SetBackdropColor(u.r, u.g, u.b, tooltip_alpha)
                        end

                        if flip then u:SetBackdropColor(u.r, u.g, u.b, tooltip_alpha)
                        else d:SetBackdropColor(d.r, d.g, d.b, tooltip_alpha) end

                        
                        t.backdrop:SetBackdropColor(othercolor.r, othercolor.g, othercolor.b, tooltip_alpha)
                        t.backdrop:Hide()
                        
                    end
                end
            else
                strt = strt - offset
                fin = fin - offset
                local s = getglobal("ArtisanEditorSkillRight"..strt)
                if type(s) == "number" then return end
                if not s:IsShown() then return
                else
                    local dn = getglobal("ArtisanEditorRightDown"..strt)
                    local clr = TypeColor[s.type]
                    dn:SetBackdropColor(dn.r, dn.g, dn.b, tooltip_alpha)
                    s.backdrop:SetBackdropColor(clr.r, clr.g, clr.b, .5) --!TODO SYNC_Variable
                    s.backdrop:Hide()

                    local f = getglobal("ArtisanEditorSkillRight"..fin) or 0
                    if type(f) == "number" then return end
                    if not f:IsShown() then return
                    else
                        if f.type == "header" then
                            getglobal("ArtisanEditorRightUp"..fin):SetBackdropColor(this.r, this.g, this.b, tooltip_alpha)
                            f.backdrop:Hide()
                            for k = fin + 1, fin + (getn(ARTISAN_CUSTOM[tabName][fin + offset].childs) ) do
                                if k > 25 then break end
                                local dn = getglobal("ArtisanEditorRightDown"..k)
                                dn:SetBackdropColor(dn.r, dn.g, dn.b, tooltip_alpha)
                                dn:GetParent().backdrop:Hide()
                            end
                        else
                            local up = getglobal("ArtisanEditorRightUp"..fin)
                            local clr = TypeColor[f.type]
                            f.backdrop:SetBackdropColor(clr.r, clr.g, clr.b, .5) --!TODO SYNC_Variable
                            f.backdrop:Hide()
                            up:SetBackdropColor(up.r, up.g, up.b, tooltip_alpha)
                        end
                    end

                end
            end
        end
    end
    
    local function HighlightPrev()
        if this.locked then return end
        local offset = FauxScrollFrame_GetOffset(ArtisanEditorScrollFrameRight) or 0
        local c = this:GetParent():GetID()
        local tabName = ArtisanFrame.selectedTabName
        local numSkills = getn(ARTISAN_CUSTOM[tabName])
        local strt = c
        local fin = 0
        local IsHeader = false

        -- local mycolor = TypeColor[p.type]
        
        if (c and c > 1) then
            if ARTISAN_CUSTOM[tabName][c - 1].type == "header" and (c-1) == 1 then fin = 0 else
                if ARTISAN_CUSTOM[tabName][c].type ~= "header" then
                    if ARTISAN_CUSTOM[tabName][c - 1].type ~= "header" then fin = c - 1 else
                        if ARTISAN_CUSTOM[tabName][c].parent == c - 1 then
                            fin = getn(ARTISAN_CUSTOM[tabName][ARTISAN_CUSTOM[tabName][c - 2].parent].childs) + ARTISAN_CUSTOM[tabName][c - 2].parent + 1
                        end
                    end
                else
                    IsHeader = true
                    if ARTISAN_CUSTOM[tabName][c - 1].type ~= "header" then
                        fin = ARTISAN_CUSTOM[tabName][c - 1].parent
                    else fin = c - 1 end
                end
            end
        end
        
        if fin > 0 then
            local color = TypeColor[ARTISAN_CUSTOM[tabName][fin].type]
            this:SetBackdropColor(color.r, color.g, color.b, 1)
            this:GetParent().backdrop:SetBackdropColor(.25, .25, 1, .8)
            this:GetParent().backdrop:Show()
        else
            this:SetBackdropColor(this.rr, this.rg, this.rb, 0)
            this:SetBackdropBorderColor(this.rr, this.rg, this.rb, 0)
            this.icon:SetVertexColor(.2, .2, .2, 0)
        end

        if strt and fin > 0 then
            if IsHeader then
                local flip = false
                for i = 25, 1, -1 do
                    local t = getglobal("ArtisanEditorSkillRight"..i) or 0
                    if type(t) ~= "number" then
                        if t:IsShown() then
                            local othercolor = TypeColor[t.type]
                            local u = getglobal("ArtisanEditorRightUp"..i)
                            local d = getglobal("ArtisanEditorRightDown"..i)
                            if t.parent == fin then
                                d:SetBackdropColor(.25, .25, 1, 1)
                                t.backdrop:Show()
                            elseif t.parent == strt then
                                u:SetBackdropColor(.75, .75, 0, 1)
                                t.backdrop:Show()
                            elseif t:GetID() == fin then
                                d:SetBackdropColor(.25, .25, 1, 1)
                                t.backdrop:SetBackdropColor(.25, .25, 1, .5)
                                t.backdrop:Show()
                            elseif t:GetID() == strt then
                                u:SetBackdropColor(.75, .75, 0, 1)
                                t.backdrop:SetBackdropColor(.75, .75, 0, .5)
                                t.backdrop:Show()
                            end
                        end
                    end
                end
            else
                strt = strt - offset
                fin = fin - offset

                local s = getglobal("ArtisanEditorSkillRight"..strt) or 0
                if type(s) ~= "number" then
                    if s:IsShown() then
                        local up = getglobal("ArtisanEditorRightUp"..strt)
                        local clr = TypeColor[s.type]
                        s.backdrop:SetBackdropColor(.75, .75, 0, .8)
                        up:SetBackdropColor(clr.r, clr.g, clr.b, 1)
                        s.backdrop:Show()

                        local f = getglobal("ArtisanEditorSkillRight"..fin) or 0
                        if type(f) ~= "number" then
                            if f:IsShown() then
                                local othercolor = TypeColor[f.type]
                                local dn = getglobal("ArtisanEditorRightDown"..fin)
                                local clr = TypeColor[f.type]
                                f.backdrop:SetBackdropColor(.25, .25, 1, .8)
                                dn:SetBackdropColor(othercolor.r, othercolor.g, othercolor.b, 1)
                                f.backdrop:Show()

                                if f.type == "header" then
                                    local prev = getglobal("ArtisanEditorSkillRight".. fin - 1 )
                                    if type(prev) ~= "number" then
                                        if prev:IsShown() then
                                            prev.backdrop:Show()
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        
    end
    
    local function UnHighlightPrev()
        if this.locked then return end
        local offset = FauxScrollFrame_GetOffset(ArtisanEditorScrollFrameRight) or 0
        local c = this:GetParent():GetID()
        local tabName = ArtisanFrame.selectedTabName
        local numSkills = getn(ARTISAN_CUSTOM[tabName])
        local strt = c
        local fin = 0
        local IsHeader = false

        local mycolor = TypeColor[this:GetParent().type]

        if (c and c > 1) then
            if ARTISAN_CUSTOM[tabName][c - 1].type == "header" and (c-1) == 1 then fin = 0 else
                if ARTISAN_CUSTOM[tabName][c].type ~= "header" then
                    if ARTISAN_CUSTOM[tabName][c - 1].type ~= "header" then fin = c - 1 else
                        if ARTISAN_CUSTOM[tabName][c].parent == c - 1 then
                            fin = getn(ARTISAN_CUSTOM[tabName][ARTISAN_CUSTOM[tabName][c - 2].parent].childs) + ARTISAN_CUSTOM[tabName][c - 2].parent + 1
                        end
                    end
                else
                    IsHeader = true
                    if ARTISAN_CUSTOM[tabName][c - 1].type ~= "header" then
                        fin = ARTISAN_CUSTOM[tabName][c - 1].parent
                    else fin = c - 1 end
                end
            end
        end

        if fin > 0 then
            local color = TypeColor[ARTISAN_CUSTOM[tabName][fin].type]
            this:SetBackdropColor(color.r, color.g, color.b, tooltip_alpha)
            this:GetParent().backdrop:SetBackdropColor(color.r, color.g, color.b, .5)
            this:GetParent().backdrop:Hide()
        else
            this:SetBackdropColor(this.r, this.g, this.b, tooltip_alpha)
            this:SetBackdropBorderColor(this.r, this.g, this.b, 1)
            this.icon:SetVertexColor(.8, .8, .8, 1)
        end

        if strt and fin > 0 then
            if strt and fin > 0 then
                if IsHeader then
                    local flip = false
                    for i = 25, 1, -1 do
                        local t = getglobal("ArtisanEditorSkillRight"..i) or 0
                        if type(t) ~= "number" then
                            if t:IsShown() then
                                local othercolor = TypeColor[t.type]
                                local u = getglobal("ArtisanEditorRightUp"..i)
                                local d = getglobal("ArtisanEditorRightDown"..i)
                                if t.parent == fin then
                                    d:SetBackdropColor(d.r, d.g, d.b, tooltip_alpha)
                                    t.backdrop:Hide()
                                elseif t.parent == strt then
                                    u:SetBackdropColor(u.r, u.g, u.b, tooltip_alpha)
                                    t.backdrop:Hide()
                                elseif t:GetID() == fin then
                                    d:SetBackdropColor(d.r, d.g, d.b, tooltip_alpha)
                                    t.backdrop:SetBackdropColor(othercolor.r, othercolor.g, othercolor.b, .5) --!TODO SYNC_Variable
                                    t.backdrop:Hide()
                                elseif t:GetID() == strt then
                                    u:SetBackdropColor(u.r, u.g, u.b, tooltip_alpha)
                                    t.backdrop:SetBackdropColor(othercolor.r, othercolor.g, othercolor.b, .5) --!TODO SYNC_Variable
                                    t.backdrop:Hide()
                                end
                                
                            end
                        end
                    end
                else
                    strt = strt - offset
                    fin = fin - offset
    
                    local s = getglobal("ArtisanEditorSkillRight"..strt) or 0
                    if type(s) ~= "number" then
                        if s:IsShown() then
                            local up = getglobal("ArtisanEditorRightUp"..strt)
                            local clr = TypeColor[s.type]
                            s.backdrop:SetBackdropColor(clr.r, clr.g, clr.b, .5)
                            up:SetBackdropColor(up.r, up.g, up.b, tooltip_alpha)
                            s.backdrop:Hide()
    
                            local f = getglobal("ArtisanEditorSkillRight"..fin) or 0
                            if type(f) ~= "number" then
                                if f:IsShown() then
                                    local othercolor = TypeColor[f.type]
                                    local dn = getglobal("ArtisanEditorRightDown"..fin)
                                    local clr = TypeColor[f.type]
                                    f.backdrop:SetBackdropColor(clr.r, clr.g, clr.b, .5)
                                    dn:SetBackdropColor(dn.r, dn.g, dn.b, tooltip_alpha)
                                    f.backdrop:Hide()

                                    if f.type == "header" then
                                        local prev = getglobal("ArtisanEditorSkillRight".. fin - 1 )
                                        if type(prev) ~= "number" then
                                            if prev:IsShown() then
                                                prev.backdrop:Hide()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            this:SetBackdropColor(this.r, this.g, this.b, tooltip_alpha)
            this:SetBackdropBorderColor(this.r, this.g, this.b, 1)
            -- this.icon:SetAlpha(0)
            this.icon:SetVertexColor(.8, .8, .8, 1)
            
            
            this:GetParent().backdrop:SetBackdropColor(mycolor.r, mycolor.g, mycolor.b, .5) --!TODO SYNC_Variable
            this:GetParent().backdrop:Hide()
        end
    end

    do --ArtisanFrame
        StripTextures(ArtisanFrame, true, "BORDER")
        StripTextures(ArtisanFrame, true, "ARTWORK")
        CreateBackdrop(ArtisanFrame)
        local f = ArtisanFrame.backdrop
        f:SetBackdropColor(f.r, f.g, f.b, tooltip_alpha)
        f:SetPoint("BOTTOMRIGHT", ArtisanFrame, "BOTTOMRIGHT", -32, 30)
        penv.CreateBackdropShadow(ArtisanFrame)
        for i = 1, 12, 1 do
            if getglobal("ArtisanFrameSkill".. i .. "CollapseButton") == nil then CollapseButton(getglobal("ArtisanFrameSkill"..i), true) end
            local b = getglobal("ArtisanFrameSkill"..i)
            b:SetScript("OnEnter", HighlightButton)
            b:SetScript("OnLeave", UnHighlightButton)
            if not b.backdrop then 
                CreateBackdrop(b)
                b.backdrop:Hide()
            end
        end

        StripTextures(ArtisanListScrollFrame, true)
        StripTextures(ArtisanDetailScrollFrame)
        
        SkinArrowButton(ArtisanFrameDecrementButton, "left") --16->12
        ArtisanFrameDecrementButton:SetBackdropColor(this.r, this.g, this.b, tooltip_alpha)
        SkinArrowButton(ArtisanFrameIncrementButton, "right") --16->12
        ArtisanFrameIncrementButton:SetBackdropColor(this.r, this.g, this.b, tooltip_alpha)
    
        StripTextures(ArtisanExpandButtonFrame)
        StripTextures(ArtisanCollapseAllButton)
        if getglobal("ArtisanCollapseAllButton" .. "CollapseButton") == nil then CollapseButton(ArtisanCollapseAllButton, true) end
    
        StripTextures(ArtisanRankFrameBorder)
        ArtisanRankFrame:SetPoint("TOPLEFT", ArtisanFrame, "TOPLEFT", 74.5, -16)
        ArtisanRankFrame:SetWidth(254)
        
    
        StripTextures(ArtisanFrameSearchBox, false, "BACKGROUND")
        ArtisanFrameSearchBox:SetHeight(20)
        CreateBackdrop(ArtisanFrameSearchBox, _, _, tooltip_alpha)
    
        StripTextures(ArtisanFrameInputBox, false, "BACKGROUND")
        ArtisanFrameInputBox:SetWidth(25)
        ArtisanFrameInputBox:SetPoint("TOPLEFT", ArtisanFrameDecrementButton, "TOPRIGHT", 4, -1)
        CreateBackdrop(ArtisanFrameInputBox, _, _, tooltip_alpha)
    
        ArtisanFrameCreateButton:SetWidth(76)
    
        StripTextures(ArtisanFrameCloseButton)
        SkinCloseButton(ArtisanFrameCloseButton)
        ArtisanFrameCloseButton:SetPoint("BOTTOMRIGHT", ArtisanFrameSearchBox, "TOPRIGHT", 0, 3)
        HookScript(getglobal("ArtisanFrameCloseButton"), "OnEnter", function() 
            ArtisanFrameCloseButton:SetBackdropColor(1, .25, .25, tooltip_alpha)
            ArtisanFrameCloseButton.texture:SetVertexColor(0, .75, .75, tooltip_alpha)
        end)
        HookScript(getglobal("ArtisanFrameCloseButton"), "OnLeave", function() 
            ArtisanFrameCloseButton:SetBackdropColor(this.r, this.g, this.b, tooltip_alpha)
            ArtisanFrameCloseButton.texture:SetVertexColor(1, .25, .25, tooltip_alpha)
        end)
    
        StripTextures(ArtisanFrameEditButton, true)
        SkinButton(ArtisanFrameEditButton)
        ArtisanFrameEditButton:SetBackdropColor(this.r, this.g, this.b, tooltip_alpha)
        ArtisanFrameEditButton:SetHeight(24)
        ArtisanFrameEditButton:SetPoint("TOPRIGHT", ArtisanFrameSearchBox, "BOTTOMRIGHT", -4, 0)
    
        StripTextures(ArtisanDetailScrollChildFrame, true)
        -- SkinButton(ArtisanSkillIcon)
    
        ArtisanFrameCancelButton:GetNormalTexture():SetTexture(0.8,0.1,0.1,0.75)
        ArtisanFrameCancelButton:GetHighlightTexture():SetTexture(1,.1,.1,1)


        
        for i = 1, 7, 1 do
            local b = getglobal("ArtisanFrameSideTab"..i)
            StripTextures(b)
            b:GetNormalTexture():SetTexture(1, 1, 1,0.25)
            b:GetCheckedTexture():SetTexture(1, 1, 1, 0.45)
            b:GetHighlightTexture():SetTexture(1, 1, 1, 0.25)
            if i == 1 then b:SetPoint("TOPLEFT", ArtisanFrameEditButton, "BOTTOMRIGHT", 4, 0)
            else b:SetPoint("TOPLEFT", "ArtisanFrameSideTab"..i - 1, 0, -48)
            end
            StripTextures(getglobal("ArtisanReagent"..i))
            HookScript(getglobal("ArtisanReagent"..i), "OnEnter", SetToolTip)
            HookScript(getglobal("ArtisanReagent"..i), "OnLeave", ReSetToolTip)
            -- SkinButton(getglobal("ArtisanReagent"..i))
            if i == 7 then 
                StripTextures(getglobal("ArtisanReagent"..i + 1))
                HookScript(getglobal("ArtisanReagent"..i + 1), "OnEnter", SetToolTip)
                HookScript(getglobal("ArtisanReagent"..i + 1), "OnLeave", ReSetToolTip)
                -- SkinButton(getglobal("ArtisanReagent"..i + 1))
            end
            -- SkinButton(getglobal("ArtisanFrameSideTab"..i), 1, 1, 1)
        end
        HookScript(getglobal("ArtisanSkillIcon"), "OnEnter", SetToolTip)
        HookScript(getglobal("ArtisanSkillIcon"), "OnLeave", ReSetToolTip)
    end
    
    for _, button in pairs(buttons) do
        StripTextures(button)
        SkinButton(button, _, _, tooltip_alpha)
        button:SetBackdropColor(button.r, button.g, button.b, tooltip_alpha)
    end
    ArtisanFrameCancelButton:SetBackdropColor(1, .25, .25, tooltip_alpha)
    -- ArtisanFrameCancelButton:SetTextColor(0, 1, 1)

    for _, bar in pairs(bars) do
        StripTextures(bar)
        SkinScrollbar(bar)
        bar.bg:SetBackdropColor(this.r, this.g, this.b, tooltip_alpha)
        local u = getglobal(bar:GetName() .. "ScrollUpButton") or 0
        if type(u) ~= "number" then u:SetBackdropColor(this.r, this.g, this.b, tooltip_alpha) end
        local d = getglobal(bar:GetName() .. "ScrollDownButton") or 0
        if type(d) ~= "number" then d:SetBackdropColor(this.r, this.g, this.b, tooltip_alpha) end
    end

    for _, box in pairs(boxes) do
        SkinCheckbox(box)
        box.backdrop:SetBackdropColor(this.r, this.g, this.b, tooltip_alpha)
    end
    
    hooksecurefunc("ArtisanFrame_Update", function()
        if not ArtisanFrame:IsShown() then return end


        for i = 1, 7, 1 do
            local b = getglobal("ArtisanFrameSideTab"..i)
            if b:GetChecked() then b:GetHighlightTexture():SetTexture(1,1,1,0)
            else b:GetHighlightTexture():SetTexture(1, 1, 1, 0.25)
            end
        end

        for i = 1, 12, 1 do
            local b = getglobal("ArtisanFrameSkill"..i)
            if b:IsShown() then
                local color = TypeColor[b.type] or {0, 0, 0}
                b.backdrop:SetBackdropColor(color.r, color.g, color.b, 0.25)
                b.backdrop:SetBackdropBorderColor(color.r, color.g, color.b , 1)
                if MouseIsOver(b) and b.type ~= "header" then b.backdrop:Show() else b.backdrop:Hide() end
            end
        end

        if ArtisanFrameEditButton:IsVisible() then
            if ArtisanEditor:IsVisible() then
                ArtisanFrameEditButton:SetBackdropColor(1, 0.75,  0.125, tooltip_alpha)
                ArtisanFrameEditButton:SetTextColor(0, 1, 1)
            else
                ArtisanFrameEditButton:SetBackdropColor(ArtisanFrameEditButton.r, ArtisanFrameEditButton.g, ArtisanFrameEditButton.b, tooltip_alpha)
                ArtisanFrameEditButton:SetTextColor(1, 0.8, 0)
            end
        end

        penv.EnableMovable(ArtisanFrame)
    end, true)

    do --ArtisanEditor
        StripTextures(ArtisanEditor)
        CreateBackdrop(ArtisanEditor, _, _, tooltip_alpha)
        penv.CreateBackdropShadow(ArtisanEditor)
        for i = 1, 25, 1 do
            if getglobal("ArtisanEditorSkillRight"..i.."CollapseButton") == nil then CollapseButton("ArtisanEditorSkillRight"..i, true) end
            SkinArrowButton(getglobal("ArtisanEditorRightUp"..i), "up")
            getglobal("ArtisanEditorRightUp"..i):SetFrameLevel(getglobal("ArtisanEditorRightUp"..i):GetParent():GetFrameLevel()+1)
            getglobal("ArtisanEditorRightUp"..i):SetBackdropColor(this.r, this.g, this.b, tooltip_alpha)
            SkinArrowButton(getglobal("ArtisanEditorRightDown"..i), "down")
            getglobal("ArtisanEditorRightDown"..i):SetFrameLevel(getglobal("ArtisanEditorRightDown"..i):GetParent():GetFrameLevel()+1)
            getglobal("ArtisanEditorRightDown"..i):SetBackdropColor(this.r, this.g, this.b, tooltip_alpha)
            StripTextures(getglobal("ArtisanEditorRightDelete"..i))
            SkinCloseButton(getglobal("ArtisanEditorRightDelete"..i))
            getglobal("ArtisanEditorRightDelete"..i):SetFrameLevel(getglobal("ArtisanEditorRightDelete"..i):GetParent():GetFrameLevel()+1)
            getglobal("ArtisanEditorRightDelete"..i):SetBackdropColor(this.r, this.g, this.b, tooltip_alpha)

            local b = getglobal("ArtisanEditorSkillLeft"..i)
            b:SetScript("OnEnter", HighlightButton)
            b:SetScript("OnLeave", UnHighlightButton)
            if not b.backdrop then 
                CreateBackdrop(b)
                b.backdrop:Hide()
            end

            local t = getglobal("ArtisanEditorSkillRight"..i)
            t:SetScript("OnEnter", HighlightButton)
            t:SetScript("OnLeave", UnHighlightButton)
            if not t.backdrop then 
                CreateBackdrop(t)
                t.backdrop:Hide()
            end

            getglobal("ArtisanEditorSkillRight"..i.."Background"):SetTexture(.15,.8,.8,.15)

            getglobal("ArtisanEditorRightDown"..i):SetScript("OnEnter", HighlightNext)
            getglobal("ArtisanEditorRightDown"..i):SetScript("OnLeave", UnHighlightNext)

            getglobal("ArtisanEditorRightUp"..i):SetScript("OnEnter", HighlightPrev)
            getglobal("ArtisanEditorRightUp"..i):SetScript("OnLeave", UnHighlightPrev)

            getglobal("ArtisanEditorRightDelete"..i):SetScript("OnEnter", HighlightClose)
            getglobal("ArtisanEditorRightDelete"..i):SetScript("OnLeave", UnHighlightClose)
            
            getglobal("ArtisanEditorRightUp"..i):SetFrameLevel(getglobal("ArtisanEditorRightUp"..i):GetParent():GetFrameLevel() + 1)
            getglobal("ArtisanEditorRightDown"..i):SetFrameLevel(getglobal("ArtisanEditorRightDown"..i):GetParent():GetFrameLevel() + 1)


            
        end

        StripTextures(ArtisanEditorSearchBox, false, "BACKGROUND")
        CreateBackdrop(ArtisanEditorSearchBox, _, _, tooltip_alpha)
        ArtisanEditorSearchBox:SetHeight(20)

        StripTextures(ArtisanEditorAddCategory, true)
        SkinButton(ArtisanEditorAddCategory)
        ArtisanEditorAddCategory:SetBackdropColor(this.r, this.g, this.b, tooltip_alpha)
        
        StripTextures(ArtisanEditorRenameCategory, true)
        SkinButton(ArtisanEditorRenameCategory)
        ArtisanEditorRenameCategory:SetBackdropColor(this.r, this.g, this.b, tooltip_alpha)
        
    end
    

    hooksecurefunc("ArtisanEditButton_OnClick", function()
        if ArtisanEditor:IsVisible() then
            ArtisanFrameEditButton:SetBackdropColor(1, 0.75,  0.125, tooltip_alpha)
            ArtisanFrameEditButton:SetTextColor(0, 1, 1)
        else
            ArtisanFrameEditButton:SetBackdropColor(ArtisanFrameEditButton.r, ArtisanFrameEditButton.g, ArtisanFrameEditButton.b, tooltip_alpha)
            ArtisanFrameEditButton:SetTextColor(1, 0.8, 0)
        end
    end, true)
    
    hooksecurefunc("ArtisanEditorLeft_Update", function()
        for i = 1, 25, 1 do
            local b = getglobal("ArtisanEditorSkillLeft"..i)
            if b:IsShown() then
                local color = TypeColor[b.type]
                b.backdrop:SetBackdropColor(color.r, color.g, color.b, 0.25)
                b.backdrop:SetBackdropBorderColor(color.r, color.g, color.b , 1)
            end
        end
    end, true)

    hooksecurefunc("ArtisanEditorRight_Update", function()
        local offset = FauxScrollFrame_GetOffset(ArtisanEditorScrollFrameRight) or 0
        local c = 0
        local tabName = ArtisanFrame.selectedTabName
        local numSkills = getn(ARTISAN_CUSTOM[tabName])
        local strt = 0
        local fin = 0
        local IsHeader = false

        for i = 1, 25, 1 do
            local row = getglobal("ArtisanEditorSkillRight"..i) or 0
            local up = getglobal("ArtisanEditorRightUp"..i)
            local dwn = getglobal("ArtisanEditorRightDown"..i)
            local del = getglobal("ArtisanEditorRightDelete"..i)
            local mycolor = TypeColor[row.type]

            
            if row:IsShown() then
                row.backdrop:SetBackdropColor(mycolor.r, mycolor.g, mycolor.b, .5)
                row.backdrop:SetBackdropBorderColor(mycolor.r, mycolor.g, mycolor.b , 1)

                dwn:SetBackdropColor(dwn.r, dwn.g, dwn.b, tooltip_alpha)
                dwn.icon:SetVertexColor(.8, .8, .8, 1)
                up:SetBackdropColor(up.r, up.g, up.b, tooltip_alpha)
                up.icon:SetVertexColor(.8, .8, .8, 1)
                del:SetBackdropColor(del.r, del.g, del.b, tooltip_alpha)
                del.texture:SetVertexColor(1, .25, .25, 1)
                row.backdrop:Hide()
                -- if not MouseIsOver(row) then row.backdrop:Hide() end
            end
        end

        for i = 1, 25 do
            local row = getglobal("ArtisanEditorSkillRight"..i) or 0
            local up = getglobal("ArtisanEditorRightUp"..i)
            local dwn = getglobal("ArtisanEditorRightDown"..i)
            local del = getglobal("ArtisanEditorRightDelete"..i)

            if row:IsShown() then
                --!! FIXME !! FIXME !! FIXME !!
                if MouseIsOver(up) then 
                    c = dwn:GetID() + offset
                    strt = c
                    if (c and c > 1) then
                        if ARTISAN_CUSTOM[tabName][c - 1].type == "header" and (c-1) == 1 then fin = 0 else
                            if ARTISAN_CUSTOM[tabName][c].type ~= "header" then
                                if ARTISAN_CUSTOM[tabName][c - 1].type ~= "header" then fin = c - 1 else
                                    if ARTISAN_CUSTOM[tabName][c].parent == c - 1 then
                                        fin = getn(ARTISAN_CUSTOM[tabName][ARTISAN_CUSTOM[tabName][c - 2].parent].childs) + ARTISAN_CUSTOM[tabName][c - 2].parent + 1
                                    end
                                end
                            else
                                IsHeader = true
                                if ARTISAN_CUSTOM[tabName][c - 1].type ~= "header" then
                                    fin = ARTISAN_CUSTOM[tabName][c - 1].parent
                                else fin = c - 1 end
                            end
                        end
                    end
                    if fin > 0 then
                        local color = TypeColor[ARTISAN_CUSTOM[tabName][fin].type]
                        up:SetBackdropColor(color.r, color.g, color.b, 1)
                        up:GetParent().backdrop:SetBackdropColor(.25, .25, 1, .8)
                        up:GetParent().backdrop:Show()
                    else
                        up:SetBackdropColor(up.rr, up.rg, up.rb, 0)
                        up:SetBackdropBorderColor(up.rr, up.rg, up.rb, 0)
                        up.icon:SetVertexColor(.2, .2, .2, 0)
                    end
            
                    if strt and fin > 0 then
                        if IsHeader then
                            local flip = false
                            for i = 25, 1, -1 do
                                local t = getglobal("ArtisanEditorSkillRight"..i) or 0
                                if type(t) ~= "number" then
                                    if t:IsShown() then
                                        local othercolor = TypeColor[t.type]
                                        local u = getglobal("ArtisanEditorRightUp"..i)
                                        local d = getglobal("ArtisanEditorRightDown"..i)
                                        if t.parent == fin then
                                            d:SetBackdropColor(.25, .25, 1, 1)
                                            t.backdrop:Show()
                                        elseif t.parent == strt then
                                            u:SetBackdropColor(.75, .75, 0, 1)
                                            t.backdrop:Show()
                                        elseif t:GetID() == fin then
                                            d:SetBackdropColor(.25, .25, 1, 1)
                                            t.backdrop:SetBackdropColor(.25, .25, 1, .5)
                                            t.backdrop:Show()
                                        elseif t:GetID() == strt then
                                            u:SetBackdropColor(.75, .75, 0, 1)
                                            t.backdrop:SetBackdropColor(.75, .75, 0, .5)
                                            t.backdrop:Show()
                                        end
                                    end
                                end
                            end
                        else
                            strt = strt - offset
                            fin = fin - offset
            
                            local s = getglobal("ArtisanEditorSkillRight"..strt) or 0
                            if type(s) ~= "number" then
                                if s:IsShown() then
                                    local up = getglobal("ArtisanEditorRightUp"..strt)
                                    local clr = TypeColor[s.type]
                                    s.backdrop:SetBackdropColor(.75, .75, 0, .8)
                                    up:SetBackdropColor(clr.r, clr.g, clr.b, 1)
                                    s.backdrop:Show()
            
                                    local f = getglobal("ArtisanEditorSkillRight"..fin) or 0
                                    if type(f) ~= "number" then
                                        if f:IsShown() then
                                            local othercolor = TypeColor[f.type]
                                            local dn = getglobal("ArtisanEditorRightDown"..fin)
                                            local clr = TypeColor[f.type]
                                            f.backdrop:SetBackdropColor(.25, .25, 1, .8)
                                            dn:SetBackdropColor(othercolor.r, othercolor.g, othercolor.b, 1)
                                            f.backdrop:Show()
            
                                            if f.type == "header" then
                                                local prev = getglobal("ArtisanEditorSkillRight".. fin - 1 )
                                                if type(prev) ~= "number" then
                                                    if prev:IsShown() then
                                                        prev.backdrop:Show()
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                elseif MouseIsOver(dwn) then
                    c = dwn:GetID() + offset
                    strt = c
                    if (c and c < numSkills) then
                        if ARTISAN_CUSTOM[tabName][c].type ~= "header" then
                            if ARTISAN_CUSTOM[tabName][c + 1].type ~= "header" then fin = c + 1 else
                                for i = 1, getn(ARTISAN_CUSTOM[tabName]) do
                                    if ARTISAN_CUSTOM[tabName][i].parent then
                                        if ARTISAN_CUSTOM[tabName][i].parent == c + 1 then
                                            fin = c + 1
                                            break
                                        else
                                        end
                                    else
                                        if ARTISAN_CUSTOM[tabName][c + 1].type == "header" then
                                            fin = c + 1
                                            break
                                        end
                                    end 
                                end
                            end
                        else
                            IsHeader = true
                            local headerBelow
                            if ARTISAN_CUSTOM[tabName][c + 1].type ~= "header" then
                                headerBelow = c + 1 + getn(ARTISAN_CUSTOM[tabName][c].childs)
                                fin = headerBelow
                            else
                                headerBelow = c + 1
                                fin = c + 1
                            end
                            if ARTISAN_CUSTOM[tabName][headerBelow] and ARTISAN_CUSTOM[tabName][headerBelow].type == "header" then
                            else fin = 0 end
                        end
                    end

                    if fin > 0 then
                        local color = TypeColor[ARTISAN_CUSTOM[tabName][fin].type]
                        dwn:SetBackdropColor(color.r, color.g, color.b, 1)
                        dwn:GetParent().backdrop:SetBackdropColor(.25, .25, 1, .8)
                        dwn:GetParent().backdrop:Show()
                    else
                        dwn:SetBackdropColor(this.rr, this.rg, this.rb, 0)
                        dwn:SetBackdropBorderColor(this.rr, this.rg, this.rb, 0)
                        dwn.icon:SetVertexColor(.2, .2, .2, 0)
                        dwn:GetParent().backdrop:Hide()
                    end
            
                    if strt and fin > 0 then
                        if IsHeader then
                            local flip = false
                            for i = (c) - offset, 25 do
                                local t = getglobal("ArtisanEditorSkillRight"..i - offset) or 0
                                if type(t) ~= "number" then
                                    if not t:IsShown() then t = 0 break end
                                    if i > fin + getn(ARTISAN_CUSTOM[tabName][fin].childs) - offset then break end
            
                                    local othercolor = TypeColor[t.type]
            
            
                                    local u = getglobal("ArtisanEditorRightUp"..i - offset)
                                    local d = getglobal("ArtisanEditorRightDown"..i - offset)
                                    if i == fin then
                                        flip = true
                                        t:SetBackdropColor(othercolor.r, othercolor.g, othercolor.b, 1)
                                    end
                                    
                                    if flip then u:SetBackdropColor(.75, .75, 0, 1)
                                    else d:SetBackdropColor(.25, .25, 1, 1) end
            
                                    t.backdrop:Show()
                                    
                                    -- t.backdrop:SetBackdropColor(othercolor.r, othercolor.g, othercolor.b, 0.25)
                                    
                                end
                            end
                        else
                            strt = strt - offset
                            fin = fin - offset
                            local s = getglobal("ArtisanEditorSkillRight"..strt)
                            if not s:IsShown() then return
                            else
                                local dn = getglobal("ArtisanEditorRightDown"..strt)
                                local clr = TypeColor[s.type]
                                s.backdrop:SetBackdropColor(.25, .25, 1, .8)
                                dn:SetBackdropColor(clr.r, clr.g, clr.b, 1)
                                -- dn:Show()
            
                                local f = getglobal("ArtisanEditorSkillRight"..fin) or 0
                                if type(f) == "number" then return end
                                if not f:IsShown() then return
                                else
                                    local othercolor = TypeColor[f.type]
                                    if f.type == "header" then
                                        getglobal("ArtisanEditorRightUp"..fin):SetBackdropColor(othercolor.r, othercolor.g, othercolor.b, 1)
                                        for k = fin + 1, fin + (getn(ARTISAN_CUSTOM[tabName][fin + offset].childs) ) do
                                            if k > 25 then break end
                                            local cr = TypeColor[ARTISAN_CUSTOM[tabName][k].type]
                                            local dn = getglobal("ArtisanEditorRightDown"..k)
                                            dn:SetBackdropColor(cr.r, cr.g, cr.b, 1)
                                            dn:GetParent().backdrop:Show()
                                        end
                                    else
                                        local up = getglobal("ArtisanEditorRightUp"..fin)
                                        local clr = TypeColor[f.type]
                                        f.backdrop:SetBackdropColor(.75, .75, 0, .8)
                                        f.backdrop:Show()
                                        up:SetBackdropColor(clr.r, clr.g, clr.b, 1)
                                    end
                                end
                            end
                        end
                    end
                elseif MouseIsOver(del) then
                    c = del:GetID() + offset
                    strt = c
                    local target = getglobal("ArtisanEditorRightDelete"..c - offset)
                    local mycolor = TypeColor[target:GetParent().type]
                    local t = 0
                    if target:GetParent().type == "header" then
                        for i = (c - offset) + 1, 25 do
                            t = getglobal("ArtisanEditorSkillRight"..i) or 0
                            if t.type == "header" then break else
                                local x = getglobal("ArtisanEditorRightDelete"..i)
                                
                                t.backdrop:SetBackdropColor(1, .25, .25, tooltip_alpha)
                                t.backdrop:Show()
                                
                                x.texture:SetVertexColor(0, .75, .75, 1)
                                x:SetBackdropColor(1, .25, .25, tooltip_alpha)
                            end
                        end
                    else

                    end
                    target.texture:SetVertexColor(0, .75, .75, 1)

                    target:SetBackdropColor(1, .25, .25, tooltip_alpha)
                    target:GetParent().backdrop:SetBackdropColor(1, .25, .25, tooltip_alpha)
                    target:GetParent().backdrop:Show()
                end
                --!! FIXME !! FIXME !! FIXME !!
            else end
        end
    end, true)

    hooksecurefunc("ArtisanSkillIcon_OnEnter", function()
        DEFAULT_CHAT_FRAME:AddMessage("ArtisanSkillIcon_OnEnter")
    end, true)

    -- remove from pending list when applied
    pfUI.addonskinner:UnregisterSkin("Artisan")
  end)