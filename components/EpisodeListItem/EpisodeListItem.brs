sub init()
    m.episodeThumbNail = m.top.findNode("episodeThumbNail")
    m.episodeTitle = m.top.findNode("episodeTitle")
    m.episodeDescription = m.top.findNode("episodeDescription")
end sub

sub showContent()
    itemContent = m.top.itemContent
    m.episodeThumbNail.uri = itemContent.HDPosterUrl
    m.episodeTitle.text = itemContent.title
    ' m.episodeDescription = itemContent.description
end sub
