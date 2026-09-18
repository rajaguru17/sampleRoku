sub init()
    'Initializations
    m.saved_times = {}
    m.seekValue = 0
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
    'Buttons setup
    setButtonGrid()
    'observers
    m.buttonsGrid.observeField("itemSelected","onButtonClicked")
    m.videoTimer.observeField("fire","setFocus")
    m.videoPlayer.observeField("position", "onPlaying")
    m.buttonsTimer.observeField("fire","fadeOutUI")
    m.seekTimer.observeField("fire","seeking")
end sub 

function showVideo(msg as object)
    'Video
    videoContent = CreateObject("RoSGNode","ContentNode")
    videoData = msg.getData()
    ' print "videoData = ",videoData
    videoContent.url = videoData.url ' 1hour link-> "http://192.168.8.152:5050/video.mp4"
    videoContent.title = videoData.title
    videoContent.streamformat = videoData.streamformat

    'Video Player attributes
    m.videoPlayer.content = videoContent
    m.videoPlayer.control = "play"
    m.videoPlayer.enableUI = False
    m.videoPlayer.enableTrickPlay = False
    m.videoTimer.control ="start"

    'Exceptions
    if videoData.LIVE = true
        m.videoPlayer.enableUI = false
        m.videoPlayer.enableTrickPlay = false
    end if

    'Timer setup
    m.buttonsTimer.control = "start"
end function

function fadeOutUI()
    m.UI.visible=false
end function

function onPlaying()
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
end function

function setButtonGrid()
    m.buttonData = [
    { id: "restart", text: "Play From Beginning", icon: "pkg:/images/buttons/restart.png"  },
    { id: "play",    text: "Pause",                icon: "pkg:/images/buttons/pause.png" },
    { id: "audiosubs",   text: "Audio & Subtitles",   icon: "pkg:/images/buttons/audiosubs.png" }
    ]
    contentNode = CreateObject("roSGNode","ContentNode")
    for each item in m.buttonData:
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

function onPlayClicked()
    btnCount = m.buttonsGrid.content.getChildCount() -1
    print 
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

function RAF()
    rafNode = CreateObject("roSGNode","RAF")
    rafNode.control = "run"
end function

function seeking()
    m.videoPlayer.seek = m.videoPlayer.position + m.seekValue
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press
        ' print "key = ",key
        m.UI.visible = true
        m.buttonsTimer.control = "start"
        if key = "back" 'or 'return' or 'exit'
            ' m.saved_times[]= m.videoPlayer.position
            m.top.goBack = true
            return true
        end if
        if key = "right"
            m.videoPlayer.control = "pause"
            if m.videoPlayer.seek > m.videoPlayer.duration:
                m.videoPlayer.seek = m.videoPlayer.duration
            else:
                m.seekValue = 3
                m.seekTimer.control = "start"
                
            end if
        end if
        if key = "left"
            m.videoPlayer.control = "pause"
            if m.videoPlayer.seek < 0:
                m.videoPlayer.seek = 0
            else:
                m.seekValue= -3
                m.seekTimer.control = "start"
            end if
        end if
        if key = "fastforward"
        end if
        if key = "rewind"
        end if
        if key = "play" 'or key = "OK"
            onPlayClicked()
            return true
        end if
    end if
    ' print "MoviesScreen onKeyEvent"
end function
