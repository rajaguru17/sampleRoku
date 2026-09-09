sub init()
    m.videoBackground = m.top.findNode("videoBackground")
    m.videoPlayer = m.top.findNode("videoPlayer")
    m.videoTimer = m.top.findNode("videoTimer")
    m.videoTimer.observeField("fire","setFocus")
end sub 

function showVideo(msg as object)
    videoContent = CreateObject("RoSGNode","ContentNode")
    videoData = msg.getData()
    ' print "videoData = ",videoData
    videoContent.url = videoData.url
    videoContent.title = videoData.title
    videoContent.streamformat = videoData.streamformat

    m.videoPlayer.content = videoContent
    m.videoPlayer.control = "play"
    m.videoPlayer.enableUI = True
    m.videoPlayer.enableTrickPlay = True
    m.videoTimer.control ="start"

    if videoData.LIVE = true
        m.videoPlayer.enableUI = false
        m.videoPlayer.enableTrickPlay = false
    end if

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
        if key = "back" 'or 'return' or 'exit'
            m.top.goBack = true
            return true
        end if
    end if
    print "MoviesScreen pass"
end function
