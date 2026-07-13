function init()
    m.background = m.top.findNode("background")
    setBackground()
    m.rowList = m.top.findNode("rowList")
    setRowItems()
    m.rowList.setFocus(true)
    m.rowList1 = m.top.findNode("rowList1")
    setRow()
    m.rowList1.setFocus(true)
    m.movieGrid = m.top.findNode("movieGrid")
    setMovieGrid()
    m.movieGrid.setFocus(true)

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

function setRowItems()
    rowData = rowItemConfig()
    rowKeys = rowData.keys()
    contentNode = createObject("roSGNode", "ContentNode")
    for each rowKey in rowKeys
        row = contentNode.createChild("ContentNode")
        row.title = rowKey
        rowItems = rowData[rowKey]
        for each item in rowItems
            itemNode = row.createChild("ContentNode")
            itemNode.title = item.text
            itemNode.HDPosterUrl = item.posterurl
        end for
    end for
    m.rowList.content = contentNode
end function

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


function setRow()
    rowData = rowItemConfigWithSizes()
    contentNode = createObject("roSGNode", "ContentNode")
    rowHeights = []
    rowItemSize = []
    offset = []
    rowItemSpacing = []
    RowCounterArr = []
    
    print rowData
    for each rowItem in rowData
        print rowItem
        row = contentNode.createChild("ContentNode")
            row.title = rowItem.title
            rowHeights.push(rowItem.height)
            rowItemSize.push([rowItem.width, rowItem.height])
            offset.push([ 0, 20 ])
            rowItemSpacing.push([20,20])
            
            RowCounterArr.push(true)
        
        for i = 0 to rowItem.items.count() - 1
            item = rowItem.items[i]
            itemNode = row.createChild("CustomContentNode")
            itemNode.width = rowItem.width
            itemNode.height = rowItem.height

            if  i = 5
                itemNode.title = "View More"
                itemNode.HDPosterUrl = ""
                itemNode.isViewAll = true
                exit for
            else    
                itemNode.title = item.text
                itemNode.HDPosterUrl = item.posterurl
                itemNode.itemData = item 
            end if       
        end for
       end for

    m.rowList1.rowHeights = rowHeights
    m.rowList1.rowItemSize = rowItemSize
    m.rowList1.rowItemSpacing = rowItemSpacing
    m.rowList1.rowLabelOffset = offset
    m.rowList1.showRowCounter = RowCounterArr
    m.rowList1.content = contentNode

end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    
    if press

        print key
        print press
        if key = "down" and m.movieGrid.hasFocus()
            m.rowList1.setFocus(true)
        else if key = "up" and m.rowList1.hasFocus()
            m.movieGrid.setFocus(true)

        end if
        print m.rowList1.getFields()
        if key = "down" and m.rowList1.currFocusRow = 3 and m.rowList1.hasFocus()
            rowItemFocused = m.rowList1.rowItemFocused
            m.rowList1.jumpToRowItem = [0,rowItemFocused[1]]
            m.rowList1.animateToRowItem = 0
        end if
    
    end if

end function