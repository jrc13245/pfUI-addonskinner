pfUI.addonskinner:RegisterSkin("BugSack", function()

  pfUI.api.StripTextures(BugSackFrame)
  pfUI.api.CreateBackdrop(BugSackFrame,nil, nil, .75)

  pfUI.api.SkinButton(BugSackFrameButton)
  pfUI.api.SkinButton(BugSackPrevButton)
  pfUI.api.SkinButton(BugSackNextButton)
  pfUI.api.SkinButton(BugSackFirstButton)
  pfUI.api.SkinButton(BugSackLastButton)

  pfUI.api.SkinScrollbar(BugSackFrameScrollScrollBar)

  pfUI.addonskinner:UnregisterSkin("BugSack")
end)
