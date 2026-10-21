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

function saveKeyInReg(keyname as string,value="" as string)
    registrySection = CreateObject("roRegistrySection", "default")
    registrySection.Write(keyname, value)
    registrySection.Flush()
end function

function readKeyInReg(keyname as string)
    registrySection = CreateObject("roRegistrySection","default")
    if registrySection.Exists(keyname)
        return registrySection.Read(keyname)
    end if
end function

function deleteKeyInReg(keyname as string)
    registrySection = CreateObject("roRegistrySection","default")
    print keyname
    if registrySection.Exists(keyname)
        print "---Coming into if---"
        registrySection.Delete(keyname)
        registrySection.Flush()
    end if
end function

function hasAccessToken()
    return m.global.accessToken <> invalid and m.global.accessToken <> ""
end function