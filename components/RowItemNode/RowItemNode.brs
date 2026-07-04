sub init()
    m.itemposter = m.top.findNode("itemPoster") 
    m.itemlabel = m.top.findNode("itemLabel")
end sub

sub showcontent()
    itemcontent = m.top.itemContent
    m.itemposter.uri = itemcontent.HDPosterUrl
    m.itemlabel.text = itemcontent.title
    m.itemposter.width = itemcontent.width
    m.itemposter.height = itemcontent.height
    ?itemcontent
end sub

sub showfocus()
    
end sub

sub showrowfocus()
    ' m.itemlabel.opacity = m.top.rowFocusPercent
end sub
