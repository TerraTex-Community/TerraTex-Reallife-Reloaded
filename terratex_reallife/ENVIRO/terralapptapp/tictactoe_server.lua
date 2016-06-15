--[[
Database:
	user_tapps_tictactoe
Fields: 
	ID
	Nickname
	Gegner
	Spielstand => 0|0|0|0|0|0|0|0|0 => Felder 1-9 von oben links bis unten rechts
	Winner =>  0 = Spiel läuft noch, 1=Spieler gewinnt, 2=Gegner gewinnt, 3=unentschieden
	State => 0 = request steht aus, 1=spieler ist dran, 2=gegner ist dran	
]]
--triggerServerEvent("TTTsetField",getLocalPlayer(),lastGameData[gameID]["State"],Winner,table.concat(gameFields,"|"))



addEvent("TTTsetField",true)
function TTTsetField_func(gameID,newState, newWinner, Fields, gegnerName,Winnername)
    MySql.helper.update("user_tapps_tictactoe", { State = newState }, { ID = gameID});
    MySql.helper.update("user_tapps_tictactoe", { Winner = newWinner }, { ID = gameID});
    MySql.helper.update("user_tapps_tictactoe", { Spielstand = Fields }, { ID = gameID});
    triggerClientEvent(source,"aktualizeTTT_Event",source)


    local text=""
    if(newWinner==0)then
        text=string.format("Dein TicTacToe-Gegner %s hat seinen Zug gemacht. Du bist jetzt dran!", getPlayerName(source))
    else
        if(newWinner==3)then
            text=string.format("Das TicTacToe-Spiel gegen %s endete Unentschieden!", getPlayerName(source))
        else
            text=string.format("Das TicTacToe-Spiel gegen %s hat %s gewonnen", getPlayerName(source), Winnername)
        end
    end

    local gegner=getPlayerFromName(gegnerName)
    if(gegner)then
        outputChatBox(text,gegner,155,0,0)
        showError(gegner,text)
        triggerClientEvent(gegner,"aktualizeTTT_Event",gegner)
    else
        save_offline_message(gegnerName,"TicTacToe",text)
    end
end
addEventHandler("TTTsetField",getRootElement(),TTTsetField_func)

addEvent("cancelTTTQuestion_Event",true)
function cancelTTTQuestion_Event_func(gameID)
    MySql.helper.delete("user_tapps_tictactoe", {ID = gameID});
    showError(source,"Du hast die Anfrage ablehnt!")
    triggerClientEvent(source,"aktualizeTTT_Event",source)

    local gegner=getPlayerFromName(gegnerName)
    if(gegner)then
        outputChatBox(string.format("Deine TicTacToe-Herrausforderung wurde von %s abgelehnt!", getPlayerName(source)),gegner,155,0,0)
        showError(gegner,string.format("Deine TicTacToe-Herrausforderung wurde von %s abgelehnt!", getPlayerName(source)))
        triggerClientEvent(gegner,"aktualizeTTT_Event",gegner)
    else
        save_offline_message(gegnerName,"TicTacToe",string.format("Deine TicTacToe-Herrausforderung wurde von %s abgelehnt!", getPlayerName(source)))
    end
end
addEventHandler("cancelTTTQuestion_Event",getRootElement(),cancelTTTQuestion_Event_func)


addEvent("acceptTTTQuestion_Event",true)
function acceptTTTQuestion_Event_func(gameID,gegnerName)
    MySql.helper.update("user_tapps_tictactoe", { State = math.random(1,2) }, { ID = gameID});
    showError(source,"Du hast die Anfrage angenommen!")
    triggerClientEvent(source,"aktualizeTTT_Event",source)

    local gegner=getPlayerFromName(gegnerName)
    if(gegner)then
        outputChatBox(string.format("Deine TicTacToe-Herrausforderung wurde von %s angenommen!", getPlayerName(source)),gegner,155,0,0)
        showError(gegner,string.format("Deine TicTacToe-Herrausforderung wurde von %s angenommen!", getPlayerName(source)))
        triggerClientEvent(gegner,"aktualizeTTT_Event",gegner)
    else
        save_offline_message(gegnerName,"TicTacToe",string.format("Deine TicTacToe-Herrausforderung wurde von %s angenommen!", getPlayerName(source)))
    end
end
addEventHandler("acceptTTTQuestion_Event",getRootElement(),acceptTTTQuestion_Event_func)





addEvent("tictactoe_herausforderung",true)
function tictactoe_herausforderung_func(gegnerName)
    local gegner=getPlayerFromIncompleteName(gegnerName)
    if(gegner)then
        local playerName=getPlayerName(source)
        local gegnerName=getPlayerName(gegner)

        local query = "SELECT count(*) as anzahl FROM user_tapps_tictactoe WHERE ";
        query = query .. "((Nickname = ? and Gegner = ? ) or (Nickname=? and Gegner=?)) and `Winner` = 0";

        local execQ = dbQuery(MySql._connection, query,playerName,gegnerName,gegnerName,playerName );
        local result = dbPoll(execQ, -1);

        if(result[1]["anzahl"] > 0)then
            showError(source,"Es gibt bereits ein offenes Spiel, offene Herrausforderung oder eine offene Anfrage Spiel mit diesem Spieler!")
        else
            local appTable=vioGetElementData(gegner,"tappapps")
            if(appTable["TicTacToe"]==1)then
                MySql.helper.insert("user_tapps_tictactoe", {
                    Nickname = playerName,
                    Gegner = gegnerName
                });

                outputChatBox("Du hast eine neue TicTacToe-Herrausforderung erhalten!",gegner,155,0,0)
                showError(gegner,"Du hast eine neue TicTacToe-Herrausforderung erhalten!")
                showError(source,string.format("Du hast %s herrausgefordert!", gegnerName))
                triggerClientEvent(source,"aktualizeTTT_Event",source)
                triggerClientEvent(gegner,"aktualizeTTT_Event",gegner)
            else
                showError(source,"Dieser Spieler besitzt die Tapp 'TicTacToe' nicht!")
            end
        end
    else
        showError(source,"Dieser Spieler ist nicht Online! Du kannst nur Spieler herrausfordern, die gerade Online sind!")
    end
end
addEventHandler("tictactoe_herausforderung",getRootElement(),tictactoe_herausforderung_func)

addEvent("getTicTacToeData",true);
function getTicTacToeData_func()

    local query="SELECT * FROM user_tapps_tictactoe WHERE Nickname = ? or Gegner = ? ORDER BY ID DESC";
    local runQuery = dbQuery(MySql._connection, query, getPlayerName(source), getPlayerName(source))
	local result = dbPoll(runQuery, -1);

    local gameTable = {};
	for theKey, dsatz in ipairs(result) do
		table.insert(gameTable, dsatz)
    end
    triggerClientEvent(source,"sendTTTDataToClient",source,gameTable)
end
addEventHandler("getTicTacToeData",getRootElement(),getTicTacToeData_func)
