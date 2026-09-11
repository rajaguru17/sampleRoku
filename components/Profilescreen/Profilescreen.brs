sub init()
    m.profileBackgroundPicture = m.top.findNode("profileBackgroundPicture")
    m.metaDataTitle = m.top.findNode("metaDataTitle")
    m.metaDataGenre = m.top.findNode("metaDataGenre")
    m.metaDataHighlight = m.top.findNode("metaDataHighlight")
    
    m.sliderTimer = m.top.findNode("sliderTimer")
    m.sliderTimer.observeField("fire","onSliderChange")
    m.profileChooseProfileInfo = m.top.findNode("profileChooseProfileInfo")

    m.profileScreen = m.top.findNode("profilesBackground")
    setProfilesBackground()
    m.profilesMarkUpGrid = m.top.findNode("profilesMarkUpGrid")
    ' setProfilesMarkUpGrid()
    getProfiles()
   
    showProfilescreen()
    m.sliderTimer.control = "start"
end sub

function setProfilesBackground()
        m.profileChooseProfileInfo.font.size = 24
        m.profileScreen.width = 1920
        m.profileScreen.height = 1080
        m.profileScreen.translation = [0,0]
        m.profileScreen.color = "#000000"
        ' m.profileSliders  = profileSliders()
        m.profileSlidersIndex = 0
        getProfileSlider()
        ' setProfileSlider()
end function

function getProfiles()
    serverTask = CreateObject("roSGNode","serverTask")
    serverTask.observeField("responseData","setProfilesMarkUpGrid")
    serverTask.functionName = "getProfileGridConfig"
    serverTask.control = "run"
end function

function getProfileSlider()
    serverTask = CreateObject("roSGNode","serverTask")
    serverTask.observeField("responseData","getProfileSliderData")
    serverTask.functionName = "getProfileSliderData"
    serverTask.control = "run"
end function

function getProfileSliderData(msg as object)
    responseData = msg.getData()
    m.totalNumberOfSliderImages = responseData.data.count()
    m.profileSliderData = responseData.data
    setProfileSlider()
end function

function setProfileSlider()
    individualSlider = m.profileSliderData[m.profileSlidersIndex]
    m.profileBackgroundPicture.uri = individualSlider.backgroundurl
    m.metaDataTitle.font.size = 100
    m.metaDataTitle.text = individualSlider.title
    m.metaDataGenre.text = individualSlider.genre.Join(" . ")
    m.metaDataHighlight.font.size = 25
    m.metaDataHighlight.text = individualSlider.highlights
end function

function setProfilesMarkUpGrid(msg as object)
    responseData = msg.getData()
    profilesGridData = responseData.data
    contentNode = createObject("roSGNode", "ContentNode")
    for each item in profilesGridData
        itemNode = contentNode.createChild("ContentNode")
        itemNode.title = item.text
        itemNode.HDPosterUrl = item.posterurl
    end for
    m.profilesMarkUpGrid.content = contentNode
    m.profilesMarkUpGrid.observeField("itemSelected","screenChangeFunc")
    
end function 

function screenChangeFunc()
    currentChildIndex = m.profilesMarkUpGrid.itemSelected
    currentProfileSelection = m.profilesMarkUpGrid.content.getChild(currentChildIndex)
    image = currentProfileSelection.HDPosterUrl
    text = currentProfileSelection.title
    m.top.currentSelectionData = { "poster": image, "username": text }
end function

function onSliderChange()
    m.profileSlidersIndex++
    if m.profileSlidersIndex > m.totalNumberOfSliderImages - 1
        m.profileSlidersIndex = 0
    end if
    setProfileSlider()
end function

function showProfilescreen()
    m.profilesMarkUpGrid.setFocus(true)
    showMainSceneCounter(false)
end function