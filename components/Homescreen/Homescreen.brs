function init()
    m.rowList1 = m.top.findNode("rowList1")
    m.rowList1.setFocus(true)
end function


function setRow()
    rowData = m.top.rowData
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
        if key = "up"
            m.top.keyPress = key
            return true
        else if key = "down" and m.rowList1.currFocusRow = 3 and m.rowList1.hasFocus()
            rowItemFocused = m.rowList1.rowItemFocused
            m.rowList1.jumpToRowItem = [0,rowItemFocused[1]]
            m.rowList1.animateToRowItem = 0
        end if
    end if
end function

function setFocus()
    m.rowList1.setFocus(true)
end function