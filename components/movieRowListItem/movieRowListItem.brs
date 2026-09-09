sub init()
    m.moviesGridItemPoster = m.top.findNode("moviesGridItemPoster")
    m.moviesGridItemLabel = m.top.findNode("moviesGridItemLabel")
end sub

sub showcontent()
    moviesGridItem = m.top.itemContent

    if moviesGridItem <> invalid

        posterUrl = moviesGridItem.FHDPosterUrl
        if posterUrl = invalid or posterUrl = ""
            posterUrl = moviesGridItem.posterUrl
        end if
        if posterUrl <> invalid and posterUrl <> ""
            m.moviesGridItemPoster.uri = posterUrl
        end if

        labelText = moviesGridItem.title
        if labelText = invalid or labelText = ""
            labelText = moviesGridItem.title
        end if
        if labelText <> invalid and labelText <> ""
            m.moviesGridItemLabel.text = labelText
            m.moviesGridItemLabel.visible = false
        end if
    end if
end sub

sub showFocus()
    if m.top.focusPercent = 1.0 and m.top.itemHasFocus
        m.moviesGridItemLabel.visible = true
    else
        m.moviesGridItemLabel.visible = false
    end if
end sub