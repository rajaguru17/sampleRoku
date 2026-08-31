sub init()
    m.profileItem = m.top.findNode("profileItem")
    m.profileItemPoster = m.top.findNode("profileItemPoster")
    m.profileItemLabel = m.top.findNode("profileItemLabel")
    m.profileBorder = m.top.findNode("profileBorder")
end sub

sub showcontent()
    profileItemContent = m.top.itemContent

    if profileItemContent <> invalid
        ' print profileItemContent
        posterUrl = profileItemContent.HDPosterUrl
        if posterUrl = invalid or posterUrl = ""
            posterUrl = profileItemContent.posterurl
        end if

        if posterUrl <> invalid and posterUrl <> ""
            m.profileItemPoster.uri = posterUrl
            ' print posterUrl
        end if

        labelText = profileItemContent.text
        if labelText = invalid or labelText = ""
            labelText = profileItemContent.title
        end if

        if labelText <> invalid and labelText <> ""
            m.profileItemLabel.text = labelText
            m.profileItemLabel.visible = false
        end if
    end if
end sub

sub showfocus()
        if m.top.focusPercent = 1.0 and m.top.gridHasFocus
            m.profileItemLabel.visible = true
            m.profileBorder.visible = true
        else
            m.profileItemLabel.visible = false
            m.profileBorder.visible = false
        end if
end sub