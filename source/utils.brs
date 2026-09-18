function loadingText() as string
    return "Hello world!!!!!"
end function

function showMainSceneCounter(isVisible)
    scene = m.top.getScene()
    scene.callFunc("counterVisibility",isVisible)
    ' print "scene=******",scene
end function

function showCounter()
    if m.counterValue > 0
        m.counter.text = "Clicks = " + m.counterValue.toStr()
    end if
end function
