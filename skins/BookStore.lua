pfUI.addonskinner:RegisterSkin("BookStore", function()

  local noop = function() end
  pfUI.api.StripTextures(BookStoreBag)
  pfUI.api.CreateBackdrop(BookStoreBag, nil, nil, .75)  
  pfUI.api.SkinCloseButton(BookStoreBagClose, BookStoreBag.backdrop, -6, -6)
  pfUI.api.SkinArrowButton(BookStoreBagNextShelf, "right", 18)
  BookStoreBagNextShelf:ClearAllPoints()
  BookStoreBagNextShelf:SetPoint("TOPRIGHT", -10, -22)
  pfUI.api.SkinArrowButton(BookStoreBagPrevShelf, "left", 18)
  BookStoreBagPrevShelf:ClearAllPoints()
  BookStoreBagPrevShelf:SetPoint("TOPLEFT", 10, -22)

  for i=1,12 do   
    local slot = getglobal(string.format("BookStoreBagItem%d",i))
    if i == 1 then
      slot:SetPoint("TOPLEFT", 12, -50)
    end     
    pfUI.api.CreateBackdrop(slot, nil, nil, .9)
    slot:SetPushedTexture(nil)
    slot.SetPushedTexture = noop
  end
  BookStoreBag:SetWidth(188)
  BookStoreBag:SetHeight(188)
  BookStoreBagTitle:SetPoint("TOP", 0, -10)

  pfUI.api.StripTextures(BookStoreBook)
  pfUI.api.CreateBackdrop(BookStoreBook, nil, nil, .75)
  BookStoreBook.backdrop:SetPoint("TOPLEFT", 12, -12)
  BookStoreBook.backdrop:SetPoint("BOTTOMRIGHT", -30, 72)
  BookStoreBook:SetHitRectInsets(12,30,12,72)
  pfUI.api.SkinCloseButton(BookStoreBookClose, BookStoreBook.backdrop, -6, -6)
  pfUI.api.SkinArrowButton(BookStoreBookNextPage, "right", 18)
  pfUI.api.SkinArrowButton(BookStoreBookPrevPage, "left", 18)
  BookStoreTextWrap:ClearAllPoints()
  BookStoreTextWrap:SetPoint("TOPLEFT", BookStoreBook.backdrop, "TOPLEFT", 12, -70)
  BookStoreTextWrap:SetPoint("BOTTOMRIGHT", BookStoreBook.backdrop, "BOTTOMRIGHT", -12, 15)
  local bg = BookStoreTextWrap:CreateTexture(nil, "LOW")
  bg:SetAllPoints()
  bg:SetTexCoord(.1,1,0,1)
  bg:SetTexture("Interface\\Stationery\\StationeryTest1")  

  pfUI.api.StripTextures(BookStoreBookDelete)
  BookStoreBookDelete:SetWidth(20)
  BookStoreBookDelete:SetHeight(20)
  BookStoreBookDelete:SetHitRectInsets(0,0,0,0)
  BookStoreBookDelete:SetPushedTexture(nil)
  BookStoreBookDelete:SetNormalTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
  pfUI.api.CreateBackdrop(BookStoreBookDelete, nil, nil, .9)
  pfUI.api.SetHighlight(BookStoreBookDelete)
  BookStoreBookDelete:ClearAllPoints()
  BookStoreBookDelete:SetPoint("BOTTOMLEFT", BookStoreBook.backdrop, "BOTTOMLEFT", 17, 20)
  BookStoreBookDelete:SetFrameStrata("DIALOG")

  pfUI.api.SkinButton(BookStoreCopyButton)
  BookStoreCopyButton:SetFrameStrata("DIALOG")
  if ItemTextFrame.backdrop then
    BookStoreCopyButton:SetPoint("BOTTOMLEFT", 28, 115)
  end
  pfUI.addonskinner:UnregisterSkin("BookStore")
end)
