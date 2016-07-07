--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 07.07.2016
-- Time: 14:29
-- To change this template use File | Settings | File Templates.
--


local fixedCameraPositions_login = {
    { 1213.21826, -1326.199096, 25.8984375, 1172.643066, -1324.076171875, 14.15533638 },
    { 1537.6953125, -1696.1962890625, 58.551567077637, 1480.98046875, -1767.736328125, 17.741710662842, 0, 70, 0, 0 },
    { 1493.814453125, -1666.8203125, 42.985389709473, 1586.5263671875, -1680.4345703125, 8.0690994262695, 0, 70, 0, 0 },
    { 1330.48046875, -937.4697265625, 56.787254333496, 1302.140625, -852.3974609375, 12.519222259521, 0, 70, 0, 0 },
    { 1243.7744140625, -967.32421875, 59.380855560303, 1187.1640625, -887.1083984375, 40.38920211792, 0, 70, 0, 0 },
    { 2122.2919921875, -1099.265625, 36.495029449463, 2135.240234375, -1194.3798828125, 8.4646072387695, 0, 70, 0, 0 },
    { 2751.19921875, -1882.84765625, 30.427167892456, 2758.529296875, -1787.1376953125, 2.3967533111572, 0, 70, 0, 0 },
    { 1658.783203125, 1894.716796875, 27.757402420044, 1597.6884765625, 1818.62890625, 5.8935871124268, 0, 70, 0, 0 },
    { 2743.154296875, -2435.8955078125, 21.916435241699, 2826.2353515625, -2486.1259765625, -2.0511016845703, 0, 70, 0, 0 },
}

function fadeStartCameraOut()
    if (not isPlayerLoggedIn(getLocalPlayer())) then
        fadeCamera(false, 3)
        setTimer(showBackgroundcameraForLogin, 3000, 1)
    end
end

function showBackgroundcameraForLogin()
    if (not isPlayerLoggedIn(getLocalPlayer())) then

        local typer = math.random(1, 3)
        if (typer == 1 and getLoggedInPlayersCount() > 0) then
            local randPlayer = getClientRandomPlayer()
            while (not isPlayerLoggedIn(randPlayer) or getLocalPlayer() == randPlayer) do
                randPlayer = getClientRandomPlayer()
            end

            local x, y, z = getElementPosition(randPlayer)
            if (isPedInVehicle(randPlayer)) then
                setCameraMatrix(x, y, z, x, y, z + 10, 0, 70)
            end

            setTimer(setCameraLoginOn, 1000, 1, randPlayer)
        elseif (typer == 2) then
            fadeCamera(true, 3)
            local randPos = math.random(1, table.getSize(fixedCameraPositions_login))
            local randPosB = math.random(1, table.getSize(fixedCameraPositions_login))
            while (randPos == randPosB) do
                local randPosB = math.random(1, table.getSize(fixedCameraPositions_login))
            end
            smoothMoveCamera(fixedCameraPositions_login[randPos][1], fixedCameraPositions_login[randPos][2], fixedCameraPositions_login[randPos][3], fixedCameraPositions_login[randPos][4], fixedCameraPositions_login[randPos][5], fixedCameraPositions_login[randPos][6], fixedCameraPositions_login[randPosB][1], fixedCameraPositions_login[randPosB][2], fixedCameraPositions_login[randPosB][3], fixedCameraPositions_login[randPosB][4], fixedCameraPositions_login[randPosB][5], fixedCameraPositions_login[randPosB][6], 30000, true)
            setTimer(fadeStartCameraOut, 35000, 1)

        else
            fadeCamera(true, 3)
            local randPos = math.random(1, table.getSize(fixedCameraPositions_login))
            setCameraMatrix(fixedCameraPositions_login[randPos][1], fixedCameraPositions_login[randPos][2], fixedCameraPositions_login[randPos][3], fixedCameraPositions_login[randPos][4], fixedCameraPositions_login[randPos][5], fixedCameraPositions_login[randPos][6], 0, 70)
            setTimer(fadeStartCameraOut, 20000, 1)
        end
    end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), showBackgroundcameraForLogin)

function setCameraLoginOn(randPlayer)
    fadeCamera(true, 3)
    setCameraViewMode(math.random(1, 5))
    setCameraTarget(randPlayer)

    setTimer(fadeStartCameraOut, 20000, 1)
end

