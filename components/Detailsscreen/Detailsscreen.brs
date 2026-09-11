sub init()
    showMainSceneCounter(false)
    m.detailsBackground = m.top.findNode("detailsBackground")
    m.detailsTitle = m.top.findNode("detailsTitle")
    m.detailsButtonsGrid = m.top.findNode("detailsButtonsGrid")
    setDetailsButtonsGridItem()
    m.detailsDescription = m.top.findNode("detailsDescription")
    setFocus()
    print "init of details"
end sub

function setDetailsScreen()
    print "setDetails function"
    m.detailsDescription.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum."
    itemInfo = m.top.detailsData
    ' print itemInfo
    m.detailsBackground.uri = itemInfo["image"]
    m.detailsTitle.text = itemInfo["title"]
    m.detailsTitle.font.size = 70
    m.detailsButtonsGrid.observeField("itemSelected","onButtonClicked")
end function

function setDetailsButtonsGridItem()
    buttons = detailsGridConfig()
    contentNode = CreateObject("roSGNode","ContentNode")
    for each item in buttons
        buttonNode = contentNode.createChild("ContentNode")
        buttonNode.title = item
    end for
    m.detailsButtonsGrid.content = contentNode
end function

function onButtonClicked(msg as object)
    print "onButtonClicked in details page"
    clickedButton = msg.getData()
    print clickedButton
    if clickedButton = 0
        m.top.videoContentData = {"title":m.detailsTitle.text,"url": "pkg://Videos/1h.mp4" ,"streamformat": "mp4"}
    end if
end function

function setFocus()
    m.detailsButtonsGrid.setFocus(true)
    showMainSceneCounter(true)
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press
        if key = "up"
            m.top.keyPressed = key
            return true
        else if key = "back"
            m.top.goBack = true
            return true
        end if
    end if

    print "Details Key Pressed"
end function
