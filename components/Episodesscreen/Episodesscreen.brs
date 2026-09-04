sub init()
    m.TVShowName = m.top.findNode("TVShowName")
    m.seasonsList = m.top.findNode("seasonsList")
    m.seasonsList.observeField("itemFocused","setSeasonTitle")
    m.currentSeason = m.top.findNode("currentSeason")
    m.episodesList = m.top.findNode("episodesList")
    m.counter = m.top.findNode("counter")
    setFocus()
end sub

function onShowID()
    showID = m.top.showID
    getSingleShowData(showID)
end function

function getSingleShowData(showID)
    serverTask = CreateObject("roSGNode","serverTask")
    serverTask.showID = showID
    serverTask.observeField("responseData","setEpisodeScreen")
    serverTask.functionName = "getEpisodeScreenData"
    serverTask.control = "run"
end function

function setEpisodeScreen(msg as object)
    responseData = msg.getData()
    tvShowData = responseData.data
    print responseData
    print tvShowData

    ' Set TVShow Title
    m.TVShowName.text = tvShowData.tvShowTitle

    ' Set Seasons List
    m.seasonsData = tvShowData.seasons
    contentNode = CreateObject("roSGNode","ContentNode")
    for each item in m.seasonsData
        itemNode = contentNode.createChild("ContentNode")
        itemNode.TITLE = "Season "+ item.seasonNumber
    end for
    m.seasonsList.content = contentNode

    ' #Myfirst Way of netflix representation of all episodes
'     episodeContentNode = CreateObject("roSGNode","ContentNode")
'     for each seasonItem in seasonsData
'         episodeData = seasonItem.episodes
'         for each item in episodeData
'             print " episode item = ", item
'             itemNode = episodeContentNode.createChild("ContentNode")
'             itemNode.title = "Episode " + item.episodeNumber
'             itemNode.HDPosterUrl = item.posterurl
'             ' itemNode.description = item.highlights
'         end for
'     end for
'     m.episodesList.content = episodeContentNode
end function

    ' Set Season Title
function setSeasonTitle(msg as object)
    seasonFocusedIndex = msg.getData()
    print "seasonFocusedIndex = " seasonFocusedIndex
    if seasonFocusedIndex > -1 and seasonFocusedIndex <> invalid
        seasonListItemFocused = m.seasonsList.content.getChild(seasonFocusedIndex)
        print "seasonListItemFocused = ", seasonListItemFocused
        m.currentSeason.text = seasonListItemFocused.title

        ' set Episodes List
        ' Raja's way of show only episodes of that season
        focusedSeason = m.seasonsData[seasonFocusedIndex]
        episodeData = focusedSeason.episodes
        episodeContentNode = CreateObject("roSGNode","ContentNode")
        for each item in episodeData
            itemNode = episodeContentNode.createChild("ContentNode")
            itemNode.title = "Episode " + item.episodeNumber
            itemNode.HDPosterUrl = item.posterurl
        end for
        m.episodesList.content = episodeContentNode
    end if
    m.episodesList.observeField("itemSelected","onEpisodeSelection")
end function

function onEpisodeSelection(msg as object)
    itemSelectedIndex = msg.getData()
    episodeSelected = m.episodesList.content.getChild(itemSelectedIndex)
    ' print episodeSelected
    m.top.videoContentData = {"title":episodeSelected.title,"url": "https://lorem.video/720p" ,"streamformat": "mp4"}
end function

function setFocus()
    m.seasonsList.setFocus(true)
    showMainSceneCounter(false)
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press 
        if key = "up"
            m.top.keyPressed = key
            return true
        end if
        if key = "back"
        m.top.goBack = true
        return true
        else if key = "right" and m.seasonsList.hasFocus()
            m.episodesList.setFocus(true)
        else if key = "left" and m.episodesList.hasFocus()
            m.seasonsList.setFocus(true)
        end if
    end if
end function