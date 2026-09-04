sub init()
    m.moviesScreenGrid = m.top.findNode("moviesScreenGrid")
    m.theaterDisplayPicture = m.top.findNode("theaterDisplayPicture")
    m.theaterTitle = m.top.findNode("theaterTitle")
    m.moviesRowList = m.top.findNode("moviesRowList")
    ' getMoviesScreenData()
    ' m.moviesScreenGrid.observeField("itemFocused","onItemFocused")
    m.moviesPage = 1
    m.moviesLimit = 20
    m.rowStart = 0
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

    rowHeights = []
    rowItemSize = []
    offset = []
    rowItemSpacing = []
    rowCounter = []
    numColumns = 4
    ' numRows = moviesData.count()\numColumns
    rowIndex = m.rowStart
    columns = 4

    contentNode = CreateObject("roSGNode","ContentNode")
    for i=0 to moviesData.count() - 1
        ' moviesRow = contentNode.createChild("ContentNode")
        if i mod columns = 0
            row = contentNode.createChild("ContentNode")
            rowHeights.push(200)
            rowItemSize.push([400,200])
            offset.push([0,20])
            rowItemSpacing.push([20,20])
            rowCounter.push(true)
        end if

        movie = moviesData[i]
        
        movieTile = row.createChild("ContentNode")
        movieTile.width = 400
        movieTile.height = 200
        movieTile.title = movie.title
        movieTile.HDPosterUrl = movie.moviePosterUrl
    end for
    ' m.moviesRowList.numRows = (moviesData.count()+columns -1)\columns    
    m.moviesRowList.rowHeights = rowHeights
    m.moviesRowList.rowItemSize = rowItemSize
    m.moviesRowList.rowItemSpacing = rowItemSpacing
    ' m.moviesRowList.rowLabelOffset = offset
    ' m.moviesRowList.showRowCounter = rowCounter
    m.moviesRowList.content = contentNode

    ' if m.moviesRowList.rowFocused = numRows
    '     m.moviesPage ++
    '     m.moviesLimit += 20
    '     m.rowStart += numRows
    '     ' getMoviesRowListData()
    ' end if
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
    ' showMainSceneCounter(false)
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
