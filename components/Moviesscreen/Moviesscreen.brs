sub init()
    m.moviesScreenGrid = m.top.findNode("moviesScreenGrid")
    m.theaterDisplayPicture = m.top.findNode("theaterDisplayPicture")
    m.theaterTitle = m.top.findNode("theaterTitle")
    m.moviesRowList = m.top.findNode("moviesRowList")
    m.contentNode = CreateObject("roSGNode","ContentNode")
    m.moviesRowList.content = m.contentNode
    m.moviesRowList.observeField("rowItemFocused","onRowFocused")
    ' getMoviesScreenData()
    ' m.moviesScreenGrid.observeField("itemFocused","onItemFocused")
    m.moviesPage = 1
    m.moviesLimit = 10
    m.lastTileIndex = 0
    m.lastRow = ""
    m.rowHeights = []
    getMoviesRowListData()
    setFocus()    
end sub

function getMoviesRowListData()
    serverTask = CreateObject("roSGNode","serverTask")
    serverTask.observeField("responseData","setMoviesRowList")
    serverTask.functionName = "getMoviesRowListData"
    serverTask.page = m.moviesPage
    serverTask.limit = m.moviesLimit
    serverTask.control = "run"
end function

function setMoviesRowList(msg as object)
    responseData = msg.getData()
    moviesData = responseData.data
    height = 200
    numColumns = 4
    first_iteration = true
    for each movie in moviesData
        if m.lastTileIndex mod numColumns = 0
            row = m.contentNode.createChild("ContentNode")
            m.lastRow = row
            m.rowHeights.push(height)
        end if

        ' #method 1
        ' if m.lastTileIndex mod numColumns < numColumns
        '     row = getLastRow()
        ' end if
        ' movie = moviesData[i]

        ' #method2
        ' row = getLastRow()

        ' #method3
        row = m.lastRow
        movieTile = row.createChild("ContentNode")
        movieTile.title = movie.title
        movieTile.FHDPosterUrl = movie.moviePosterUrl
        m.lastTileIndex++
    end for
    m.moviesRowList.rowHeights = m.rowHeights
    m.moviesRowList.observeField("rowItemSelected","onItemSelection")
end function

' function getLastRow()
'     lastRowIndex = m.contentNode.getChildCount()-1
'     lastRow = m.contentNode.getChild(lastRowIndex)
'     return lastRow
' end function

function onRowFocused(msg as object)
    responseData = msg.getData()
    rowIndex = responseData[0]
    rowItemIndex = responseData[1]

    ' print responseData
    ' print rowIndex
    ' print rowItemIndex

    if rowItemIndex > -1 
        moviesrowFoucsed = m.moviesRowList.content.getChild(rowIndex)
        currentMovieFocused = moviesrowFoucsed.getChild(rowItemIndex)
        ' print currentMovieFocused
        m.theaterDisplayPicture.uri = currentMovieFocused.FHDPosterUrl
        m.theaterTitle.text = currentMovieFocused.title
    end if

    if rowIndex = m.contentNode.getChildCount() - 1
        ' m.lastRow = getLastRow()
        m.moviesPage ++
        getMoviesRowListData()
    end if
end function

function onItemSelection(msg as object)
    responseData = msg.getData()
    rowIndex = responseData[0]
    rowItemIndex = responseData[1]

    row = m.moviesRowList.content.getChild(rowIndex)
    movieSelected = row.getChild(rowItemIndex)

    m.top.detailsData = {"title":movieSelected.title,"image":movieSelected.HDPosterUrl}
end function



' function getMoviesScreenData()
'     serverTask = CreateObject("roSGNode","serverTask")
'     serverTask.observeField("responseData","setMoviesScreenGrid")
'     serverTask.functionName = "getMoviesScreenGridData"
'     serverTask.control = "run"
' end function

' function setMoviesScreenGrid(msg as object)
'     responseData = msg.getData()
'     moviesContent = responseData.data
'     print "MoviesContent = "
'     print moviesContent
'     contentNode = createObject("roSGNode", "ContentNode")
'     for each item in moviesContent
'         itemNode = contentNode.createChild("ContentNode")
'         itemNode.title = item.title
'         itemNode.HDPosterUrl = item.backgroundurl
'     end for
'     m.moviesScreenGrid.content = contentNode
'     m.moviesScreenGrid.observeField("itemSelected","onItemSelection")
' end function

' function onItemFocused(msg as object)
'     itemFocusedIndex = msg.getData()
'     ' print itemFocusedIndex
'     if itemFocusedIndex > -1 
'         movieGridItemFoucsed = m.moviesScreenGrid.content.getChild(itemFocusedIndex)
'         print movieGridItemFoucsed
'         m.theaterDisplayPicture.uri = movieGridItemFoucsed.HDPosterUrl
'         m.theaterTitle.text = movieGridItemFoucsed.title
'     end if
' end function

' function onItemSelection()
'     itemIndex = m.moviesScreenGrid.itemSelected
'     itemClicked = m.moviesScreenGrid.content.getChild(itemIndex)
'     m.top.detailsData = {"title":itemClicked.title,"image":itemClicked.HDPosterUrl}
' end function

function setFocus()
    ' m.moviesScreenGrid.setFocus(true)
    m.moviesRowList.setFocus(true)
    showMainSceneCounter(false)
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
