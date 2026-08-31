sub init()
    m.detailsGridItemLabel = m.top.findNode("detailsGridItemLabel")
    m.detailsGridItemBackground = m.top.findNode("detailsGridItemBackground")
end sub

sub showContent()
    itemContent = m.top.itemContent
    m.detailsGridItemLabel.text = itemContent.title
    m.detailsGridItemLabel.font.size = 22
end sub



sub showfocus()
    if m.top.focusPercent = 1.0 and m.top.gridHasFocus
         m.detailsGridItemBackground.color = "0xFFFFFFFF"
        m.detailsGridItemLabel.color = "0x000000FF"
    else
        m.detailsGridItemBackground.color = "0x000000FF"
        m.detailsGridItemLabel.color = "0xFFFFFFFF"
    end if
end sub