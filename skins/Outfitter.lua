pfUI.addonskinner:RegisterSkin("Outfitter", function()
  local penv = pfUI:GetEnvironment()
  local StripTextures, CreateBackdrop = penv.StripTextures, penv.CreateBackdrop

  local Skin = function()
    StripTextures(OutfitterCurrentOutfit, true, "BACKGROUND")
    CreateBackdrop(OutfitterCurrentOutfit, nil, true, .75)
    -- OutfitterCurrentOutfit:SetHeight(20)
  end

  if not OutfitterCurrentOutfit then
    local orig_Outfitter_PEW = Outfitter_PlayerEnteringWorld

    Outfitter_PlayerEnteringWorld = function(self, event)
      orig_Outfitter_PEW(self, event)
      Skin()
    end
  else
    Skin()
  end 

  pfUI.addonskinner:UnregisterSkin("Outfitter")
end)