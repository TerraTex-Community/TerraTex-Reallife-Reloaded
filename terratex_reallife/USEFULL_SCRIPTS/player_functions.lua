--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 24.04.2014
-- Time: 11:42
-- To change this template use File | Settings | File Templates.
--
function isPlayerLoggedIn(thePlayer)
    if(isElement(thePlayer))then
        if(getElementData(thePlayer,"loggedin"))then
           return true
        else
            return false
        end
    else
        return false
    end
end

function getPlayerLoggedInTime(thePlayer,inFormat --[[default: seconds; values: seconds, minutes, hours]])
    if(isPlayerLoggedIn(thePlayer))then
        local loggedInSince=tonumber(getElementData(thePlayer,"loggedin"))
        local timer=getRealTime()
        local loggedInTime=timer.timestamp-loggedInSince

        if(not(inFormat))then
           inFormat="seconds"
        end

        if(inFormat=="seconds")then
           return loggedInTime
        elseif(inFormat=="minutes")then
            local newTime= math.round(loggedInTime/60,0)
            return newTime
        elseif(inFormat=="hours")then
            local newTime=  math.round(loggedInTime/60/60,0)
            return newTime
        else
            return loggedInTime
        end
    else
        return -1
    end
end


function getPlayerFromIncompleteName(name)
    if(name)then
        local players=getElementsByType("player")
        local pname=""
        local ergebnisse=0
        local ergebnis=nil
        if(getPlayerFromName(name))then
            if(not isPlayerLoggedIn(getPlayerFromName(name)))then
                return false
            end
            return getPlayerFromName(name)
        elseif(getPlayerFromName(config["clantag"]..name))then
            if(not isPlayerLoggedIn(getPlayerFromName(config["clantag"]..name)))then
                return false
            end
            return getPlayerFromName(config["clantag"]..name)
        else
            name=string.lower(name)
            for theKey,thePlayer in ipairs(players) do
                pname=string.lower (getPlayerName(thePlayer))
                if(string.find(pname,name))then
                    ergebnisse=ergebnisse+1
                    ergebnis=thePlayer
                end
            end
            if(ergebnisse>1)then
                ergebnis=false
            end
            if(not isPlayerLoggedIn(ergebnis))then
                return false
            end
            return ergebnis
        end
    else
        return false
    end
end

function getLoggedInPlayersCount()
    local Players=0
    for theKey,thePlayer in ipairs(getElementsByType('player'))do
       if(isPlayerLoggedIn(thePlayer))then Players=Players+1 end
    end
    return Players
end

function getClientRandomPlayer()
    local player=getElementsByType("player")
    return player[math.random(1,table.getSize(player))]

end

function getPlayersByDataValue(dataTag, dataValue )
    if not dataTag then return getElementsByType ( "player" ) end

    local returnTable = {}
    for theKey,thePlayer in ipairs(getElementsByType ( "player" )) do
        if(isPlayerLoggedIn(thePlayer))then
            if (vioGetElementData(thePlayer, dataTag)) then
                if (vioGetElementData(thePlayer, dataTag) == dataValue) then
                    table.insert(returnTable, thePlayer)
                end
            end
        end
    end
    return returnTable
end