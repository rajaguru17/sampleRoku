' Library "Roku_Ads.brs"
sub Main(args as object)
    deeplink = {}
    print "Main Args = ",args
    screen = CreateObject("roSGScreen")
    port = CreateObject("roMessagePort")
    screen.SetMessagePort(port)
    m.global = screen.getGlobalNode()
    print "m.global.deepLink = ",m.global.deepLink
    m.global.addField("accessToken","String",true)
    m.global.accessToken = invalid
    if args.contentId <> invalid and args.mediaType <> invalid
        deeplink.contentId= args.contentId
        deeplink.mediaType = args.mediaType
    
        m.global.addField("deepLink","assocArray",true)
        m.global.deepLink = deeplink
    end if
    screen.CreateScene("Mainscene")
    screen.Show()
    
    while true
        msg = wait(0, port)
        print "msg type and value",type(msg),msg
        if type(msg) = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub
