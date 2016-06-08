--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 25.07.2014
-- Time: 11:45
-- To change this template use File | Settings | File Templates.
--
local Tcounter=0

--ACHTUNG angaben sind in HALBEN sekunden
local yellow=5
local green=15
local red=2
local lastState=1
local stateOrder={2,0,1,2,3,4 }

--yellow: 1 4
-- red: 2
-- green: 0 3

function handleTrafficLightsOutOfOrder()
    local timer=getRealTime()
    local hour=timer.hour

    if(hour<6)then
        setTrafficLightState(9)
    elseif(hour<8 or hour>21)then
        local lightsOff = getTrafficLightState() == 9
        if lightsOff then
            setTrafficLightState(6)
        else
            setTrafficLightState(9)
        end
    else
        Tcounter=Tcounter+1
        local aktualState=stateOrder[lastState]


        if(aktualState==1 or aktualState==4)then
            if(Tcounter==yellow)then
                lastState=lastState+1
                if(lastState>table.getSize(stateOrder))then
                   lastState=1
                end
                Tcounter=0
            end
        elseif(aktualState==2)then
            if(Tcounter==red)then
                lastState=lastState+1
                if(lastState>table.getSize(stateOrder))then
                    lastState=1
                end
                Tcounter=0
            end
        elseif(aktualState==0 or aktualState==3)then
            if(Tcounter==green)then
                lastState=lastState+1
                if(lastState>table.getSize(stateOrder))then
                    lastState=1
                end
                Tcounter=0
            end
        end
        setTrafficLightState(stateOrder[lastState])
    end
end

function startTrafficLights()
    setTrafficLightsLocked ( true )
    setTimer(handleTrafficLightsOutOfOrder,500,0)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),startTrafficLights)









