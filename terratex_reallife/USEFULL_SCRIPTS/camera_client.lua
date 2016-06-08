--
-- Created by IntelliJ IDEA.
-- User: Geramy
-- Date: 11.08.2014
-- Time: 19:41
-- To change this template use File | Settings | File Templates.
--
local breakMe=false
local sm = {}
sm.moov = 0
sm.object1,sm.object2 = nil,nil

local function removeCamHandler()
    if(sm.moov == 1)then
        sm.moov = 0
    end
end

local function camRender()
    if (sm.moov == 1) then
        local x1,y1,z1 = getElementPosition(sm.object1)
        local x2,y2,z2 = getElementPosition(sm.object2)
        if not(breakMe and isPlayerLoggedIn(getLocalPlayer()))then
            setCameraMatrix(x1,y1,z1,x2,y2,z2)
        end
    end
end
addEventHandler("onClientPreRender",root,camRender)

function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time,breakAtLogin)
    if(breakAtLogin)then
        breakMe=true
    else
        breakMe=false
    end
    if(sm.moov == 1)then return false end
    sm.object1 = createObject(1337,x1,y1,z1)
    sm.object2 = createObject(1337,x1t,y1t,z1t)
    setElementAlpha(sm.object1,0)
    setElementAlpha(sm.object2,0)
    setObjectScale(sm.object1,0.01)
    setObjectScale(sm.object2,0.01)
    moveObject(sm.object1,time,x2,y2,z2,0,0,0,"InOutQuad")
    moveObject(sm.object2,time,x2t,y2t,z2t,0,0,0,"InOutQuad")
    sm.moov = 1
    setTimer(removeCamHandler,time,1)
    setTimer(destroyElement,time,1,sm.object1)
    setTimer(destroyElement,time,1,sm.object2)
    return true
end










