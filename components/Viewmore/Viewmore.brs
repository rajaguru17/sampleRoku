sub init()
    m.viewMoreScreen = m.top.findNode("viewMoreBackground")
    setViewMoreBackground()
    m.viewMoreTitle = m.top.findNode("viewMoreTitle")
    m.viewMoreGrid = m.top.findNode("viewMoreGrid")
    m.viewMoreGrid.setFocus(true)
    m.counter = m.top.findNode("counter")
end sub

' function showCounter(clickCount)
'     m.counter.text = "Clicks = " + clickCount.toStr()
' end function

function setViewMoreBackground()
    m.viewMoreScreen.width = 1920
    m.viewMoreScreen.height = 950
    m.viewMoreScreen.color = "#000000"
    m.viewMoreScreen.translation = "[0,150]"
end function

function setViewMoreGrid()
    m.viewMoreTitle.text = m.top.viewMoreData["title"]

    info = m.top.viewMoreData["rowInfo"]
    ' print info
    contentNode = createObject("roSGNode", "ContentNode")
    for each item in info
        viewMoreItemNode = contentNode.createChild("ContentNode")
        viewMoreItemNode.title = item.id
        viewMoreItemNode.HDPosterUrl = item.posterurl
    end for
    m.viewMoreGrid.content = contentNode
    m.viewMoreGrid.observeField("itemSelected","onItemSelection")
end function

function onItemSelection()
    itemIndex = m.viewMoreGrid.itemSelected
    itemClicked = m.viewMoreGrid.content.getChild(itemIndex)
    m.top.detailsData = {"title":itemClicked.title,"image":itemClicked.HDPosterUrl}


end function

function setFocus()
    m.viewMoreGrid.setFocus(true)
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

    print "viewMoreOnKey pass"
end function
