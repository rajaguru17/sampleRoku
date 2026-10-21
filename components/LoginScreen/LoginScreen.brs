sub init()
    m.loginKeyboard = m.top.findNode("loginKeyboard")
    m.loginKeyboard.observeField("text","onTextEntered")
    m.userName = m.top.findNode("usernameField")
    m.password = m.top.findNode("passwordField")
    m.signInButton = m.top.findNode("signInButton")
    m.loginVisual = m.top.findNode("loginVisual")
    m.slideAnimation = m.top.findNode("slideAnimation")
    m.slideUp = m.top.findNode("slideUp")
    m.errorLabel = m.top.findNode("errorLabel")
    m.channelStore = m.top.findNode("channelStore")
    m.channelStore.observeField("userData","onClickChannelStore")
    m.loginKeyboard.textEditBox.observeField("cursorPosition", "onCursorMoved")
    ' m.top.setFocus(true)
end sub

sub onTextEntered(msg as object)
    if m.activeField <> invalid
        m.activeField.text = msg.getData()
    end if
end sub

sub onCursorMoved(msg as object)
    if m.activeField <> invalid
        m.activeField.cursorPosition = msg.getData()
    end if
end sub

function onClickChannelStore(msg as object)
    responseData = msg.getData()
    m.top.setFocus(true)
    if responseData <> invalid
        m.userName.text = responseData.email
        m.userName.active = false
        m.password.active = true
        m.activeField = invalid
    else
        openKeyboard()
        ' moveDown()
    end if
end function

function channelStore()
    info = CreateObject("roSGNode", "ContentNode")
    info.addFields({context: "signin"})
    m.channelStore.requestedUserDataInfo = info
    m.channelStore.requestedUserData = "email"
    m.channelStore.command = "getUserData"
    ' m.email = m.channelStore.userdata.email
    print "*0* - =", m.email
end function

function setFocus()
    m.top.setFocus(true)
    m.userName.active = true
    ' m.loginKeyboard.setFocus(true)
end function

sub moveUp()
    print "entering moveUp"
    m.loginKeyboard.visible = true
    t = m.loginVisual.translation
    m.slideUp.keyValue = [t, [t[0], t[1] - 150]]
    m.slideAnimation.control = "start"
end sub

sub moveDown()
    print "entering moveDown"
    m.loginKeyboard.visible = false
    t = m.loginVisual.translation
    m.slideUp.keyValue = [t, [t[0], t[1] + 150]]
    m.slideAnimation.control = "start"
end sub

' function onTextEntered(msg as object)
'     responseData = msg.getData()
'     print "textentered =",responseData
'     ' print "m.loginKeyboardText =", m.loginKeyboard.text
'     if m.activeField <> invalid
'         ' print "m.AFCursorPos =", m.activeField.cursorPosition
'         ' m.activeField.text = ""
'         m.activeField.text = m.loginKeyboard.text
'         ' m.activeField.cursorPosition += 1
'         m.activeField.cursorPosition = m.loginKeyboard.textEditBox.cursorPosition
'     end if
    
' end function

function onKeyEvent(key as string,press as boolean) as boolean
    if press
        print key,"Button pressed"
        ' print "userName.active = ",m.userName.active
        ' print "password.active =",m.password.active
        ' print "signInFocus = ",m.signInButton.hasFocus()
        ' print " "
        if key = "down" and m.userName.active
            ' print "Down pressed"
            m.userName.active = false
            m.password.active = true
            return true
        end if
       
        if key = "up" and m.password.active
            ' print "Up pressed"
            m.password.active = false
            m.userName.active = true
            return true
        end if
        if key = "down" and m.password.active
            ' print "Down pressed from pswd"
            m.password.active = false
            m.signInButton.color = "#EAD452"
            m.signInButton.setFocus(true)
            return true
        end if
        if key = "up" and m.signInButton.hasFocus()
            ' print "Up pressed from signin"
            m.signInButton.color = "#F5B100"
            m.signInButton.setFocus(false)
            m.top.setFocus(true)
            m.password.active = true
            return true
        end if
        if key = "back"
            if m.loginKeyboard.visible = true
                m.activeField = invalid
                moveDown()
                m.loginKeyboard.setFocus(false)
                m.top.setFocus(true)
                return true
            end if
            m.top.goBack = true
            return true
        end if
        if key = "OK" and (m.userName.active OR m.password.active) and m.loginKeyboard.visible = false
            print "is it inside OK?"
            if m.userName.active
                m.activeField = m.userName
                if m.userName.text = ""
                    channelStore()
                    return true
                end if
            else
                m.activeField = m.password
            end if
            openKeyboard()
            return true
        end if
        if key = "OK" and m.signInButton.hasFocus()
            validateCredentials()
        end if
        return true
    end if
end function

sub openKeyboard()
    m.loginKeyboard.text = m.activeField.text
    m.loginKeyboard.textEditBox.cursorPosition = Len(m.activeField.text)
    moveUp()
    m.loginKeyboard.setFocus(true)
end sub

sub validateCredentials()
      ' ignore repeat presses while a request is in flight
    if m.serverTask <> invalid and m.serverTask.state = "run" then return
        email = m.userName.text.Trim()
        password = m.password.text
    if not isValidEmail(email)
        showError("Enter a valid email address")
        return
    end if
    if password = ""
        showError("Enter your password")
        return
    end if
    m.errorLabel.visible = false
    m.serverTask = CreateObject("roSGNode", "serverTask")
    m.serverTask.observeField("responseData", "onLoginResponse")
    m.serverTask.loginID = email
    m.serverTask.password = password
    m.serverTask.functionName = "validateCredentials"
    m.serverTask.control = "RUN"
end sub

sub onLoginResponse(event as Object)
    res = event.getData()
    m.serverTask = invalid
    print "res = *-* ",res
    if res.success = true
        m.errorLabel.color = "#00FF00"
        showError("Valid credentials entered")
        saveKeyInReg("accessToken",res.accessToken)
        ' print "m.g.aT = ",m.global.accessToken
        m.global.accessToken = res.accessToken
        ' print "m.global.accessToken = ",m.global.accessToken
        ' print "m.g = "m.global
        ' print "saved key = ",readKeyInReg("accessToken")
        m.top.loginSuccess = true          
    else if res.statusCode = 401
        m.errorLabel.color = "#E3242B" 
        showError("Invalid email or password")
    else
        m.errorLabel.color = "#E3242B" 
        showError("Could not reach server")
    end if
    
end sub

sub showError(message as String)
    m.errorLabel.text = message
    m.errorLabel.visible = true
end sub

function isValidEmail(email as String) as Boolean
    re = CreateObject("roRegex", "^[A-Z0-9._%+-]+@[A-Z0-9-]+(\.[A-Z0-9-]+)*\.[A-Z]{2,}$", "i")
    return re.IsMatch(email)
end function