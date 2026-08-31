sub init()
    m.moviesScreenGrid = m.top.findNode("moviesScreenGrid")
    m.theaterDisplayPicture = m.top.findNode("theaterDisplayPicture")
    m.theaterTitle = m.top.findNode("theaterTitle")
    getMoviesScreenData()
    m.moviesScreenGrid.observeField("itemFocused","onItemFocused")
    m.counter = m.top.findNode("counter")
end sub

' function showCounter(clickCount)
'     m.counter.text = "Clicks = " + clickCount.toStr()
' end function

function getMoviesScreenData()
    serverTask = CreateObject("roSGNode","serverTask")
    serverTask.observeField("responseData","setMoviesScreenGrid")
    serverTask.functionName = "getMoviesScreenGridData"
    serverTask.control = "run"
end function

function setMoviesScreenGrid(msg as object)
    responseData = msg.getData()
    moviesContent = responseData.data
    print "MoviesContent = "
    print moviesContent
    contentNode = createObject("roSGNode", "ContentNode")
    for each item in moviesContent
        itemNode = contentNode.createChild("ContentNode")
        itemNode.title = item.title
        itemNode.HDPosterUrl = item.backgroundurl
    end for
    m.moviesScreenGrid.content = contentNode
    m.moviesScreenGrid.observeField("itemSelected","onItemSelection")
end function

function onItemFocused(msg as object)
    itemFocusedIndex = msg.getData()
    ' print itemFocusedIndex
    if itemFocusedIndex > -1 
        movieGridItemFoucsed = m.moviesScreenGrid.content.getChild(itemFocusedIndex)
        print movieGridItemFoucsed
        m.theaterDisplayPicture.uri = movieGridItemFoucsed.HDPosterUrl
        m.theaterTitle.text = movieGridItemFoucsed.title
    end if
end function

function onItemSelection()
    itemIndex = m.moviesScreenGrid.itemSelected
    itemClicked = m.moviesScreenGrid.content.getChild(itemIndex)
    m.top.detailsData = {"title":itemClicked.title,"image":itemClicked.HDPosterUrl}
end function

function setFocus()
    m.moviesScreenGrid.setFocus(true)
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press
        if key = "up"
            m.top.keyPressed = key
            return true
        end if
        if key = "back"
            m.top.goBack = true
            return true
        end if
    end if
    print "MoviesScreen pass"
end function
