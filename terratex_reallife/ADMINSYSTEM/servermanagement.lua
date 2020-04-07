local gmxtimer = false
local secondgmxtimer = false

--function gmx_func(theMaker, cmd, zeitinminuten, grund, ...)
--
--    if (grund) then
--        grund = grund .. " " .. table.concat({ ... }, " ")
--    else
--        grund = " Neustart ohne Angabe"
--    end
--    if not (zeitinminuten) then
--        zeitinminuten = 1
--    end
--    if (zeitinminuten) then
--        if (not (tonumber(zeitinminuten))) then
--            zeitinminuten = 1
--        end
--    end
--    local second = zeitinminuten * 60 * 1000
--    outputDebugString("GMX Started by Console in " .. zeitinminuten .. " Minuten! Grund: " .. grund)
--
--    if (isAdminLevel(theMaker, 3)) or (isConsole(theMaker)) then
--        if (isTimer(gmxtimer)) then
--            killTimer(gmxtimer)
--        end
--        if (isTimer(secondgmxtimer)) then
--            killTimer(secondgmxtimer)
--        end
--        outputChatBox("Ein Serverneustart beginnt in " .. zeitinminuten .. " Minuten! Grund: " .. grund, getRootElement(), 255, 0, 0)
--        outputChatBox("Ein Serverneustart beginnt in " .. zeitinminuten .. " Minuten! Grund: " .. grund, getRootElement(), 255, 0, 0)
--        outputChatBox("Ein Serverneustart beginnt in " .. zeitinminuten .. " Minuten! Grund: " .. grund, getRootElement(), 255, 0, 0)
--        outputChatBox("Der Server braucht für den Restart ca. 5 Minuten!", getRootElement(), 255, 0, 0)
--        secondgmxtimer = setTimer(gmxRestTime, 60000, 1, zeitinminuten)
--        gmxtimer = setTimer(gmx_start, second, 1)
--    end
--end

function shutdown_func(theMaker, cmd, zeitinminuten, grund, ...)
    if (grund) then
        grund = grund .. " " .. table.concat({ ... }, " ")
    else
        grund = " Neustart ohne Angabe"
    end
    if not (zeitinminuten) then
        zeitinminuten = 1
    end
    if (zeitinminuten) then
        if (not (tonumber(zeitinminuten))) then
            zeitinminuten = 1
        end
    end
    local second = zeitinminuten * 60 * 1000
    outputDebugString("Shutdown Started by Console in " .. zeitinminuten .. " Minuten! Grund: " .. grund)

    if (isAdminLevel(theMaker, 3)) or (isConsole(theMaker)) then
        if (isTimer(gmxtimer)) then
            killTimer(gmxtimer)
        end
        if (isTimer(secondgmxtimer)) then
            killTimer(secondgmxtimer)
        end
        outputChatBox("Der Server wird in " .. zeitinminuten .. " Minuten heruntergefahren! Grund: " .. grund, getRootElement(), 255, 0, 0)
        outputChatBox("Der Server wird in " .. zeitinminuten .. " Minuten heruntergefahren! Grund: " .. grund, getRootElement(), 255, 0, 0)
        outputChatBox("Der Server wird in " .. zeitinminuten .. " Minuten heruntergefahren! Grund: " .. grund, getRootElement(), 255, 0, 0)
        secondgmxtimer = setTimer(shutdownRestZeit, 60000, 1, zeitinminuten)
        gmxtimer = setTimer(startShutDown, second, 1)
    end
end

addCommandHandler("stopserver", shutdown_func, false, false)
addCommandHandler("gmx", shutdown_func, false, false)

function startShutDown()
    setServerPassword("jhkjgkjhasdgkhaghasdjkf6575")
    local players = getElementsByType("player")
    for theKey, thePlayer in ipairs(players) do
        kickPlayer(thePlayer, "ShutDown")
    end

    local schnitt = 0
    for id, num in ipairs(Tagesdurchnitte) do
        schnitt = schnitt + num
    end
    schnitt = schnitt / table.getn(Tagesdurchnitte)
    serversettings["User_Schnitt"] = schnitt
    save_priv_carsB()

    setTimer(startShutDown_end, 120000, 1)
end

function startShutDown_end()
    setServerPassword(nil)
    triggerEvent("onResourceStop", getResourceRootElement(getThisResource()))
    setTimer(shutdown, 5000, 1)
end

function shutdownRestZeit(zeit)
    if (table.getSize(getElementsByType("player")) == 0) then

        if (isTimer(gmxtimer)) then
            killTimer(gmxtimer)
        end
        startShutDown()
        return
    end

    if (isTimer(secondgmxtimer)) then
        killTimer(secondgmxtimer)
    end
    zeit = zeit - 1
    outputChatBox("Der Server wird in " .. zeit .. " Minuten heruntergefahren!", getRootElement(), 255, 0, 0)
    outputChatBox("Der Server wird in " .. zeit .. " Minuten heruntergefahren!", getRootElement(), 255, 0, 0)
    outputDebugString("Der Server wird in " .. zeit .. " Minuten heruntergefahren!", 3, 255, 0, 0)
    secondgmxtimer = setTimer(gmxRestTime, 60000, 1, zeit)
end

function gmxRestTime(zeit)
    if (isTimer(secondgmxtimer)) then
        killTimer(secondgmxtimer)
    end
    zeit = zeit - 1
    outputChatBox("Der Serverneustart beginnt in " .. zeit .. " Minuten!", getRootElement(), 255, 0, 0)
    outputChatBox("Der Serverneustart beginnt in " .. zeit .. " Minuten!", getRootElement(), 255, 0, 0)
    outputDebugString("Der Serverneustart beginnt in " .. zeit .. " Minuten!", 3, 255, 0, 0)
    secondgmxtimer = setTimer(gmxRestTime, 60000, 1, zeit)
end

function gmx_start()
    setServerPassword("jhkjgkjhasdgkhaghasdjkf6575")
    local players = getElementsByType("player")
    for theKey, thePlayer in ipairs(players) do
        kickPlayer(thePlayer, "GMX")
    end

    local schnitt = 0
    for id, num in ipairs(Tagesdurchnitte) do
        schnitt = schnitt + num
    end
    schnitt = schnitt / table.getn(Tagesdurchnitte)
    serversettings["User_Schnitt"] = schnitt
    save_priv_carsB()

    setTimer(gmx_end, 120000, 1)
end

function gmx_end()
    restoreAllWorldModels()
    setServerPassword(nil)
    restartResource(getThisResource())
end

function onPlayerExitWhileGMX()
    if (table.getSize(getElementsByType("player")) == 0) then
        killTimer(gmxtimer)
        startShutDown()
    end
end
addEventHandler("onPlayerQuit", getRootElement(), onPlayerExitWhileGMX)
