function init()
    m.background = m.top.findNode("background")
    setBackground()
    m.movieGrid = m.top.findNode("movieGrid")
    setMovieGrid()
    m.screenContainer = m.top.findNode("screenContainer")
    showHomeScreen()

    ' background = m.top.findNode("background")
    ' background.color = "0x000000"
    ' background.width = 1920
    ' background.height = 1080
    ' background.translation = [0, 0]

    ' createLabel()
    ' createLayoutGroupLabel()
    ' label = m.top.findNode("label")
    ' label.text = loadingText()
end function

function showHomeScreen()
    screen = CreateObject("roSGNode", "Homescreen")
    rowData = rowItemConfigWithSizes()
    screen.rowData = rowData
    screen.observeField("keyPress", "onKeyPress")
    pushToStack(screen)
end function

function pushToStack(screen)
    m.screenContainer.appendChild(screen)
end function

function onKeyPress(msg as object)
    keyPress = msg.getData()
    if keyPress = "up"
        m.movieGrid.setFocus(true)
    end if
end function
' function createLabel()
'     labelGroup = m.top.findNode("labelGroup")
'     label = createObject("roSGNode", "Label")
'     label.id = "label"
'     label.text = loadingText()
'     label.color = "0xFFFFFFFF"
'     label.font = "font:MediumBoldSystemFont"
'     labelGroup.appendChild(label)
' end function

function setBackground()
    m.background.color = "0x000000"
    m.background.width = 1920
    m.background.height = 1080
    m.background.translation = [0, 0]
end function

' function createLayoutGroupLabel()
'     layoutGroup = m.top.findNode("layoutGroup")
'     labelObj = [{"text": "Label 1"}, {"text": "Label 2"}, {"text": "Label 3"},{"text": "Label 4"}, {"text": "Label 5"}, {"text": "Label 6"}]
'     ' labelObj.SortBy("text", "r")
'     labelObj.Reverse()
'     for each labelItem in labelObj
'         newLabel = createObject("roSGNode", "Label")
'         newLabel.text = labelItem.text
'         newLabel.color = "0xFFFFFFFF"
'         newLabel.font = "font:MediumBoldSystemFont"
'         layoutGroup.appendChild(newLabel)
'     end for
'     'NOTE: commented the below one for testing purpose
'     ' for i = labelObj.count() - 1 to 0 step -1
'     '     labelItem = labelObj[i]
'     '     newLabel = createObject("roSGNode", "Label")
'     '     newLabel.id = "layoutLabel_" + i.toStr()
'     '     newLabel.text = labelItem.text
'     '     newLabel.color = "0xFFFFFFFF"
'     '     newLabel.font = "font:MediumBoldSystemFont"
'     '     layoutGroup.appendChild(newLabel)
'     ' end for
' end function

function setMovieGrid()
    gridData = markUpConfig()
    contentNode = createObject("roSGNode", "ContentNode")
    for each item in gridData
        itemNode = contentNode.createChild("ContentNode")
        itemNode.title = item.text
        itemNode.HDPosterUrl = item.posterurl
    end for
    m.movieGrid.content = contentNode
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    
    if press

        print key
        print press
        if key = "down" and m.movieGrid.hasFocus()
            setTopChildFocus()
        end if
    
    end if

end function

function setTopChildFocus()
    screenCount = m.screenContainer.getChildCount()
    topChild = m.screenContainer.getChild(screenCount - 1)
    topChild.isFocused = true
end function