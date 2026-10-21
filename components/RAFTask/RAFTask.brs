Library "Roku_Ads.brs"
sub init()
end sub

function control_play()
    'Initializations
    adUrl = "https://devtools.web.roku.com/samples/sample.xml"
    m.adIface = Roku_Ads()

    m.adIface.enableAdMeasurements(true)

    m.adIface.SetAdURL(adUrl)
    adPods = m.adIface.GetAds()

    keepPlaying = false
    if adPods <> invalid
        m.scene = m.top.adHolder
        m.top.shouldPlayContent = m.adIface.showAds(adPods, invalid, m.scene)
        print "SPC =" ,m.shouldPlayContent
    end if
    adPods = invalid
    m.adIface = invalid
    ' myAdUrl = ""
    ' adPods = []
    ' adHolder = ""
    ' adIface = Roku_Ads()
    ' adIface.setAdUrl(myAdUrl)

    ' print "myAdUrl = ",m.top.myAdUrl
    ' print "adHolder = ", adHolder
'     shouldPlayContent = adIface.showAds(adPods, invalid, adHolder)
    
'     while shouldPlayContent
'     videoMsg = wait(0, contentVideoScreen.GetMessagePort())
'     adPods = adIface.getAds(videoMsg)
'     if adPods <> invalid and adPods.Count() > 0
'         contentVideoScreen.Close() ' stop playback of content
'         shouldPlayContent = adIface.showAds(adPods) ' render current ad pod
'         if shouldPlayContent
'       ' *** Insert client app's resume-playback code here
'     end if
'   end if
'   ' *** Insert client app's video event handler code here
' end while
end function 