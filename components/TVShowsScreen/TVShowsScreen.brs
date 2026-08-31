sub init()
    m.tvShowsGrid = m.top.findNode("tvShowsGrid")
    m.counter = m.top.findNode("counter")
    getTVShows()
    setFocus()
end sub

' function showCounter(clickCount)
'     m.counter.text = "Clicks = " + clickCount.toStr()
' end function

function getTVShows()
    serverTask = CreateObject("roSGNode","serverTask")
    serverTask.observeField("responseData","setTVShowsGrid")
    serverTask.functionName = "getTVShowsGridData"
    serverTask.control = "run"
    print "ran getTVShows"
end function

function setTVShowsGrid(msg as object)
    print "entered setTVShowsGrid"
    responseData = msg.getData()
    m.tvShowGridData = responseData.data
    print "respondeData =", m.tvShowGridData
    contentNode = CreateObject("roSGNode","ContentNode")
    ' contentNode.addField("") #Add description field

    for each item in m.tvShowGridData
        print "each item in tvShwoGridData =",item
        itemNode = contentNode.createChild("ContentNode")
        itemNode.id = item.id
        itemNode.title = item.title
        itemNode.HDPosterUrl = item.posterurl
    end for
    m.tvShowsGrid.content = contentNode
    m.tvShowsGrid.observeField("itemSelected","OnShowSelection")
end function

function OnShowSelection(msg as object)
    print "entered OnShowSelection"
    showItemSelected = msg.getData()
    ' print type(showItemSelected)
    m.top.showID = m.tvShowGridData[showItemSelected].id
    print "showID = ",m.top.showID
end function

function setFocus()
    m.tvShowsGrid.setFocus(true)
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
end function