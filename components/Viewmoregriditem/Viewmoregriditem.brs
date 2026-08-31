sub init()
    m.viewMoreGridItemPoster = m.top.findNode("viewMoreGridItemPoster")
    m.viewMoreGridItemLabel = m.top.findNode("viewMoreGridItemLabel")
end sub

sub showcontent()
    viewMoreItemContent = m.top.itemContent

    if viewMoreItemContent <> invalid

        posterUrl = viewMoreItemContent.HDPosterUrl
        if posterUrl = invalid or posterUrl = ""
            posterUrl = viewMoreItemContent.posterUrl
        end if
        if posterUrl <> invalid and posterUrl <> ""
            m.viewMoreGridItemPoster.uri = posterUrl
        end if

        labelText = viewMoreItemContent.title
        if labelText = invalid or labelText = ""
            labelText = viewMoreItemContent.title
        end if
        if labelText <> invalid and labelText <> ""
            m.viewMoreGridItemLabel.text = labelText
            m.viewMoreGridItemLabel.visible = false
        end if
    end if
end sub

sub showFocus()
    if m.top.focusPercent = 1.0 and m.top.gridHasFocus
        m.viewMoreGridItemLabel.visible = true
    else
        m.viewMoreGridItemLabel.visible = false
    end if
end sub
