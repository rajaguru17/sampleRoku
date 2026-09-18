sub init()
    m.buttonBackground = m.top.findNode("buttonBackground")
    m.buttonIcon = m.top.findNode("buttonIcon")
    m.isFocus = false
end sub

sub showContent()
    itemContent = m.top.itemContent
    m.buttonBackground.uri = "pkg:/images/buttons/circle.png"
    m.buttonIcon.uri = itemContent.HDPosterUrl
    updateFocus()
end sub

sub showfocus()
    if m.top.focusPercent = 1.0 and m.top.gridHasFocus
        m.isFocus = true
    else
        m.isFocus = false
    end if
    updateFocus()
end sub

function updateFocus()
    if m.isFocus
        m.buttonBackground.blendcolor = "0xFFFFFF"
        m.buttonIcon.blendcolor = "0x000000"
    else
        m.buttonBackground.blendcolor = "0x000000"
        m.buttonIcon.blendcolor = "0xFFFFFF"
    end if
end function