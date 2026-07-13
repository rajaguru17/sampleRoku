sub init()
   'm.itemposter = m.top.findNode("itemPoster") 
    m.itemlabel = m.top.findNode("itemLabel")
    m.itemBackground = m.top.findNode("itemBackground")
end sub

sub showcontent()
    itemcontent = m.top.itemContent
   'm.itemposter.uri = itemcontent.HDPosterUrl
    m.itemlabel.text = itemcontent.title
end sub

sub showfocus()
    if m.top.focusPercent = 1.0 and m.top.gridHasFocus
         m.itemBackground.color = "0xFFFFFFFF"
        m.itemlabel.color = "0x000000FF"
    else
        m.itemBackground.color = "0x000000FF"
        m.itemlabel.color = "0xFFFFFFFF"
    end if
end sub
