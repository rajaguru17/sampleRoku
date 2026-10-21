sub init()
    'Initializations
    m.saved_times = {}
    m.moveValue = 0
    m.moveBtn = ""
    m.midRoll = false
    'findNode's
    m.videoBackground = m.top.findNode("videoBackground")       'video
    m.videoPlayer = m.top.findNode("videoPlayer")
    m.videoTimer = m.top.findNode("videoTimer")
    m.UI =m.top.findNode("UI")                                  'UI                                 
    m.grayBar=m.top.findNode("grayBarRectangle")                'progressbar
    m.progressBar=m.top.findNode("progreessingBarRectangle")
    m.buttonsGrid = m.top.findNode("videoButtonsGrid")          'buttons
    m.runTime = m.top.findNode("runTime")                       'time
    m.totalDuration = m.top.findNode("totalDuration")
    m.buttonsTimer = m.top.findNode("buttonsTimer")
    m.seekTimer = m.top.findNode("seekTimer")
    m.moveTimer = m.top.findNode("moveTimer")
    m.titleInfo = m.top.findNode("titleInfo")                   'infoBox
    m.episodeInfo = m.top.findNode("episodeInfo")
    'Buttons setup
    setButtonGrid()
    'observers
    m.buttonsGrid.observeField("itemSelected","onButtonClicked")
    m.videoTimer.observeField("fire","setFocus")
    m.videoPlayer.observeField("position", "onPlaying")
    m.videoPlayer.observeField("state","onStateChanged")
    m.buttonsTimer.observeField("fire","fadeOutUI")
    m.seekTimer.observeField("fire","seeking")
    m.moveTimer.observeField("fire","onMoving")
    
    'TEMP
end sub 

function onStateChanged(msg as object)
    respondeData = msg.getData()
    ' print "state=",respondeData
    if respondeData = "finished"
        RAF_custom()
    end if
end function

function RAF_custom()
    rafTask = CreateObject("roSGNode","RAFTask")
    rafTask.observeField("shouldPlayContent","showVideo")
    ' rafTask.adPods = m.adPods
    if m.myAdUrl <> invalid then rafTask.myAdUrl = m.myAdUrl else showVideo()
    rafTask.adHolder = m.top.getScene()
    rafTask.functionName = "control_play"
    print "rafTask Boolean = ",rafTask.shouldPlayContent
    rafTask.control = "run"
end function

function setVideoData(msg as object)
    m.videoData = msg.getData()
    RAF_custom()
end function

function showVideo() as void
    if m.videoPlayer.state = "finished"
        m.top.goBack = true
    end if

    if m.midRoll:
        print "entering midroll"
        m.videoPlayer.seek = m.currentPlayBackTime
        m.videoPlayer.control = "play"
        m.videoPlayer.setFocus(true)
        m.midRoll = false
        return
    end if

    'Initial setup
    setFocus()
    'Video
    videoContent = CreateObject("RoSGNode","ContentNode")
    print "videoData = ",m.videoData
    videoContent.url = m.videoData.url ' 1hour link-> "http://192.168.8.152:5050/video.mp4"
    videoContent.title = m.videoData.title
    videoContent.streamformat = m.videoData.streamformat

    'info box setup
    m.titleInfo.font.size = 50
    m.titleInfo.text = m.videoData.title
    if m.videoData.season <> invalid and m.videoData.episode <> invalid
        m.episodeInfo.text = m.videoData.season+":"+m.videoData.episode
    end if

    'Video Player attributes
    m.videoPlayer.content = videoContent
    m.videoPlayer.control = "play"
    m.videoPlayer.enableUI = False
    m.videoPlayer.enableTrickPlay = False
    m.videoTimer.control ="start"

    'Exceptions
    if m.videoData.LIVE = true
        m.videoPlayer.enableUI = false
        m.videoPlayer.enableTrickPlay = false
    end if

    'Timer setup
    m.buttonsTimer.control = "start"

end function

function fadeOutUI()
    m.UI.visible=false
    m.videoPlayer.setFocus(true)
end function

function onPlaying()
    m.midPoint = int(m.videoPlayer.duration/2)
    'Time setup
    videoLength= m.videoPlayer.duration
    currentPosition = m.videoPlayer.position
    m.runTime.text = changeTimeFormat(m.videoPlayer.position)
    if m.totalDuration.text = ""
        m.totalDuration.text = changeTimeFormat(videoLength)
    end if
    'Progress bar setup
    progressWidth = (currentPosition / videoLength) * m.grayBar.width
    if progressWidth > m.grayBar.width
        progressWidth = m.grayBar.width
    end if
    if progressWidth < 0
        progressWidth = 0
    end if
    m.progressBar.width=progressWidth

    if m.videoPlayer.position = m.midPoint
        m.currentPlayBackTime = m.videoPlayer.position
        m.midRoll = true
        RAF_custom()
    end if
end function

function setButtonGrid()
    buttonData = [
    { id: "restart", text: "Play From Beginning", icon: "pkg:/images/buttons/restart.png"  },
    { id: "play",    text: "Pause",                icon: "pkg:/images/buttons/pause.png" },
    { id: "audiosubs",   text: "Audio & Subtitles",   icon: "pkg:/images/buttons/audiosubs.png" }
    ]
    contentNode = CreateObject("roSGNode","ContentNode")
    for each item in buttonData:
        button = contentNode.createChild("ContentNode")
        ' button.title = item.text
        button.HDPosterUrl = item.icon
        button.id = item.id
    end for
    m.buttonsGrid.content = contentNode
end function

function onButtonClicked(msg as object)
    buttonIndex = msg.getData()
    selectedButton = m.buttonsGrid.content.getChild(buttonIndex)
    if selectedButton.id = "restart":
        m.videoPlayer.seek = 0
    else if selectedButton.id = "play":
        onPlayClicked()
    else if selectedButton.id = "audiosubs":
        print "Clicked on audio/subtitle"
    end if
end function

function changeTimeFormat(timeInSec)
    time = []
    tempTime = []
    if m.videoPlayer.duration > 3600
        timeInMin = int(timeInSec/60)

        tempTime.Unshift(timeInSec mod 60)
        tempTime.Unshift(timeInMin mod 60)
        tempTime.Unshift(int(timeInMin/60))
    else:
        tempTime.Unshift(timeInSec mod 60)
        tempTime.Unshift(int(timeInSec/60))
    end if

    for each num in tempTime
        if num < 0
            num = 0
        end if 
        num = num.toStr()
        if len(num) = 1
            num = "0" + num
        end if
        time.push(num)
    end for
    return time.join(":")
end function

function setFocus()
    print "Video is being set as focus"
    m.buttonsGrid.setFocus(true)
    showMainSceneCounter(false)
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press
        m.seekValue = 0
        'Auto-hide temp display
        m.UI.visible = true
        m.buttonsGrid.setFocus(true)
        m.buttonsTimer.control = "start"
        'Adjust focus
        if key = "up" and m.buttonsGrid.hasFocus()
            m.videoPlayer.setFocus(true)
        end if
        if key = "down" and m.videoPlayer.hasFocus()
            m.buttonsGrid.setFocus(true)
        end if
        ' print "key = ",key
        if key = "back" 'or 'return' or 'exit'
            ' m.saved_times[]= m.videoPlayer.position
            m.top.goBack = true
            return true
        end if
        if key = "right"
            onRightClicked()
        end if
        if key = "left"
            onLeftClicked()
        end if
        if key = "fastforward" or key = "rewind"
            if m.moveBtn <> key then m.moveValue = 0
            m.moveBtn = key
            m.videoPlayer.setFocus(true)
            m.moveValue += 3
            if m.moveValue >= 12 then m.moveValue = 0
            m.moveTimer.control = "start"
            return true
        end if
        if key = "play" 'or key = "OK"
            onPlayClicked()
            return true
        end if
    end if
    ' print "MoviesScreen onKeyEvent"
end function

function onRightClicked()
    m.videoPlayer.control = "pause"
    if m.videoPlayer.seek > m.videoPlayer.duration:
        m.videoPlayer.seek = m.videoPlayer.duration
    else:
        m.seekValue = 3
        print m.videoPlayer.seek
        m.seekTimer.control = "start"
    end if
end function
function onLeftClicked()
    m.videoPlayer.control = "pause"
            if m.videoPlayer.seek < 0:
                m.videoPlayer.seek = 0
            else:
                m.seekValue= -3
                m.seekTimer.control = "start"
            end if
end function
function onPlayClicked()
    btnCount = m.buttonsGrid.content.getChildCount() -1
    for i= 0 to btnCount
        button = m.buttonsGrid.content.getChild(i)
        if button.id = "play"
            selectedButton = button
        end if
    end for

    if m.videoPlayer.state = "playing"
        'Setup
        selectedButton.HDPosterUrl = "pkg:/images/buttons/play.png"
        'Control
        m.videoPlayer.control = "pause"
        'UI
        m.UI.visible = true
    else
        'Setup
        selectedButton.HDPosterUrl = "pkg:/images/buttons/pause.png"
        'Control
        m.videoPlayer.control = "resume"
        'UI | starts UI fade-Out
        m.buttonsTimer.control = "start"
    end if
end function
function seeking()
    m.videoPlayer.seek = m.videoPlayer.position + m.seekValue
end function
function onMoving()
    target = m.videoPlayer.position
    if m.moveBtn = "fastforward" 
        target += m.moveValue
        m.videoPlayer.seek = target
    end if
    if m.moveBtn = "rewind"
        target -= m.moveValue
        m.videoPlayer.seek = target
    end if
end function