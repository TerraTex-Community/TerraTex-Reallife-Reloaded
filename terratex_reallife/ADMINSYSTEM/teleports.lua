--- definitions
local gppoints = {
    ["noob"] = { 1737.099609375, -1862.0546875, 13.576762199408 }, --noob
    ["ls"] = { 1545.4775390625, -1675.560546875, 13.560440063477 }, -- ls
    ["fish"] = { 383.314453125, -2054.2255859375, 7.8359375 }, --fish
    ["truck"] = { 2769.2548828125, -2440.4267578125, 13.6484375 }, -- truck
    ["lv"] = { 2305.4169921875, 2430.0146484375, 10.8203125 } --lv
}

--- commands
function gj_func(thePlayer, cmd, jobid)
    if (isAdminLevel(thePlayer, 0)) then
        if (tonumber(jobid)) then
            if (JobPickups[tonumber(jobid)]) then
                setElementPosition(thePlayer, JobPickups[tonumber(jobid)][3], JobPickups[tonumber(jobid)][4], JobPickups[tonumber(jobid)][5])
            else
                showError(thePlayer, "ungültige jobID")
            end
        else
            showError(thePlayer, "ungültige jobID")
        end
    end
end
addCommandHandler("gj", gj_func, false, false)

function gotopoint(thePlayer, cmd, point)
    if (isAdminLevel(thePlayer, 0)) then
        local ableplaces = ""
        local pointsexist = false
        for theKey, tables in pairs(gppoints) do
            if (theKey == point) then
                pointsexist = true
            end
            ableplaces = ableplaces .. theKey .. " "
        end
        if (pointsexist) then
            setElementPosition(thePlayer, gppoints[point][1], gppoints[point][2], gppoints[point][3])
            outputChatBox("Du wurdest erfolgreich zur Position " .. point .. " geportet", thePlayer, 255, 0, 0) --adminabfrage + falscher string
        else
            outputChatBox("Mögliche Orte:", thePlayer, 255, 0, 0)
            outputChatBox(ableplaces, thePlayer, 255, 0, 0)
        end
    end
end
addCommandHandler("gp", gotopoint, false, false)

function set_mark_admin(thePlayer)
    if (isAdminLevel(thePlayer, 0)) then
        local mx, my, mz = getElementPosition(thePlayer)
        local mint = getElementInterior(thePlayer)
        local mdim = getElementDimension(thePlayer)
        vioSetElementData(thePlayer, "adminMarkX", mx)
        vioSetElementData(thePlayer, "adminMarkY", my)
        vioSetElementData(thePlayer, "adminMarkZ", mz)
        vioSetElementData(thePlayer, "adminMarkInt", mint)
        vioSetElementData(thePlayer, "adminMarkDim", mdim)
        outputChatBox("Der Marker wurde gespeichert! DU kannst dich mit /gotomark hinteleportieren!", thePlayer, 255, 0, 0)
    end
end
addCommandHandler("setMark", set_mark_admin, false, false)

function gotomark_func(thePlayer)
    if (isAdminLevel(thePlayer, 0)) then
        if (vioGetElementData(thePlayer, "adminMarkX")) then
            setElementPosition(thePlayer, vioGetElementData(thePlayer, "adminMarkX"), vioGetElementData(thePlayer, "adminMarkY"), vioGetElementData(thePlayer, "adminMarkZ"))
            setElementInterior(thePlayer, vioGetElementData(thePlayer, "adminMarkInt"))
            setElementDimension(thePlayer, vioGetElementData(thePlayer, "adminMarkDim"))
            outputChatBox("Du wurdest zum Marker teleportiert!", thePlayer, 255, 0, 0)

        else
            outputChatBox("Es ist kein Marker gespeichert! Du musst erst einen mit /setmark speichern!", thePlayer, 255, 0, 0)
        end
    end
end
addCommandHandler("gotomark", gotomark_func, false, false)

function goto_func(theMaker, Command, thePlayerName)
    if (isAdminLevel(theMaker, 0)) then
        local thePlayer = getPlayerFromIncompleteName(thePlayerName)
        if (thePlayer) then
            if (isPedInVehicle(theMaker)) then

                local gx, gy, gz = getElementPosition(thePlayer)
                local i = getElementInterior(thePlayer)
                local d = getElementDimension(thePlayer)
                local theVehicle = getPedOccupiedVehicle(theMaker)
                setElementFrozen(theVehicle, true)
                setElementInterior(theVehicle, i)
                setElementDimension(theVehicle, d)
                setElementVelocity(theVehicle, 0, 0, 0)
                setElementPosition(theVehicle, gx + 3, gy + 3, gz + 1)
                setElementFrozen(theVehicle, false)

            else

                local gx, gy, gz = getElementPosition(thePlayer)
                local i = getElementInterior(thePlayer)
                local d = getElementDimension(thePlayer)
                setElementInterior(theMaker, i)
                setElementDimension(theMaker, d)
                setElementPosition(theMaker, gx + 1, gy + 1, gz)
            end
        else
            outputChatBox("Falscher Spielername", theMaker, 255, 0, 0)
        end
    end
end
addCommandHandler("goto", goto_func, false, false)

function gethere_func(theMaker, Command, thePlayerName)
    if (isAdminLevel(theMaker, 0)) then
        local thePlayer = getPlayerFromIncompleteName(thePlayerName)
        if (thePlayer) then
            if (isPedInVehicle(thePlayer)) then
                local gx, gy, gz = getElementPosition(theMaker)
                local i = getElementInterior(theMaker)
                local d = getElementDimension(theMaker)
                local theVehicle = getPedOccupiedVehicle(thePlayer)
                setElementInterior(theVehicle, i)
                setElementDimension(theVehicle, d)

                setElementVelocity(theVehicle, 0, 0, 0)
                setElementPosition(theVehicle, gx + 2, gy + 2, gz + 1)
            else

                local gx, gy, gz = getElementPosition(theMaker)
                local i = getElementInterior(theMaker)
                local d = getElementDimension(theMaker)
                setElementInterior(thePlayer, i)
                setElementDimension(thePlayer, d)
                setElementPosition(thePlayer, gx + 1, gy + 1, gz)
            end
        else
            outputChatBox("Falscher Spielername", theMaker, 255, 0, 0)
        end
    end
end
addCommandHandler("gethere", gethere_func, false, false)
