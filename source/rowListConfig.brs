function rowItemConfig() as object
    return {
        "row 1" : [{"text":"Rectangle Node","posterurl":"http://www.sdktestinglab.com/Tutorial/images/rectanglepg.jpg"},{"text":"Rectangle Node (Rotated)","posterurl":"http://www.sdktestinglab.com/Tutorial/images/rectanglerotpg.jpg"},{"text":"Label Node","posterurl":"http://www.sdktestinglab.com/Tutorial/images/labelpg.jpg"}],
        "row 2" : [{"text":"Rectangle Node","posterurl":"http://www.sdktestinglab.com/Tutorial/images/rectanglepg.jpg"},{"text":"Rectangle Node (Rotated)","posterurl":"http://www.sdktestinglab.com/Tutorial/images/rectanglerotpg.jpg"},{"text":"Label Node","posterurl":"http://www.sdktestinglab.com/Tutorial/images/labelpg.jpg"}]
    }
end function

function rowItemConfigWithSizes() as object
    return [
        {
            title: "row 1",
            items : [
                {text:"Rectangle Node", posterurl:"http://www.sdktestinglab.com/Tutorial/images/rectanglepg.jpg"},
                {text:"Rectangle Node (Rotated)", posterurl:"http://www.sdktestinglab.com/Tutorial/images/rectanglerotpg.jpg"},
                {text:"Label Node", posterurl:"http://www.sdktestinglab.com/Tutorial/images/labelpg.jpg"}
            ],
            width: 320,
            height: 180
        },
        {
            title: "row 2",
            items : [
                {text:"Rectangle Node", posterurl:"http://www.sdktestinglab.com/Tutorial/images/rectanglepg.jpg"},
                {text:"Rectangle Node (Rotated)", posterurl:"http://www.sdktestinglab.com/Tutorial/images/rectanglerotpg.jpg"},
                {text:"Label Node", posterurl:"http://www.sdktestinglab.com/Tutorial/images/labelpg.jpg"}
            ],
            width: 240,
            height: 135
        }
    ]
end function