sub init()
    m.itemposter = m.top.findNode("itemPoster") 
    m.itemlabel = m.top.findNode("itemLabel")
    m.itemBadge = m.top.findNode("fullBadge")
    m.itembadgeBg = m.top.findNode("badge") 
    m.itembadgeText = m.top.findNode("badgeText")
    m.dummy = m.top.findNode("dummyLabel")
    m.isViewAll = m.top.findNode("isViewAll")
    m.itembadgeText.font.size = 24
    m.dummy.font.size = 24

end sub

sub showcontent()
    itemcontent = m.top.itemContent
    m.itemposter.uri = itemcontent.HDPosterUrl
    m.itemlabel.text = itemcontent.title
    m.itemposter.width = itemcontent.width
    m.itemposter.height = itemcontent.height
    m.itemData = itemcontent.itemData

   'print m.itemData
   if m.itemData <> invalid
        m.dummy.text = m.itemData.tags
        localRect = m.dummy.boundingRect()
        dummyHeight = localRect.height +10
        dummyWidth = localRect.width +20


        m.itembadgeText.text = m.itemData.tags
        m.itembadgeText.height = dummyHeight
        m.itembadgeBg.height =  dummyHeight
        m.itembadgeText.width = dummyWidth
        m.itembadgeBg.width =  dummyWidth

        m.itemBadge.translation = [itemcontent.width - dummyWidth -10 , 10]

    ' if m.itemContent.type = "view_more"
    '     m.itemposter.visible = false
    '     m.itemlabel.text = "View_more"
    '     m.itemlabel.opacity = 1.0
    ' end if

    ' if m.itemData.type = "live_channels"
    '     m.itemBadge.visible = true
    '     m.itembadgeText.color = "0xFF0000FF"
    '     m.itembadgeBg.color = "0xFFFFFFFF"

    ' else if m.itemData.type = "movies"
    '     m.itemBadge.visible = true
    '     m.itembadgeText.color = "0xFFFF00FF"
    '     m.itembadgeBg.color = "0x000000FF"

    ' else if m.itemData.type = "series"
    '     m.itemBadge.visible = true
    '     m.itembadgeText.color = "0xFFFFFFFF"
    '     m.itembadgeBg.color = "0x000000FF"

    ' else if m.itemData.type = "top_10"
    '     m.itemBadge.visible = true
    '     m.itembadgeText.color = "0x000000FF"
    '     m.itembadgeBg.color = "0xFFFFFFFF"

    ' end if

        badgeData = badge()

        if  badgeData[m.itemData.type] <> invalid
            
            badgeTypeVariable = badgeData[m.itemData.type]

            m.itemBadge.visible = true
            m.itembadgeText.color = badgeTypeVariable.textColor
            m.itembadgeBg.color = badgeTypeVariable.bgcolor
        end if
    else
        m.itemBadge.visible = false
    end if

    if itemContent.isViewAll = true
        m.isViewAll.height = itemcontent.height
        m.isViewAll.width = itemcontent.width
        m.isViewAll.text = itemcontent.title

    end if

end sub

sub showfocus()
    
end sub

sub showrowfocus()

end sub
