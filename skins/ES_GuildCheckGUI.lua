pfUI.addonskinner:RegisterSkin("ES_GuildCheckGUI", function()
  
  pfUI.api.StripTextures(EGC_DumpFrame)
  pfUI.api.CreateBackdrop(EGC_DumpFrame, nil, nil, .75)
  pfUI.api.StripTextures(EnumerateFrames(EGC_DumpFrame)) -- first child unnamed
  pfUI.api.CreateBackdrop(EGC_ScrollFrame, nil, nil, .9)
  pfUI.api.SkinScrollbar(EGC_ScrollFrameScrollBar)

  pfUI.api.SkinButton(EGCOffline_Button)
  pfUI.api.SkinButton(EGCOnline_Button)
  pfUI.api.SkinButton(EGCExit_Button)

  pfUI.addonskinner:UnregisterSkin("ES_GuildCheckGUI")
end)
