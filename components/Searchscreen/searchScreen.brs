sub init()
    m.searchMiniKeyboard = m.top.findNode("searchMiniKeyboard")
    m.searchMiniKeyboard.setFocus(true)
    m.nodeFocused = m.searchMiniKeyboard
    m.searchMiniKeyboard .textEditBox.textColor = "#FFFFFF"
    text = m.searchMiniKeyboard.text
    m.searchMiniKeyboard.observeField("text","findSearchedContent")
    m.allContentGrid = m.top.findNode("allContentGrid")
    m.counter = m.top.findNode("counter")
    ' findSearchedContent()
end sub

' function showCounter(clickCount)
'     m.counter.text = "Clicks = " + clickCount.toStr()
' end function

function findSearchedContent(msg as object)
    searchText = msg.getData()
    print searchText
    if searchText = ""
        return []
    end if
    serverTask = CreateObject("roSGNode","serverTask")
    serverTask.observeField("responseData","setSearchedContentGrid")
    serverTask.functionName = "getSearchedContent"
    serverTask.searchQuery = searchText
    serverTask.control = "run"
end function

function setSearchedContentGrid(msg as object)
    responseData = msg.getData()
    allContent = responseData.data
    print allContent
    contentNode = createObject("roSGNode", "ContentNode")
    for each item in allContent
        itemNode = contentNode.createChild("ContentNode")
        itemNode.title = item.id
        itemNode.HDPosterUrl = item.posterurl
    end for
    m.allContentGrid.content = contentNode
    m.allContentGrid.observeField("itemSelected","onItemSelection")
end function

function onItemSelection()
    itemIndex = m.allContentGrid.itemSelected
    itemClicked = m.allContentGrid.content.getChild(itemIndex)
    m.top.detailsData = {"title":itemClicked.title,"image":itemClicked.HDPosterUrl}
end function

function setFocus()
    m.nodeFocused.setFocus(true)
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
        if key = "right"
            m.allContentGrid.setFocus(true)
            m.nodeFocused = m.allContentGrid
            print "right key on search pressed form keypad"
            print m.allContentGrid.hasFocus()
        end if
        if key = "left" and m.allContentGrid.hasFocus()
            m.searchMiniKeyboard.setFocus(true)
            m.nodeFocused = m.searchMiniKeyboard
        end if

    end if

    print "Search screen key pressed"
end function



