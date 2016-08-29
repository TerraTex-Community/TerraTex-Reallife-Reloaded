createObject(9241, 1005.09002686, 1018.02001953, 48.84999847, 0.00000000, 0.00000000, 306.00000000) -- //object(copbits_sfn) (1)
createObject(9241, 1056.70996094, 980.15917969, 40.59999847, 0.00000000, 0.00000000, 274.99877930) --//object(copbits_sfn) (2)

local newsMarkerA = false
local newsMarkerB = false
local newsPortStatus = false

function onResourceStartCreateNewsMarker()

    newsMarkerA = createMarker(1029.6300048828, 1009.29998779, 47.630001068115, "cylinder", 2)
    addEventHandler("onMarkerHit", newsMarkerA, hitNewsMarker)
    newsMarkerB = createMarker(1039.8100585938, 1014.4199829102, 10.5, "cylinder", 2)
    addEventHandler("onMarkerHit", newsMarkerB, hitNewsMarker)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onResourceStartCreateNewsMarker)

function hitNewsMarker(thePlayer)
    if not (newsPortStatus) then
        if (source == newsMarkerA) then
            setElementPosition(thePlayer, 1039.8100585938, 1014.4199829102, 11)
            newsPortStatus = true
            setTimer(resetnewsPortStatus, 250, 1)
        elseif (source == newsMarkerB) then
            setElementPosition(thePlayer, 1029.6300048828, 1009.29998779, 48.130001068115)
            newsPortStatus = true
            setTimer(resetnewsPortStatus, 250, 1)
        end
    end
end

function resetnewsPortStatus()
    newsPortStatus = false
end

