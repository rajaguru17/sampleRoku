sub init()
    ' m.api = "http://10.1.10.190:5050/"
    m.api = "http://192.168.8.179:5050/"
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
    postContent(url, { text: m.top.searchQuery })
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

function getSingleMovieData()
    url = m.api + "moviesRowListData/" + m.global.deepLink.contentId
    getContent(url)
end function

function getTVShowsGridData()
    url = m.api + "tvShowData"
    getContent(url)
end function

function getEpisodeScreenData()
    ' print "showID type = ",type(m.top.showID)
    ' print "showID in serverTask = ", m.top.showID
    url = m.api + "tvShowData/" + m.top.showID
    ' print "url =",url
    getContent(url)
end function

function validateCredentials()
    url = m.api + "login"
    postContent(url, { email: m.top.loginID, password: m.top.password })
end function

function getContent(link)
    ' print "Link **** ",link
    urlObject = CreateObject("roUrlTransfer")
    if m.global.accessToken <> invalid
        urlObject.AddHeader("accessToken",m.global.accessToken)
    end if
    urlObject.setRequest("GET")
    urlObject.SetUrl(link)
    port = CreateObject("roMessagePort")
    urlObject.SetMessagePort(port)

    if urlObject.AsyncGetToString()
        msg = wait(0, port)
        if type(msg) = "roUrlEvent"
            responseData = msg.getString()
            ' print "RD = ",responseData
            response = ParseJson(responseData)
            ' print "R = ",response
            m.top.responseData = response
        end if
    end if
end function

sub postContent(link as String, body as Object)
    urlObject = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    urlObject.SetMessagePort(port)
    urlObject.SetUrl(link)
    urlObject.AddHeader("Content-Type", "application/json")
    urlObject.RetainBodyOnError(true)   ' keep the JSON body on 401/400

    if not urlObject.AsyncPostFromString(FormatJson(body))
        m.top.responseData = { success: false, statusCode: 0, message: "Request could not start" }
        return
    end if

    msg = wait(10000, port)   ' 10s timeout instead of waiting forever
    if msg = invalid
        urlObject.AsyncCancel()
        m.top.responseData = { success: false, statusCode: 0, message: "Server timed out" }
        return
    end if

    if type(msg) = "roUrlEvent"
        code = msg.GetResponseCode()
        response = ParseJson(msg.GetString())
        if type(response) <> "roAssociativeArray" then response = {}
        response.statusCode = code

        if code < 200 or code >= 300
            response.success = false
            if response.message = invalid then response.message = msg.GetFailureReason()
        end if

        m.top.responseData = response
    end if
end sub
' function searchContent(link)
'     ' print "Post Link=",link
'     urlObject = CreateObject("roUrlTransfer")
'     urlObject.setRequest("POST")
'     urlObject.SetUrl(link)
'     port = CreateObject("roMessagePort")
'     urlObject.SetMessagePort(port)

'     urlObject.AddHeader("Content-Type","application/json")
'     searchText = m.top.searchQuery
'     requestBody = { text:searchText }
'     jsonString = FormatJson(requestBody)

'     urlObject.AsyncPostFromString(jsonString)

'     msg = wait(0, port)
'      if type(msg) = "roUrlEvent"
'         responseCode = msg.GetResponseCode()

'         if responseCode = 200
'             responseString = msg.GetString()
'             parsedResponse = ParseJson(responseString)
'             m.top.responseData = parsedResponse

'             if parsedResponse.success = true
'                 results = parsedResponse.data
'                 print "Found "; results.Count(); " matching profiles"
'                 ' return results
'             end if
'         else
'             print "Error: response code "; responseCode
'         end if
'     end if
' end function