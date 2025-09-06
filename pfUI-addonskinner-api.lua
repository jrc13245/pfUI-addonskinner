
pfUI.addonskinner.api = {}

function pfUI.addonskinner.api.SkinActionButton(frame)
  local btn
  local btn_icon
  local btn_high
  local btn_pushed
  local btn_checked

  if type(frame) == "string" then
    btn = getglobal(frame)
  elseif type(frame) == "table" then
    btn = frame
  else
    return
  end

  if btn.SetNormalTexture then
    btn:SetNormalTexture("")
    btn.SetNormalTexture = function() return end
  end

  if getglobal(btn:GetName() .. "Icon") then
    btn_icon = getglobal(btn:GetName() .. "Icon")
  else
    btn_icon = getglobal(btn:GetName() .. "_Icon")
  end

  if btn_icon then
    btn_icon:SetAllPoints(btn)
    btn_icon:SetTexCoord(.08,.92,.08,.92)
  end

  if btn.GetHighlightTexture then
    btn_high = btn:GetHighlightTexture()
    btn_high:SetAllPoints(btn)
    btn_high:SetTexCoord(.08,.92,.08,.92)
    btn.SetHighlightTexture = function() return end
  end

  if btn.GetPushedTexture then
    btn_pushed = btn:GetPushedTexture()
    btn_pushed:SetAllPoints(btn)
    btn_pushed:SetTexCoord(.08,.92,.08,.92)
    btn.SetPushedTexture = function() return end
  end

  if btn.GetCheckedTexture then
    btn_checked = btn:GetCheckedTexture()
    btn_checked:SetAllPoints(btn)
    btn_checked:SetTexCoord(.08,.92,.08,.92)
    btn.SetCheckedTexture = function() return end
  end

  pfUI.api.CreateBackdrop(btn)
end
