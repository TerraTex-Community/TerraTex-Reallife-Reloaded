local antifluttimer = false
local anti_flut_Data = {}

function antiflutreset()
    anti_flut_Data = {}
    antifluttimer = setTimer(antiflutreset, 5000, 1)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), antiflutreset)

function antiflut(command)
    if (not (command == "Next") and not (command == "Previous") and not (command == "Toggle")) then
        if not (tonumber(anti_flut_Data[source])) then
            anti_flut_Data[source] = 0
        end
        anti_flut_Data[source] = anti_flut_Data[source] + 1

        if (isTimer(antifluttimer)) then
            if (anti_flut_Data[source] > 50) then
                local pname = getPlayerName(source)
                local Serial = getPlayerSerial(source)

                MySql.helper.insert("admin_user_timebans", {
                    Nickname = pname,
                    Serial = Serial,
                    Grund = "ChatBoxSpam",
                    Admin = "Anti-Flood-System",
                    Minuten = 120
                });

                outputChatBox(string.format("Der Spieler %s wurde vom Anti-Flood-System gebannt. Grund: %s", pname, "ChatBoxSpam"), getRootElement(), 255, 0, 0)
                kickPlayer(source, "ChatBoxSpam");
            end
        end
        if not (isTimer(antifluttimer)) then
            antifluttimer = setTimer(antiflutreset, 2000, 1)
        end
    end
end

function chatfunc(message, types)
    local cmd = "say"

    if (types == 1) then
        cmd = "me"
    end

    if (types == 2) then
        cmd = "teamsay"
    end

    triggerEvent("onConsole", source, cmd .. " " .. message)
end
addEventHandler("onPlayerChat", getRootElement(), chatfunc)

function test_onconsole(command)
    local cmdString = split(command, " ")
    local cmd = cmdString[1]
    if (not (cmd == "Next") and not (cmd == "Previous") and not (cmd == "Toggle")) then
        if not (tonumber(anti_flut_Data[source])) then
            anti_flut_Data[source] = 0
        end
        anti_flut_Data[source] = anti_flut_Data[source] + 1

        if (isTimer(antifluttimer)) then
            if (anti_flut_Data[source] > 150) then
                local pName = getPlayerName(source)
                local Serial = getPlayerSerial(source)

                MySql.helper.insert("admin_user_timebans", {
                    Nickname = pName,
                    Serial = Serial,
                    Grund = "ChatBoxSpam",
                    Admin = "Anti-Flood-System",
                    Minuten = 120
                });
                outputChatBox(string.format("Der Spieler %s wurde vom Anti-Flood-System gebannt. Grund: %s", pName, "ChatBoxSpam"), getRootElement(), 255, 0, 0)
                kickPlayer(source, "ChatBoxSpam")
            end
        end
        if not (isTimer(antifluttimer)) then
            antifluttimer = setTimer(antiflutreset, 2000, 1)
        end
    end
end
addEventHandler("onConsole", getRootElement(), test_onconsole)
