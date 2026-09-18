sub init()
    ' m.api = "http://10.1.10.190:5050/"
    m.api = "http://192.168.8.232:5050/"
    ' print "inside of init serverTask"
end sub

function getProfileGridConfig()
    url = m.api + "profileGridConfig"
    getContent(url)
end function

function getProfileSliderData()
    url = m.api + "profileSliderData"
    getContent(url)
end function

function getMenuGridConfig()
    print "inside menuGridConfig"
    url = m.api + "menuGridConfig"
    getContent(url)
end function

' function getRowListData()
'     page = "?page="+m.top.page.toStr()
'     limit = "&limit="+m.top.limit.toStr()
'     item = "&limit="+m.top.item.toStr()
'     itemLimit= "&itemLimit="+m.top.itemLimit.toStr()
'     params = page + limit + item + itemLimit
'     url = m.api + "homeScreenSetup" +params
'     getContent(url)
' end function

function getHomeRows()
    rowStart = "?rowStart="  + m.top.rowStart.toStr()
    rowCount = "&rowCount="  + m.top.rowCount.toStr()
    itemStart = "&itemStart=" + m.top.itemStart.toStr()
    itemCount = "&itemCount=" + m.top.itemCount.toStr()
    params = rowStart + rowCount + itemStart + itemCount
    url = m.api + "homeRows" + params
    print "getHomeRows url = "; url
    getContent(url)
end function

function getSearchedContent()
    url = m.api + "allContent"
    postContent(url)
end function

' function getMoviesScreenGridData()
'     url = m.api + "moviesScreenData"
'     getContent(url)
' end function    

function getMoviesRowListData()
    page = "?page="+m.top.page.toStr()
    limit = "&limit="+m.top.limit.toStr()
    params = page+limit
    url = m.api + "moviesRowListData" + params
    getContent(url)
end function

function getTVShowsGridData()
    url = m.api + "tvShowData"
    getContent(url)
end function

function getEpisodeScreenData()
    print "showID type = ",type(m.top.showID)
    print "showID in serverTask = ", m.top.showID
    url = m.api + "tvShowData/" + m.top.showID
    print "url =",url
    getContent(url)
end function

function getContent(link)
    ' print "Link **** ",link
    urlObject = CreateObject("roUrlTransfer")
    urlObject.setRequest("GET")
    urlObject.SetUrl(link)
    port = CreateObject("roMessagePort")
    urlObject.SetMessagePort(port)

    if urlObject.AsyncGetToString()
        msg = wait(0, port)
        if type(msg) = "roUrlEvent"
            responseData = msg.getString()
            ' print responseData
            response = ParseJson(responseData)
            m.top.responseData = response
        end if
    end if
end function

function postContent(link)
    print "Post Link=",link
    urlObject = CreateObject("roUrlTransfer")
    urlObject.setRequest("POST")
    urlObject.SetUrl(link)
    port = CreateObject("roMessagePort")
    urlObject.SetMessagePort(port)

    urlObject.AddHeader("Content-Type","application/json")
    searchText = m.top.searchQuery
    requestBody = { text:searchText }
    jsonString = FormatJson(requestBody)

    urlObject.AsyncPostFromString(jsonString)

    msg = wait(0, port)
     if type(msg) = "roUrlEvent"
        responseCode = msg.GetResponseCode()

        if responseCode = 200
            responseString = msg.GetString()
            parsedResponse = ParseJson(responseString)
            m.top.responseData = parsedResponse

            if parsedResponse.success = true
                results = parsedResponse.data
                print "Found "; results.Count(); " matching profiles"
                ' return results
            end if
        else
            print "Error: response code "; responseCode
        end if
    end if
end function