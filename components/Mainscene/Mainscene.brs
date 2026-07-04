function init()
    m.background = m.top.findNode("background")
    setBackground()
    m.rowList = m.top.findNode("rowList")
    setRowItems()
    m.rowList.setFocus(true)
    m.rowList1 = m.top.findNode("rowList1")
    setRow()
    m.rowList1.setFocus(true)
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

function setRow()
    rowData = rowItemConfigWithSizes()
    contentNode = createObject("roSGNode", "ContentNode")
    rowHeights = []
    rowItemSize = []
    for each rowItem in rowData
        row = contentNode.createChild("ContentNode")
        row.title = rowItem.title
        rowHeights.push(rowItem.height)
        rowItemSize.push([rowItem.width, rowItem.height])
        for each item in rowItem.items
            itemNode = row.createChild("CustomContentNode")
            itemNode.title = item.text
            itemNode.HDPosterUrl = item.posterurl
            itemNode.width = rowItem.width
            itemNode.height = rowItem.height
        end for
    end for
    m.rowList1.rowHeights = rowHeights
    m.rowList1.rowItemSize = rowItemSize
    m.rowList1.content = contentNode
end function