function init()
    ' m.background = m.top.findNode("background")
    ' setBackground()

    background = m.top.findNode("background")
    background.color = "0x000000"
    background.width = 1920
    background.height = 1080
    background.translation = [0, 0]

    label = m.top.findNode("label")
    label.text = loadingText()
end function

function setBackground()
    m.background.color = "0x000000"
    m.background.width = 1920
    m.background.height = 1080
    m.background.translation = [0, 0]
end function

function a()
end function