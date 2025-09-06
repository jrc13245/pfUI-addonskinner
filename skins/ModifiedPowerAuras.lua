pfUI.addonskinner:RegisterSkin("ModifiedPowerAuras", function()
  -- place main code below

  -- local font = pfUI_config.global.font_combat

  for i=1, MPOWA.NumBuffs do
    -- skin aura button
    pfUI.addonskinner.api.SkinActionButton("TextureFrame" .. i)

    -- -- change button font to pfUI-combat font
    -- local btn_timer = getglobal("TextureFrame" .. i .. "_Timer")
    -- if btn_timer then
    --   btn_timer:SetFont(font, tonumber(MPOWA.SAVE[i].fontsize) * 12, "OUTLINE")
    -- end

    -- local btn_stacks = getglobal("TextureFrame" .. i .. "_Count")
    -- if btn_stacks then
    --   btn_timer:SetFont(font, tonumber(MPOWA.SAVE[i].timerfontsize * 12), "OUTLINE")
    -- end
  end

  -- remove from pending list when applied
  pfUI.addonskinner:UnregisterSkin("ModifiedPowerAuras")
end)