pfUI.addonskinner:RegisterSkin("simpleAuras", function()
  local font = pfUI_config.global.font_default
  
  local function SkinSimpleAuraFrame(frame)
    if not frame then return end
    
    pfUI.api.CreateBackdrop(frame)
    
    if frame.texture then
      frame.texture:SetTexCoord(.08, .92, .08, .92)
    end
    
    if frame.durationtext then
      local _, size = frame.durationtext:GetFont()
      size = size or 12
      frame.durationtext:SetFont(font, size, "OUTLINE")
    end
    
    if frame.stackstext then
      local _, size = frame.stackstext:GetFont()
      size = size or 10
      frame.stackstext:SetFont(font, size, "OUTLINE")
    end
  end
  
  -- Hook the CreateAuraFrame function to skin frames when they're created
  if sA then
    local originalCreateAuraFrame = CreateAuraFrame
    local originalCreateDualFrame = CreateDualFrame
    
    -- Override global CreateAuraFrame function
    _G.CreateAuraFrame = function(id)
      local frame = originalCreateAuraFrame(id)
      SkinSimpleAuraFrame(frame)
      return frame
    end
    
    -- Override global CreateDualFrame function
    _G.CreateDualFrame = function(id)
      local frame = originalCreateDualFrame(id)
      SkinSimpleAuraFrame(frame)
      return frame
    end
    
    -- Skin any existing frames
    if sA.frames then
      for id, frame in pairs(sA.frames) do
        SkinSimpleAuraFrame(frame)
      end
    end
    
    -- Skin dual frames
    if sA.dualframes then
      for id, frame in pairs(sA.dualframes) do
        SkinSimpleAuraFrame(frame)
      end
    end
    
    -- Skin test frames
    if sA.TestAura then
      SkinSimpleAuraFrame(sA.TestAura)
    end
    
    if sA.TestAuraDual then
      SkinSimpleAuraFrame(sA.TestAuraDual)
    end
    
    -- Hook CreateTestAuras to skin test frames when they're created
    if sA.CreateTestAuras then
      local original_CreateTestAuras = sA.CreateTestAuras
      sA.CreateTestAuras = function(self)
        original_CreateTestAuras(self)
        
        if self.TestAura then
          SkinSimpleAuraFrame(self.TestAura)
        end
        
        if self.TestAuraDual then
          SkinSimpleAuraFrame(self.TestAuraDual)
        end
      end
    end
    
    -- Hook UpdateAuras to ensure fonts stay correct and skin any new frames
    if sA.UpdateAuras then
      local original_UpdateAuras = sA.UpdateAuras
      sA.UpdateAuras = function(self)
        original_UpdateAuras(self)
        
        if self.frames then
          for id, frame in pairs(self.frames) do
            if frame and frame:IsShown() then
              if not frame.backdrop then
                pfUI.api.CreateBackdrop(frame)
              end
              
              if frame.texture then
                frame.texture:SetTexCoord(.08, .92, .08, .92)
              end
              
              local aura = simpleAuras and simpleAuras.auras and simpleAuras.auras[id]
              if aura then
                local scale = aura.scale or 1
                local textscale = scale
                
                if frame.durationtext and aura.duration == 1 then
                  frame.durationtext:SetFont(font, 20 * textscale, "OUTLINE")
                end
                
                if frame.stackstext and aura.stacks == 1 then
                  frame.stackstext:SetFont(font, 14 * scale, "OUTLINE")
                end
              end
            end
          end
        end
        
        -- Also apply to dual frames
        if self.dualframes then
          for id, frame in pairs(self.dualframes) do
            if frame and frame:IsShown() then
              if not frame.backdrop then
                pfUI.api.CreateBackdrop(frame)
              end
              
              if frame.texture then
                frame.texture:SetTexCoord(1, 0, 0, 1)
              end
              
              local aura = simpleAuras and simpleAuras.auras and simpleAuras.auras[id]
              if aura then
                local scale = aura.scale or 1
                
                if frame.durationtext and aura.duration == 1 then
                  frame.durationtext:SetFont(font, 20 * scale, "OUTLINE")
                end
                
                if frame.stackstext and aura.stacks == 1 then
                  frame.stackstext:SetFont(font, 14 * scale, "OUTLINE")
                end
              end
            end
          end
        end
      end
    end
    
    -- Hook EditAura to ensure test frames use pfUI font and skin
    if sA.EditAura then
      local original_EditAura = sA.EditAura
      sA.EditAura = function(self, id)
        original_EditAura(self, id)
        
        if self.TestAura and self.TestAura:IsShown() then
          SkinSimpleAuraFrame(self.TestAura)
          
          local aura = simpleAuras and simpleAuras.auras and simpleAuras.auras[id]
          if aura then
            local scale = aura.scale or 1
            if aura.duration == 1 and self.TestAura.durationtext then
              self.TestAura.durationtext:SetFont(font, 20 * scale, "OUTLINE")
            end
            if aura.stacks == 1 and self.TestAura.stackstext then
              self.TestAura.stackstext:SetFont(font, 14 * scale, "OUTLINE")
            end
          end
        end
        
        if self.TestAuraDual and self.TestAuraDual:IsShown() then
          SkinSimpleAuraFrame(self.TestAuraDual)
          
          local aura = simpleAuras and simpleAuras.auras and simpleAuras.auras[id]
          if aura then
            local scale = aura.scale or 1
            if aura.duration == 1 and self.TestAuraDual.durationtext then
              self.TestAuraDual.durationtext:SetFont(font, 20 * scale, "OUTLINE")
            end
            if aura.stacks == 1 and self.TestAuraDual.stackstext then
              self.TestAuraDual.stackstext:SetFont(font, 14 * scale, "OUTLINE")
            end
          end
        end
      end
    end
  end

  pfUI.addonskinner:UnregisterSkin("simpleAuras")
end)