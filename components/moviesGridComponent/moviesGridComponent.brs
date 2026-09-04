sub init()
    m.moviePoster = m.top.findNode("moviePoster") 
    m.movieLabel = m.top.findNode("movieLabel")
end sub

sub showcontent()
    itemcontent = m.top.itemContent
    m.moviePoster.uri = itemcontent.HDPosterUrl
    m.movieLabel.text = itemcontent.title
end sub

sub showfocus()
    
end sub
