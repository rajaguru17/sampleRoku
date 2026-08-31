' function rowItemConfig() as object
'     return {
'         "row 1": [{ "text": "Rectangle Node", "posterurl": "http://www.sdktestinglab.com/Tutorial/images/rectanglepg.jpg" }, { "text": "Rectangle Node (Rotated)", "posterurl": "http://www.sdktestinglab.com/Tutorial/images/rectanglerotpg.jpg" }, { "text": "Label Node", "posterurl": "http://www.sdktestinglab.com/Tutorial/images/labelpg.jpg" }],
'         "row 2": [{ "text": "Rectangle Node", "posterurl": "http://www.sdktestinglab.com/Tutorial/images/rectanglepg.jpg" }, { "text": "Rectangle Node (Rotated)", "posterurl": "http://www.sdktestinglab.com/Tutorial/images/rectanglerotpg.jpg" }, { "text": "Label Node", "posterurl": "http://www.sdktestinglab.com/Tutorial/images/labelpg.jpg" }]
'     }
' end function

' function rowItemConfigWithSizes() as object
'     return [
'         {
'             title: "row 1",
'             items: [
'                 { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live1", type: "live_channels", tags: "LIVE" },
'                 { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live2", type: "live_channels", tags: "LIVE" },
'                 { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live3", type: "live_channels", tags: "LIVE" },
'                 { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live1", type: "live_channels", tags: "LIVE" },
'                 { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live2", type: "live_channels", tags: "LIVE" },
'                 { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live3", type: "live_channels", tags: "LIVE" },
'                 { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live1", type: "live_channels", tags: "LIVE" },
'                 { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live2", type: "live_channels", tags: "LIVE" },
'                 { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live3", type: "live_channels", tags: "LIVE" },
'                 { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live3", type: "live_channels", tags: "LIVE" }
'             ],
'             width: 320,
'             height: 180,

'         },
'         {
'             title: "row 2",
'             items: [
'                 { text: "Rectangle Node",           posterurl: "pkg:/images/bigPictures/image1.jpg", id: "movie1", type: "movies", tags: "New Movies" },
'                 { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/bigPictures/image2.jpg", id: "movie2", type: "movies", tags: "New Movies" },
'                 { text: "Label Node",               posterurl: "pkg:/images/bigPictures/image3.jpg", id: "movie3", type: "movies", tags: "New Movies" },
'                 { text: "Rectangle Node",           posterurl: "pkg:/images/bigPictures/image4.jpg", id: "movie1", type: "movies", tags: "New Movies" },
'                 { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/bigPictures/image5.jpg", id: "movie2", type: "movies", tags: "New Movies" },
'                 { text: "Label Node",               posterurl: "pkg:/images/bigPictures/image6.jpg", id: "movie3", type: "movies", tags: "New Movies" },
'                 { text: "Rectangle Node",           posterurl: "pkg:/images/bigPictures/image7.jpg", id: "movie1", type: "movies", tags: "New Movies" },
'                 { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/bigPictures/image8.jpg", id: "movie2", type: "movies", tags: "New Movies" },
'                 { text: "Label Node",               posterurl: "pkg:/images/bigPictures/image9.jpg", id: "movie3", type: "movies", tags: "New Movies" },
'                 { text: "Label Node",               posterurl: "pkg:/images/bigPictures/image10.jpg", id: "movie3", type: "movies", tags: "New Movies" }
'             ],
'             width: 240,
'             height: 135
'         },
'         {
'             title: "row 3",
'             items: [
'                 { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series1", type: "series", tags: "New Season" },
'                 { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series2", type: "series", tags: "New Season" },
'                 { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series3", type: "series", tags: "New Season" },
'                 { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series1", type: "series", tags: "New Season" },
'                 { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series2", type: "series", tags: "New Season" },
'                 { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series3", type: "series", tags: "New Season" },
'                 { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series1", type: "series", tags: "New Season" },
'                 { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series2", type: "series", tags: "New Season" },
'                 { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series3", type: "series", tags: "New Season" },
'                 { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series3", type: "series", tags: "New Season" }
'             ],
'             width: 320,
'             height: 180
'         },
'         {
'             title: "row 4",
'             items: [
'                 { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
'                 { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
'                 { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
'                 { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
'                 { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
'                 { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
'                 { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
'                 { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
'                 { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
'                 { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" }
'             ],
'             width: 240,
'             height: 135
'         }
'     ]
' end function

' function markUpConfig() as object
'     return[
'         { "text": "Home", "posterurl": "pkg:/images/rde_mm_focus_sd.jpg" },
'         { "text": "Movies", "posterurl": "pkg:/images/rde_mm_focus_sd.jpg" },
'         { "text": "TV Shows", "posterurl": "pkg:/images/rde_mm_focus_sd.jpg" },
'         { "text": "Genre", "posterurl": "pkg:/images/rde_mm_focus_sd.jpg" }
'     ]
' end function

function detailsGridConfig() as object
    return[
        "Play Movie","Play Trailer", "Like","Not for me"
    ]
end function

function badge() as object
    return {
        "live_channels": { bgcolor: "0xBF0000", textColor: "0xFFFFFF" },
        "movies": { bgcolor: "0xFFFF00FF", textColor: "0x000000FF" },
        "series": { bgcolor: "0x000000FF", textColor: "0xFFFFFFFF" },
        "top10": { bgcolor: "0x000000FF", textColor: "0xFFFFFFFF" }
    }
end function

' function profilesGridConfig() as object
'     return [
'         { text: "User1", posterurl: "pkg:/images/profilePic/image1.jpg" },
'         { text: "User2", posterurl: "pkg:/images/profilePic/image2.jpg" },
'         { text: "User3", posterurl: "pkg:/images/profilePic/image3.jpg" },
'         { text: "User4", posterurl: "pkg:/images/profilePic/image4.jpg" }
'     ]
' end function

' function profileSliders() as object
'     return [
'         { 
'             backgroundurl: "pkg:/images/bigPictures/image1.jpg", 
'             title: "Movie1", 
'             genre: ["Hero","Action","Comedy"], 
'             highlights: "Top #1 last week"
'         },
'         { 
'             backgroundurl: "pkg:/images/bigPictures/image2.jpg", 
'             title: "Spiderman", 
'             genre: ["Superhero","Action","Scifi"], 
'             highlights: ""
'         },
'         { 
'             backgroundurl: "pkg:/images/bigPictures/image3.jpg", 
'                 title: "Movie1", 
'             genre: ["Hero","Action","Comedy"], 
'             highlights: "Top #1 last week"
'         },
'         { 
'             backgroundurl: "pkg:/images/bigPictures/image4.jpg", 
'             title: "Venom", 
'             genre: ["Superhero","Action","Dark Comedy"], 
'             highlights: "Spent in top 10 last week"
'         },
        
'         { 
'             backgroundurl: "pkg:/images/bigPictures/image5.jpg", 
'             title: "Deadpool", 
'             genre: ["Superhero","Action","Witty"], 
'             highlights: ""
'         },
'         { 
'             backgroundurl: "pkg:/images/bigPictures/image6.jpg", 
'             title: "Batman", 
'             genre: ["Superhero","Action","Dark Comedy"], 
'             highlights: "Spent in top 10 last week"
'         },
'         { 
'             backgroundurl: "pkg:/images/bigPictures/image7.jpg", 
'             title: "Jhon Wick", 
'             genre: ["Superhero","Action","Dark Comedy"], 
'             highlights: "Spent in top 10 last week"
'         },
'         { 
'             backgroundurl: "pkg:/images/bigPictures/image8.jpg", 
'             title: "Avengers: End Game", 
'             genre: ["Hero","Action","Comedy"], 
'             highlights: "Top #1 last week"
'         },
'         { 
'             backgroundurl: "pkg:/images/bigPictures/image9.jpg", 
'             title: "Interstellar", 
'             genre: ["Superhero","Action","Scifi"], 
'             highlights: ""
'         },
'         { 
'             backgroundurl: "pkg:/images/bigPictures/image10.jpg", 
'             title: "Death Note", 
'             genre: ["Anime","Intelligent","Brain Games"], 
'             highlights: "G.O.A.T amongst anime of all time"
'         }
'     ]
' end function

' #Sample JSON template
' {
' "title":"Uri: The Surgical Strike",
' "description":"Major Vihaan Singh Shergill leads an elite Para Special Forces unit to execute a high stakes retaliatory strike across the border. He navigates personal grief and military bureaucracy to dismantle the infrastructure of a militant cell."
' "image":"https://m.media-amazon.com/images/M/MV5BYTgyMTlkZTgtMTMxYi00Mjk5LTg2NTMtNGYyMDVlZWM0NmZjXkEyXkFqcGc@._V1_.jpg",
' "genre":[],
' "trailer":"https://imdb-video.media-imdb.com/vi3240999449/1434659607842-pgv4ql-1563862378755.mp4?Expires=1787083481&Signature=TAh7eLEs0uUofTC6ZwKpCvWWXZAlF~xUsf8C8u6stuzkMPtAIJqhrjNX76wW~CoWcAzoMLADJZzBKP79splDqZtFgIkWa9mIMkWztvyeeYEgaLqDHIFUJ7RA~Hm-p0WYHb-OaKz-3WXsbLwx-Hm3uSQ1HLxMKxwd4mowOy6xGZNr7OPgrDlcUGIH1Pr9TsN5aoPYkmhzPpjnlZHJFjjk9dbOVAztOhMBGfYBv3QHrsLMs-Y-zvm79Rpc0sVCE1MaqIumaZJCIiVBvu5-Q6bo1iVMjSIvSSeMjt5tSQWJ8Tlv9B-HMX4MkABKlNdG8M2B3UdWBMDV0PpQhwhp0MaDMw__&Key-Pair-Id=APKAIFLZBVQZ24NQH3KA"
' }