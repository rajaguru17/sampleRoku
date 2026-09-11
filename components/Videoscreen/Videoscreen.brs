sub init()
    m.videoBackground = m.top.findNode("videoBackground")
    m.videoPlayer = m.top.findNode("videoPlayer")
    m.videoTimer = m.top.findNode("videoTimer")
    m.videoTimer.observeField("fire","setFocus")

    m.grayBar=m.top.findNode("grayBarRectangle")
    m.progressBar=m.top.findNode("progreessingBarRectangle")
    m.videoPlayer.observeField("position", "playBack")
    m.buttonsUi =m.top.findNode("buttonsUI")
    m.runTime = m.top.findNode("runTime")
    m.totalDuration = m.top.findNode("totalDuration")

    m.buttonsTimer = m.top.findNode("buttonsTimer")
    m.buttonsTimer.observeField("fire","displayUI")
end sub 

function showVideo(msg as object)
    videoContent = CreateObject("RoSGNode","ContentNode")
    videoData = msg.getData()
    ' print "videoData = ",videoData
    videoContent.url = "http://192.168.8.152:5050/video.mp4"
    videoContent.title = videoData.title
    videoContent.streamformat = videoData.streamformat

    m.videoPlayer.content = videoContent
    m.videoPlayer.control = "play"
    m.videoPlayer.enableUI = False
    m.videoPlayer.enableTrickPlay = False
    m.videoTimer.control ="start"

    m.buttonsUI.visible = true
    ' displayUI()

    if videoData.LIVE = true
        m.videoPlayer.enableUI = false
        m.videoPlayer.enableTrickPlay = false
    end if
    m.buttonsTimer.control = "start"
end function

function displayUI()
    m.buttonsUI.visible=false
end function

function playBack()
    videoLength= m.videoPlayer.duration
    currentPosition = m.videoPlayer.position
    progressWidth = (currentPosition / videoLength) * m.grayBar.width
    m.progressBar.width=progressWidth
    m.runTime.text = changeTimeFormat(m.videoPlayer.position)

    if m.totalDuration.text = ""
        m.totalDuration.text = changeTimeFormat(m.videoPlayer.duration)
    end if

end function

function changeTimeFormat(timeInSec)
    time = []
    tempTime = []
    if timeInSec > 3600
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
    m.videoPlayer.setFocus(true)
    showMainSceneCounter(false)
end function

function RAF()
    rafNode = CreateObject("roSGNode","RAF")
    rafNode.control = "run"
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press
        m.buttonsUI.visible = true
        m.buttonsTimer.control = "start"
        if key = "back" 'or 'return' or 'exit'
            m.top.goBack = true
            return true
        end if
    end if
    print "MoviesScreen pass"
end function
