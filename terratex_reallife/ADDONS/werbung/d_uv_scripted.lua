local werbungenTable = {}
local werbeschilder = 19
function onResourceStart_WerbeSchilderGenerieren()

    local timer = getRealTime()
    local dateToday = (timer.year + 1900) .. "-" .. (timer.month + 1) .. "-" .. timer.monthday .. "'";
    MySql.helper.delete("data_advertising", {DatumBis = {"<", dateToday}});

    for i = 1, (werbeschilder), 1 do
        local count = MySql.helper.getCountSync("data_advertising");
        if (count == 0) then
            werbungenTable[i] = { "WERBEBILDER/standardwerbung.png", 0 }
            sendFileToClient(werbungenTable[i][1], getRootElement(), "werbung", i, werbungenTable[i][2])
        else
            local query = dbQuery(MySql._connection, "SELECT * FROM data_advertising ORDER BY RAND() LIMIT 1");
            local result = dbPoll(query, -1);
            local dsatz = result[1];

            if (fileExists("WERBEBILDER/" .. dsatz["picName"])) then
                werbungenTable[i] = { "WERBEBILDER/" .. dsatz["picName"], tonumber(dsatz["animation"]) }
                sendFileToClient(werbungenTable[i][1], getRootElement(), "werbung", i, werbungenTable[i][2])
            else
                outputDebugString(("[Werbebilder] Die Datei %s konnte nicht gefunden werden"):format("WERBEBILDER/" .. dsatz["picName"]))
            end
        end
    end
    setTimer(onResourceStart_WerbeSchilderGenerieren, 3600000, 1)
end
addEventHandler("onResourceStart", resourceRoot, onResourceStart_WerbeSchilderGenerieren)

addEvent("requestPlayerOfMonth", true)
function onResourceLoadPlayerOfMonth(thePlayer)
    if not source then source = thePlayer end
    sendFileToClient("WERBEBILDER/big_wall/" .. serversettings["playerOfMonthPic"], source, "month", 0)

    for i = 1, (werbeschilder), 1 do
        sendFileToClient(werbungenTable[i][1], source, "werbung", i, werbungenTable[i][2])
    end
end

addEventHandler("requestPlayerOfMonth", getRootElement(), onResourceLoadPlayerOfMonth)

function sendFileToClient(file, client, typer, ID, animation)
    local fh = fileExists(file) and fileOpen(file)
    assert(fh, "File does not exist: " .. file)

    local data = fileRead(fh, fileGetSize(fh))
    fileClose(fh)

    if (typer == "month") then
        triggerLatentClientEvent(client, "onClientLoadPlayerOfTheMonth", true, getRootElement(), data)
    else
        triggerLatentClientEvent(client, "onClientLoadWerbung", true, getRootElement(), data, ID, animation)
    end
end