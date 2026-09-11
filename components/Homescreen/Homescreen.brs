sub init()
    m.rowList1 = m.top.findNode("rowList1")

    m.rowPageSize  = 4
    m.itemPageSize = 5
    m.prefetch     = 2
    m.labelHeight  = 40

    m.content = CreateObject("roSGNode", "ContentNode")
    m.rowList1.content = m.content

    m.rowHeights     = []
    m.rowItemSize    = []
    m.rowItemSpacing = []
    m.rowLabelOffset = []
    m.showRowCounter = []

    m.rowMeta     = []
    m.totalRows   = 0
    m.rowsLoading = false
    m.tasks       = {}

    m.rowList1.observeField("rowItemFocused",  "onRowItemFocused")
    m.rowList1.observeField("rowItemSelected", "onRowItemSelected")

    requestPage(0, m.rowPageSize, 0, m.itemPageSize)
    setFocus()
end sub

sub requestPage(rowStart , rowCount , itemStart, itemCount)
    key = rowStart.toStr() + "_" + itemStart.toStr()
    if m.tasks[key] <> invalid then return   

    task = CreateObject("roSGNode", "serverTask")
    task.functionName = "getHomeRows"
    task.rowStart  = rowStart
    task.rowCount  = rowCount
    task.itemStart = itemStart
    task.itemCount = itemCount
    task.observeField("responseData", "onPage")
    m.tasks[key] = task
    task.control = "run"
end sub


sub onPage(msg as object)
    r = msg.getData()

    if r = invalid or r.data = invalid
        m.rowsLoading = false
        print "onPage: bad response"
        return
    end if

    rowStart  = r.rowStart
    itemStart = r.itemStart

    key = rowStart.toStr() + "_" + itemStart.toStr()
    if m.tasks[key] <> invalid
        m.tasks[key].unobserveField("responseData")
        m.tasks.delete(key)
    end if

    m.totalRows = r.totalRows

    for i = 0 to r.data.count() - 1
        rowIndex = rowStart + i
        rowData  = r.data[i]

        if rowIndex >= m.content.getChildCount()
            addRow(rowData)
        end if
        appendItems(rowIndex, rowData)
    end for
    if itemStart = 0 then m.rowsLoading = false
end sub


sub addRow(rowData as Object)
    ' sizes MUST be in place before the row child is created
    m.rowHeights.push(rowData.height + m.labelHeight)
    m.rowItemSize.push([rowData.width, rowData.height])
    m.rowItemSpacing.push([20, 20])
    m.rowLabelOffset.push([0, 20])
    m.showRowCounter.push(true)

    m.rowList1.rowHeights     = m.rowHeights
    m.rowList1.rowItemSize    = m.rowItemSize
    m.rowList1.rowItemSpacing = m.rowItemSpacing
    m.rowList1.rowLabelOffset = m.rowLabelOffset
    m.rowList1.showRowCounter = m.showRowCounter

    row = m.content.createChild("ContentNode")
    row.title = rowData.title

    m.rowMeta.push({
        totalItems: rowData.totalItems,
        loaded:     0,
        loading:    false,
        width:      rowData.width,
        height:     rowData.height
    })
end sub


sub appendItems(rowIndex as Integer, rowData as Object)
    row  = m.content.getChild(rowIndex)
    meta = m.rowMeta[rowIndex]
    if row = invalid or meta = invalid then return

    if rowData.items <> invalid
        for each item in rowData.items
            itemNode = row.createChild("CustomContentNode")
            itemNode.width       = meta.width
            itemNode.height      = meta.height
            itemNode.title       = item.text
            itemNode.HDPosterUrl = item.posterurl
            itemNode.itemData    = item
            itemNode.isViewAll   = false
        end for
        meta.loaded = row.getChildCount()
    end if

    meta.loading = false
end sub


sub onRowItemFocused(msg as object)
    d = msg.getData()
    if d = invalid then return

    rowIndex  = d[0]
    itemIndex = d[1]
    if rowIndex < 0 or itemIndex < 0 then return   ' fires [-1,-1] during setup

    ' ---- horizontal: more items in THIS row ----
    meta = m.rowMeta[rowIndex]
    if meta <> invalid
        if not meta.loading and meta.loaded < meta.totalItems and itemIndex >= meta.loaded - m.prefetch
            meta.loading = true
            requestPage(rowIndex, 1, meta.loaded, m.itemPageSize)
        end if
    end if

    ' ---- vertical: more rows ----
    loadedRows = m.content.getChildCount()
    if not m.rowsLoading and loadedRows < m.totalRows and rowIndex >= loadedRows - m.prefetch
        m.rowsLoading = true
        requestPage(loadedRows, m.rowPageSize, 0, m.itemPageSize)
    end if
end sub


sub onRowItemSelected(msg as object)
    d = msg.getData()
    if d = invalid then return

    rowNode = m.content.getChild(d[0])
    if rowNode = invalid then return
    itemNode = rowNode.getChild(d[1])
    if itemNode = invalid then return

    info = itemNode.itemData
    if info = invalid then return

    if info.tags = "LIVE"
        m.top.videoContentData = { title: info.id, url: "https://lorem.video/720p", streamformat: "mp4", LIVE: true }
    else
        m.top.detailsData = { title: info.id, image: info.posterurl }
    end if
end sub


' function getRowItems(rowIndex as Integer) as Object
'     items = []
'     row = m.content.getChild(rowIndex)
'     if row = invalid then return items
'     for i = 0 to row.getChildCount() - 1
'         items.push(row.getChild(i).itemData)
'     end for
'     return items
' end function


function onKeyEvent(key as String, press as Boolean) as Boolean
    if not press then return false

    if key = "up"
        m.top.keyPress = key
        return true
    end if

    return false
end function


sub setFocus()
    m.rowList1.setFocus(true)
    showMainSceneCounter(true)
end sub

