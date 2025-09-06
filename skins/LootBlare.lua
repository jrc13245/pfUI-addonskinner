pfUI.addonskinner:RegisterSkin("LootBlare", function()
    -- place main code below
    local penv = pfUI:GetEnvironment()

    local StripTextures, CreateBackdrop, SkinCloseButton, HookScript, GetStringColor = 
  penv.StripTextures, penv.CreateBackdrop, penv.SkinCloseButton, penv.HookScript, penv.GetStringColor
  local _r, _g, _b, _a = GetStringColor(pfUI_config.appearance.border.background)
  _r = tonumber(_r) _g = tonumber(_g) _b = tonumber(_b) _a = tonumber(_a)

  local function HookButton(b, type)
    
  end
  
  do
    StripTextures(ItemRollFrame)
    CreateBackdrop(ItemRollFrame)
    -- SkinCloseButton(itemRollFrameButton)
    local cb = penv.GetNoNameObject(ItemRollFrame, 'Button', nil, "UI-Panel-MinimizeButton-Up")
    StripTextures(cb)
    SkinCloseButton(cb)
  end

  HookScript(ItemRollFrame, "OnShow", function()
      HookScript(ItemRollFrame, "OnUpdate", function()
        local icon = ItemRollFrame.iconButton
        if icon then
          icon:SetScript("OnEnter", function()
            GameTooltip.backdrop:SetBackdropColor(_r, _g, _b, (_a + 0) > 0.8 and _a or 1.0)
            GameTooltip:SetOwner(icon, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(ItemRollFrame.itemLink)
            GameTooltip:Show()

          end)
          icon:SetScript("OnLeave", function()
            GameTooltip.backdrop:SetBackdropColor(_r, _g, _b, _a)
            GameTooltip:Hide()
            ShoppingTooltip1:Hide()
            ShoppingTooltip2:Hide()
          end)
        end
      end)

      for _, btn in pairs({ItemRollFrame:GetChildren()}) do
        if btn:GetObjectType() ~= "Button" then return end
        local text = btn:GetText()
        if text == "SR" then
          for _, v in ipairs({btn:GetRegions()}) do--TODO Function()
            if v.SetTexture then
              local bg = v
              if v:GetDrawLayer() == "BACKGROUND" then
                v:SetVertexColor(.75,0,0,1)
                btn:SetScript("OnMouseDown", function()
                  bg:SetVertexColor(1,1,1,1)
                end)
                btn:SetScript("OnMouseUp", function()
                  bg:SetVertexColor(0,0,0,1)
                end)
                btn:SetScript("OnEnter", function()
                  bg:SetVertexColor(1,0,0,1)
                end)
                btn:SetScript("OnLeave", function()
                  bg:SetVertexColor(.75,0,0,1)
                end)
                btn:SetHeight(24)
              end
            end
          end
        elseif text == "MS" then 
          for _, v in ipairs({btn:GetRegions()}) do--TODO Function()
            if v.SetTexture then
              local bg = v
              if v:GetDrawLayer() == "BACKGROUND" then
                v:SetVertexColor(.75,.75,0,1)
                btn:SetScript("OnMouseDown", function()
                  bg:SetVertexColor(1,1,1,1)
                end)
                btn:SetScript("OnMouseUp", function()
                  bg:SetVertexColor(0,0,0,1)
                end)
                btn:SetScript("OnEnter", function()
                  bg:SetVertexColor(1,1,0,1)
                end)
                btn:SetScript("OnLeave", function()
                  bg:SetVertexColor(.75,.75,0,1)
                end)
                btn:SetHeight(24)
              end
            end
          end
        elseif text == "OS" then
          for _, v in ipairs({btn:GetRegions()}) do--TODO Function()
            if v.SetTexture then
              local bg = v
              if v:GetDrawLayer() == "BACKGROUND" then
                v:SetVertexColor(0,.75,0,1)
                btn:SetScript("OnMouseDown", function()
                  bg:SetVertexColor(1,1,1,1)
                end)
                btn:SetScript("OnMouseUp", function()
                  bg:SetVertexColor(0,0,0,1)
                end)
                btn:SetScript("OnEnter", function()
                  bg:SetVertexColor(0,1,0,1)
                end)
                btn:SetScript("OnLeave", function()
                  bg:SetVertexColor(0,.75,0,1)
                end)
                btn:SetHeight(24)
              end
            end
          end
        elseif text == "TM" then
          for _, v in ipairs({btn:GetRegions()}) do--TODO Function()
            if v.SetTexture then
              local bg = v
              if v:GetDrawLayer() == "BACKGROUND" then
                v:SetVertexColor(0,.75,.75,1)
                btn:SetScript("OnMouseDown", function()
                  bg:SetVertexColor(1,1,1,1)
                end)
                btn:SetScript("OnMouseUp", function()
                  bg:SetVertexColor(0,0,0,1)
                end)
                btn:SetScript("OnEnter", function()
                  bg:SetVertexColor(0,1,1,1)
                end)
                btn:SetScript("OnLeave", function()
                  bg:SetVertexColor(0,.75,.75,1)
                end)
                btn:SetHeight(24)
              end
            end
          end
        end
      end
  end)

  -- HookScript(CustomTooltip2, "OnShow", pfUI.eqcompare.GameTooltipShow)

    -- remove from pending list when applied
    pfUI.addonskinner:UnregisterSkin("LootBlare")
  end)