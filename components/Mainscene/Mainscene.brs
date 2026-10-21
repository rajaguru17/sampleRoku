function init()
    m.global.accessToken = readKeyInReg("accessToken")
    m.counter = m.top.findNode("counter")
    m.profileIcon = m.top.findNode("profileIcon")
    m.iconImage = m.top.findNode("iconImage")
    m.userName = m.top.findNode("userName")
    m.switchProfile = m.top.findNode("switchProfile")
    ' m.searchField = m.top.findNode("searchField")
    m.searchButton = m.top.findNode("searchButton")
    m.background = m.top.findNode("background")
    setBackground()
    m.movieGrid = m.top.findNode("movieGrid")
    m.movieGrid.observeField("itemSelected","onMenuGridItemSelected")
    getMenuGrid()
    ' setMovieGrid()
    m.screenContainer = m.top.findNode("screenContainer")
    print "17th line ->",m.global.accessToken
    if hasAccessToken()
        showProfileScreen()
    else
        showHomeScreen()
    end if
    ' getProfiles()
    m.counterValue = 0
    ' m.deepLink = true
    ' 
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

function counterVisibility(isVisible)
    m.counter.visible = isVisible
end function

function setBackground()
    m.background.color = "0x000000"
    m.background.width = 1920
    m.background.height = 1080
    m.background.translation = [0, 0]
end function

function showProfileScreen()
    screen = CreateObject("roSGNode", "Profilescreen")
    'screen.rowData = rowItemConfigWithSizes()
    'screen.rowData = rowData
    screen.observeField("currentSelectionData", "onProfileSelection")
    
    pushToStack(screen)
end function

function onProfileSelection(msg as object)
    profileData = msg.getData()
    m.switchProfile.font.size = 20
    m.userName.font.size = 30
    m.iconImage.uri = profileData.poster
    m.userName.text = profileData.username
    m.switchProfile.visible = true
    ' print profileData
    removeFromStack()
    showHomeScreen()
end function

function showHomeScreen()
    screen = CreateObject("roSGNode", "Homescreen")
    ' screen.rowData = responseData.data
    'screen.rowData = rowData
    screen.observeField("keyPress", "onKeyPress")
    screen.observeField("viewMoreData","showViewMoreScreen")
    screen.observeField("videoContentData","showVideoScreen")
    screen.observeField("detailsData","showDetailsScreen")
    screen.observeField("deepLinkTVShowNav","showTVShowsScreen")
    pushToStack(screen)
    if m.global.deepLink <> invalid and (m.global.deepLink.mediaType = "season" or m.global.deepLink.mediaType = "episode" or m.global.deepLink.mediaType = "series")
        showID = m.global.deepLink.contentID
        createEpisodeScreen(showID)
        print "createEpisodeScreen in showHomeScreen"
    end if 
end function
function showMoviesScreen()
    print "entered showMoviesScreen"
    screen = CreateObject("roSGNode","Moviesscreen")
    screen.observeField("keyPressed", "onKeyPress")
    screen.observeField("goBack","goBackToHomeScreen")
    screen.observeField("detailsData","showDetailsScreen")
    pushToStack(screen)
end function
function showTVShowsScreen()
    print "entered showTVShowsScreen"
    screen = CreateObject("roSGNode","TVShowsScreen")
    screen.observeField("showID","showEpisodesScreen")
    screen.observeField("keyPressed","onKeyPress")
    screen.observeField("goBack","goBackToHomeScreen")
    pushToStack(screen)
end function

function showEpisodesScreen(msg as object)
    print "entered showEpisodesscreen"
    showID = msg.getData()
    createEpisodeScreen(showID)
end function

function createEpisodeScreen(showID)
    print "entered createEpisodeScreen"
    screen = CreateObject("roSGNode","Episodesscreen")
    screen.observeField("goBack","goBackToHomeScreen")
    screen.observeField("keyPressed","onKeyPress")
    screen.observeField("videoContentData","showVideoScreen")
    screen.showID = showID
    pushToStack(screen)
end function
function showViewMoreScreen(msg as object)
    screen = CreateObject("roSGNode","Viewmorescreen")
    viewMoreData = msg.getData()
    screen.viewMoreData = viewMoreData
    screen.observeField("goBack","goBackToHomeScreen")
    screen.observeField("keyPressed","onKeyPress")
    screen.observeField("detailsData","showDetailsScreen")
    pushToStack(screen)
end function
function showDetailsScreen(msg as object)
    screen = CreateObject("roSGNode","Detailsscreen")
    detailsData = msg.getData()
    screen.observeField("goBack","goBackToHomeScreen")
    screen.observeField("keyPressed","onKeyPress")
    screen.observeField("videoContentData","showVideoScreen")
    screen.detailsData = detailsData
    pushToStack(screen)
end function

function showVideoScreen(msg as object)
    if hasAccessToken()
        screen = CreateObject("roSGNode","Videoscreen")
        screen.videoContentData = msg.getData()
        screen.observeField("goBack","goBackToHomeScreen")
        pushToStack(screen)
    else 
        m.fromMenu = false
        showLoginScreen()
    end if
end function

function showSearchScreen()
    print "entered showSearchScreen"
    screen = CreateObject("roSGNode","searchScreen")
    screen.observeField("goBack","goBackToHomeScreen")
    screen.observeField("keyPressed","onKeyPress")
    screen.observeField("detailsData","showDetailsScreen")
    pushToStack(screen)
end function
function showLoginScreen()
    screen = CreateObject("roSGNode","LoginScreen")
    screen.observeField("loginSuccess","onLoginSuccess")
    screen.observeField("goBack","goBackToHomeScreen")
    pushToStack(screen)
    setTopChildFocus()
end function

sub onLoginSuccess()
    getMenuGrid()
    if m.fromMenu
        removeAllFromStack()
        showProfileScreen()
        return
    else
        removeFromStack()
        screenCount = m.screenContainer.getChildCount()
        topChild = m.screenContainer.getChild(screenCount - 1)
        topChild.callFunc("moveToVideo")
    end if
    setTopChildFocus()
end sub

function getMenuGrid()
    serverTask = CreateObject("roSGNode","serverTask")
    serverTask.observeField("responseData","setMovieGrid")
    serverTask.functionName = "getMenuGridConfig"
    serverTask.control = "run"
end function

function setMovieGrid(msg as object)
    responseData = msg.getData()
    gridData = responseData.data
    m.lastMenuItemIndex = gridData.count() - 1
    contentNode = createObject("roSGNode", "ContentNode")
    for each item in gridData
        itemNode = contentNode.createChild("ContentNode")
        itemNode.title = item.text
        ' itemNode.HDPosterUrl = item.posterurl
    end for
    m.movieGrid.content = contentNode

end function

function onMenuGridItemSelected(msg as object) as void
    print "onMenuGridItemSelected"
    menuItemSelected = msg.getData()
    print menuItemSelected
    if menuItemSelected = 0
        ' fakeMsg = {
        '     data: true
        '     getData: function() as dynamic
        '         return m.data
        '     end function
        ' }
        ' goBackToHomeScreen(fakeMsg)
        ' add removeFromStack Loop
    else if menuItemSelected = 1
        showMoviesScreen()
    else if menuItemSelected = 2
        showTVShowsScreen()
    else if menuItemSelected = 4
        showSearchScreen()
    else if menuItemSelected = 6
        logInButton = m.movieGrid.content.getChild(menuItemSelected)
        if logInButton.title = "Log Out"
            print "---entering the right LogOUT---"
            m.global.accessToken = invalid
            deleteKeyInReg("accessToken")
            m.profileIcon.visible = false
            getMenuGrid()
            return
        end if
        m.fromMenu = true
        showLoginScreen()
    else if menuItemSelected = m.movieGrid.content.getChildCount() - 2
        m.counterValue ++
        showCounter()
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
function goBackToHomeScreen(msg as object)
    getBackData = msg.getData()
    ' print getBackData
    if getBackData = true
        removeFromStack()
        setTopChildFocus()
    end if
end function

function removeFromStack()
    screenCount = m.screenContainer.getChildCount()
    topChild = m.screenContainer.getChild(screenCount - 1)
    m.screenContainer.removeChild(topChild)
end function

function removeAllFromStack()
    for i = 1 to m.screenContainer.getChildCount()
        removeFromStack()
    end for
end function

function pushToStack(screen)
    m.screenContainer.appendChild(screen)
end function

function setTopChildFocus()
    screenCount = m.screenContainer.getChildCount()
    topChild = m.screenContainer.getChild(screenCount - 1)
    topChild.isFocused = true
end function

function onKeyPress(msg as object)
    keyPress = msg.getData()
    if keyPress = "up"
        m.movieGrid.setFocus(true)
    end if
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press
        print key,"down Handled here"
        if key = "down" and m.movieGrid.hasFocus()
            setTopChildFocus()
        end if
        if key = "back"
            return true
        end if
    end if

end function
