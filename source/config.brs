function rowItemConfig() as object
    return {
        "row 1": [{ "text": "Rectangle Node", "posterurl": "http://www.sdktestinglab.com/Tutorial/images/rectanglepg.jpg" }, { "text": "Rectangle Node (Rotated)", "posterurl": "http://www.sdktestinglab.com/Tutorial/images/rectanglerotpg.jpg" }, { "text": "Label Node", "posterurl": "http://www.sdktestinglab.com/Tutorial/images/labelpg.jpg" }],
        "row 2": [{ "text": "Rectangle Node", "posterurl": "http://www.sdktestinglab.com/Tutorial/images/rectanglepg.jpg" }, { "text": "Rectangle Node (Rotated)", "posterurl": "http://www.sdktestinglab.com/Tutorial/images/rectanglerotpg.jpg" }, { "text": "Label Node", "posterurl": "http://www.sdktestinglab.com/Tutorial/images/labelpg.jpg" }]
    }
end function

function rowItemConfigWithSizes() as object
    return [
        {
            title: "row 1",
            items: [
                { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live1", type: "live_channels", tags: "LIVE" },
                { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live2", type: "live_channels", tags: "LIVE" },
                { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live3", type: "live_channels", tags: "LIVE" },
                { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live1", type: "live_channels", tags: "LIVE" },
                { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live2", type: "live_channels", tags: "LIVE" },
                { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live3", type: "live_channels", tags: "LIVE" },
                { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live1", type: "live_channels", tags: "LIVE" },
                { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live2", type: "live_channels", tags: "LIVE" },
                { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live3", type: "live_channels", tags: "LIVE" },
                { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "live3", type: "live_channels", tags: "LIVE" }
            ],
            width: 320,
            height: 180,

        },
        {
            title: "row 2",
            items: [
                { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "movie1", type: "movies", tags: "New Movies" },
                { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "movie2", type: "movies", tags: "New Movies" },
                { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "movie3", type: "movies", tags: "New Movies" },
                { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "movie1", type: "movies", tags: "New Movies" },
                { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "movie2", type: "movies", tags: "New Movies" },
                { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "movie3", type: "movies", tags: "New Movies" },
                { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "movie1", type: "movies", tags: "New Movies" },
                { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "movie2", type: "movies", tags: "New Movies" },
                { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "movie3", type: "movies", tags: "New Movies" },
                { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "movie3", type: "movies", tags: "New Movies" }
            ],
            width: 240,
            height: 135
        },
        {
            title: "row 3",
            items: [
                { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series1", type: "series", tags: "New Season" },
                { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series2", type: "series", tags: "New Season" },
                { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series3", type: "series", tags: "New Season" },
                { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series1", type: "series", tags: "New Season" },
                { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series2", type: "series", tags: "New Season" },
                { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series3", type: "series", tags: "New Season" },
                { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series1", type: "series", tags: "New Season" },
                { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series2", type: "series", tags: "New Season" },
                { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series3", type: "series", tags: "New Season" },
                { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "series3", type: "series", tags: "New Season" }
            ],
            width: 320,
            height: 180
        },
        {
            title: "row 4",
            items: [
                { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
                { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
                { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
                { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
                { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
                { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
                { text: "Rectangle Node",           posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
                { text: "Rectangle Node (Rotated)", posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
                { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" },
                { text: "Label Node",               posterurl: "pkg:/images/rsgde_mm_focus_hd.jpg", id: "Top10", type: "top_10", tags: "Top 10" }
            ],
            width: 240,
            height: 135
        }
    ]
end function

function markUpConfig() as object
    return[
        { "text": "Home", "posterurl": "pkg:/images/rde_mm_focus_sd.jpg" },
        { "text": "Movies", "posterurl": "pkg:/images/rde_mm_focus_sd.jpg" },
        { "text": "TV Shows", "posterurl": "pkg:/images/rde_mm_focus_sd.jpg" },
        { "text": "Genre", "posterurl": "pkg:/images/rde_mm_focus_sd.jpg" }
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

