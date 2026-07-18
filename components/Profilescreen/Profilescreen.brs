sub init()
    m.profileScreen = m.top.findNode("profilesBackground")
    setProfilesBackground()
    m.profilesMarkUpGrid = m.top.findNode("profilesMarkUpGrid")
    setprofilesMarkUpGrid()
    m.profileMarkUpGrid = m.top.findNode("profilesMarkUpGrid")

    showProfilescreen()
end sub

function setProfilesBackground()
        m.profileScreen.width = 1920
        m.profileScreen.height = 1080
        m.profileScreen.translation = [0,0]
        m.profileScreen.color = "#FFFFFF"
end function

function setprofilesMarkUpGrid()
    profilesGridData = profilesGridConfig()
    contentNode = contentNode.createChild("roSGnNde","ContentNode")
    for each item in profilesGridData
        itemNode = contentNode.createChild("ContentNode")
        itemNode.text = item.text
        itemNode.HDPosterUrl = item.image
    end for
    m.profilesMarkUpGrid.content = contentNode
end function 

function showProfilescreen()

end function