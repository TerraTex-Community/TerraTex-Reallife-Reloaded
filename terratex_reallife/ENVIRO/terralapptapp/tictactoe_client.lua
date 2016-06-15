

TicTacToeTapp = {
    tab = {},
    staticimage = {},
    tabpanel = {},
    edit = {},
    button = {},
    window = {},
    gridlist = {},
    label = {}
}
addEventHandler("onClientResourceStart", getRootElement(),
    function()
		local screenW, screenH = guiGetScreenSize()
        TicTacToeTapp.window[1] = guiCreateWindow((screenW - 407) / 2, (screenH - 430) / 2, 407, 430, "TicTacToe", false)
        guiWindowSetSizable(TicTacToeTapp.window[1], false)
        table.insert(allGuis,TicTacToeTapp.window[1])


        TicTacToeTapp.tabpanel[1] = guiCreateTabPanel(9, 28, 388, 138, false, TicTacToeTapp.window[1])

        TicTacToeTapp.tab[1] = guiCreateTab("offene Spiele", TicTacToeTapp.tabpanel[1])

        TicTacToeTapp.gridlist[1] = guiCreateGridList(10, 26, 368, 78, false, TicTacToeTapp.tab[1])
        guiGridListAddColumn(TicTacToeTapp.gridlist[1], "ID", 0.1)
        guiGridListAddColumn(TicTacToeTapp.gridlist[1], "Spielername", 0.4)
        guiGridListAddColumn(TicTacToeTapp.gridlist[1], "Wer ist am Zug?", 0.4)
        TicTacToeTapp.label[1] = guiCreateLabel(11, 9, 367, 17, "Du hast mit folgenden Spielern noch ein Spiel offen:", false, TicTacToeTapp.tab[1])

        TicTacToeTapp.tab[2] = guiCreateTab("Anfragen", TicTacToeTapp.tabpanel[1])

        TicTacToeTapp.label[2] = guiCreateLabel(6, 8, 372, 15, "Du hast folgende Anfragen erhalten:", false, TicTacToeTapp.tab[2])
        TicTacToeTapp.gridlist[2] = guiCreateGridList(6, 28, 241, 76, false, TicTacToeTapp.tab[2])
        guiGridListAddColumn(TicTacToeTapp.gridlist[2], "ID", 0.1)
        guiGridListAddColumn(TicTacToeTapp.gridlist[2], "Spielername", 0.8)
        TicTacToeTapp.button[1] = guiCreateButton(254, 28, 124, 34, "Annehmen", false, TicTacToeTapp.tab[2])
        TicTacToeTapp.button[2] = guiCreateButton(254, 66, 124, 38, "Ablehnen", false, TicTacToeTapp.tab[2])

        TicTacToeTapp.tab[3] = guiCreateTab("Herausfordern", TicTacToeTapp.tabpanel[1])

        TicTacToeTapp.label[3] = guiCreateLabel(10, 10, 368, 25, "Folgende Anfragen von dir wurden noch nicht beantwortet:", false, TicTacToeTapp.tab[3])
        TicTacToeTapp.gridlist[3] = guiCreateGridList(10, 35, 181, 69, false, TicTacToeTapp.tab[3])
        guiGridListAddColumn(TicTacToeTapp.gridlist[3], "ID", 0.1)
        guiGridListAddColumn(TicTacToeTapp.gridlist[3], "Spielername", 0.8)
        TicTacToeTapp.label[4] = guiCreateLabel(198, 31, 94, 15, "Herrausfordern:", false, TicTacToeTapp.tab[3])
        TicTacToeTapp.edit[1] = guiCreateEdit(198, 48, 180, 23, "", false, TicTacToeTapp.tab[3])
        TicTacToeTapp.button[3] = guiCreateButton(198, 71, 180, 33, "Herrausfordern!!!", false, TicTacToeTapp.tab[3])

        TicTacToeTapp.tab[4] = guiCreateTab("beendete Spiele", TicTacToeTapp.tabpanel[1])

        TicTacToeTapp.gridlist[4] = guiCreateGridList(11, 14, 367, 90, false, TicTacToeTapp.tab[4])
        guiGridListAddColumn(TicTacToeTapp.gridlist[4], "ID", 0.1)
        guiGridListAddColumn(TicTacToeTapp.gridlist[4], "Gegner", 0.3)
        guiGridListAddColumn(TicTacToeTapp.gridlist[4], "Gewinner", 0.3)
        guiGridListAddColumn(TicTacToeTapp.gridlist[4], "Spielstand (Du/Gegner)", 0.2)


        TicTacToeTapp.label[5] = guiCreateLabel(13, 177, 384, 50, "Spielfeld:\nGegner:\nWer ist am Zug: ", false, TicTacToeTapp.window[1])
        TicTacToeTapp.feld={}

        TicTacToeTapp["feld"][1]={}
        TicTacToeTapp["feld"][2]={}
        TicTacToeTapp["feld"][3]={}


        TicTacToeTapp["feld"][1][1] = guiCreateLabel(13, 235, 50, 50, "-", false, TicTacToeTapp.window[1])

        TicTacToeTapp["feld"][3][1]  = guiCreateLabel(0.03, 0.83, 0.12, 0.12, "-", true, TicTacToeTapp.window[1])
        TicTacToeTapp["feld"][2][1]  = guiCreateLabel(13, 295, 50, 50, "-", false, TicTacToeTapp.window[1])
        TicTacToeTapp["feld"][1][2]  = guiCreateLabel(73, 235, 50, 50, "-", false, TicTacToeTapp.window[1])

        TicTacToeTapp["feld"][1][3]  = guiCreateLabel(133, 235, 50, 50, "-", false, TicTacToeTapp.window[1])

        TicTacToeTapp["feld"][2][2]  = guiCreateLabel(73, 295, 50, 50, "-", false, TicTacToeTapp.window[1])
        TicTacToeTapp["feld"][3][2]  = guiCreateLabel(73, 355, 50, 50, "-", false, TicTacToeTapp.window[1])
        TicTacToeTapp["feld"][2][3]  = guiCreateLabel(133, 295, 50, 50, "-", false, TicTacToeTapp.window[1])
        TicTacToeTapp["feld"][3][3]  = guiCreateLabel(133, 355, 50, 50, "-", false, TicTacToeTapp.window[1])
        TicTacToeTapp.label[6] = guiCreateLabel(241, 235, 146, 150, "Du kannst einen Zug setzen, in dem du Doppelklick auf das entsprechende Feld machst\n\nLegende:\nX - Du\nO - Gegner\n- - Noch keine Belegung", false, TicTacToeTapp.window[1])
        guiLabelSetHorizontalAlign(TicTacToeTapp.label[6], "left", true)
        TicTacToeTapp.staticimage[1] = guiCreateStaticImage(63, 235, 10, 170, "FILES/IMAGES/f1/dot_white.png", false, TicTacToeTapp.window[1])
        TicTacToeTapp.staticimage[2] = guiCreateStaticImage(123, 235, 10, 170, "FILES/IMAGES/f1/dot_white.png", false, TicTacToeTapp.window[1])
        TicTacToeTapp.staticimage[3] = guiCreateStaticImage(13, 286, 170, 9, "FILES/IMAGES/f1/dot_white.png", false, TicTacToeTapp.window[1])
        TicTacToeTapp.staticimage[4] = guiCreateStaticImage(13, 345, 170, 10, "FILES/IMAGES/f1/dot_white.png", false, TicTacToeTapp.window[1])
        TicTacToeTapp.button[4] = guiCreateButton(196, 389, 191, 26, "Beenden", false, TicTacToeTapp.window[1])    



--        for theKey, theSubTable in pairs(TicTacToeTapp["feld"])do
--            for theSubKey, theElement in pairs(theSubTable)do
--                guiSetFont(theElement, "sa-header")
--                guiLabelSetHorizontalAlign(theElement, "center", false)
--                guiLabelSetVerticalAlign(theElement, "center")
--            end
--        end

        for x = 1, 9, 1 do
            local labelElement=TicTacToeTapp["feld"][math.floor(((x-1)/3))+1][math.floor(((x-1)%3)+1)]
            guiSetFont(labelElement, "sa-header")
            guiLabelSetHorizontalAlign(labelElement, "center", false)
            guiLabelSetVerticalAlign(labelElement, "center")
            setElementData(labelElement,"fieldID",x)
            addEventHandler ( "onClientGUIClick", labelElement, setField,false)
        end

        guiGridListSetSelectionMode ( TicTacToeTapp.gridlist[1], 0)
        guiGridListSetSelectionMode ( TicTacToeTapp.gridlist[2], 0)
        guiGridListSetSelectionMode ( TicTacToeTapp.gridlist[3], 0)
        guiGridListSetSelectionMode ( TicTacToeTapp.gridlist[4], 0)
		
		guiSetVisible(TicTacToeTapp.window[1],false)
		
		
		addEventHandler ( "onClientGUIClick", TicTacToeTapp.button[4], closeTicTacToe,false)
		addEventHandler ( "onClientGUIClick", TicTacToeTapp.button[3], startGameQuestion,false)
		addEventHandler ( "onClientGUIClick", TicTacToeTapp.button[2], cancelTTTQuestion,false)
		addEventHandler ( "onClientGUIClick", TicTacToeTapp.button[1], acceptTTTQuestion,false)

		addEventHandler ( "onClientGUIClick", TicTacToeTapp.gridlist[1], setGameView,false)
		addEventHandler ( "onClientGUIClick", TicTacToeTapp.gridlist[2], setGameView,false)
		addEventHandler ( "onClientGUIClick", TicTacToeTapp.gridlist[3], setGameView,false)
		addEventHandler ( "onClientGUIClick", TicTacToeTapp.gridlist[4], setGameView,false)



	end
)





local lastGameData={}
local lastOpenGame=0
--[[
    Fields:
        ID
        Nickname
        Gegner
        Spielstand => 0|0|0|0|0|0|0|0|0 => Felder 1-9 von oben links bis unten rechts
        Winner =>  0 = Spiel läuft noch, 1=Spieler gewinnt, 2=Gegner gewinnt, 3=unentschieden
        State => 0 = request steht aus, 1=spieler ist dran, 2=gegner ist dran
    ]]

function setField()
    local fieldID=tonumber(getElementData(source,"fieldID"))
    local gameID=0

    local isSelected=false
    local row,col=guiGridListGetSelectedItem ( TicTacToeTapp.gridlist[1] )
    if(row~=-1)then
        gameID=tonumber(guiGridListGetItemText ( TicTacToeTapp.gridlist[1], row, 1 ))
        isSelected=true
    elseif(lastOpenGame~=0)then
       gameID=lastOpenGame
       isSelected=true
    end

    if(isSelected)then
        if(tonumber(lastGameData[gameID]["Winner"])==0)then
            if((tonumber(lastGameData[gameID]["State"])==1 and lastGameData[gameID]["Nickname"]==getPlayerName(getLocalPlayer())) or (tonumber(lastGameData[gameID]["State"])==2 and lastGameData[gameID]["Gegner"]==getPlayerName(getLocalPlayer())))then
                local gameFields=getStringComponents(lastGameData[gameID]["Spielstand"])
                if(tonumber(gameFields[fieldID])==0)then
                    guiSetText(source,"X")
                    if(tonumber(lastGameData[gameID]["State"])==1)then
                        lastGameData[gameID]["State"]=2
                    else
                        lastGameData[gameID]["State"]=1
                    end
                    if(lastGameData[gameID]["Nickname"]==getPlayerName(getLocalPlayer()))then
                        gameFields[fieldID]=1
                    else
                        gameFields[fieldID]=2
                    end
                    local Winner=0
                    local isAnyNull=false
                    for thefieldid,thecontent in ipairs(gameFields)do
                        if(tonumber(thecontent)==0)then
                            isAnyNull=true
                            break
                        end
                    end
                    if(not isAnyNull)then
                        Winner=3
                        showError(getLocalPlayer(),"Das Spiel endete Unentschieden!")
                    elseif(tonumber(gameFields[1])==tonumber(gameFields[2]) and tonumber(gameFields[2])==tonumber(gameFields[3]))then
                            Winner=tonumber(gameFields[1])
                    elseif(tonumber(gameFields[4])==tonumber(gameFields[5]) and tonumber(gameFields[5])==tonumber(gameFields[6]))then
                        Winner=tonumber(gameFields[4])
                    elseif(tonumber(gameFields[7])==tonumber(gameFields[8]) and tonumber(gameFields[8])==tonumber(gameFields[9]))then
                        Winner=tonumber(gameFields[7])
                    elseif(tonumber(gameFields[1])==tonumber(gameFields[4]) and tonumber(gameFields[4])==tonumber(gameFields[7]))then
                        Winner=tonumber(gameFields[1])
                    elseif(tonumber(gameFields[2])==tonumber(gameFields[5]) and tonumber(gameFields[5])==tonumber(gameFields[8]))then
                        Winner=tonumber(gameFields[2])
                    elseif(tonumber(gameFields[3])==tonumber(gameFields[6]) and tonumber(gameFields[6])==tonumber(gameFields[9]))then
                        Winner=tonumber(gameFields[3])
                    elseif(tonumber(gameFields[1])==tonumber(gameFields[5]) and tonumber(gameFields[5])==tonumber(gameFields[9]))then
                        Winner=tonumber(gameFields[1])
                    elseif(tonumber(gameFields[3])==tonumber(gameFields[5]) and tonumber(gameFields[5])==tonumber(gameFields[7]))then
                        Winner=tonumber(gameFields[3])
                    end
                    local Winnername="unentschieden"
                    if(Winner~=0 and Winner~=3)then
                        if(Winner==1)then
                            showError(getLocalPlayer(),string.format("%s hat das Spiel gewonnen!", lastGameData[gameID]["Nickname"]))
                            local Winnername=lastGameData[gameID]["Nickname"]
                        else
                            showError(getLocalPlayer(),string.format("%s hat das Spiel gewonnen!", lastGameData[gameID]["Gegner"]))
                            local Winnername=lastGameData[gameID]["Gegner"]
                        end
                    end
                    triggerServerEvent("TTTsetField",getLocalPlayer(),gameID,tonumber(lastGameData[gameID]["State"]),Winner,table.concat(gameFields,"|"),lastGameData[gameID]["realGegner"],Winnername)
                else
                    showError(getLocalPlayer(),"Dieses Feld ist bereits belegt!")
                end
            else
                showError(getLocalPlayer(),"Du bist nicht am Zug!")
            end
        else
            showError(getLocalPlayer(),"Dieses Spiel ist bereits zu ende!")
        end
    else
        showError(getLocalPlayer(),"Du hast kein aktives Spiel ausgewählt!")
    end

end



function openTicTacToe()
	triggerServerEvent("getTicTacToeData",getLocalPlayer())
    guiSetVisible(TicTacToeTapp.window[1],true)
end

addEvent("aktualizeTTT_Event",true)
function aktualizeTicTacToe()
    for theKey, theSubTable in pairs(TicTacToeTapp["feld"])do
        for theSubKey, theElement in pairs(theSubTable)do
            guiSetText(theElement,"-")
        end
    end
    guiSetText(TicTacToeTapp.label[5],"Spielfeld:\nGegner:\nWer ist am Zug:")
    triggerServerEvent("getTicTacToeData",getLocalPlayer())
end
addEventHandler("aktualizeTTT_Event",getRootElement(),aktualizeTicTacToe)

function closeTicTacToe()
    lastOpenGame=0
	guiSetVisible(TicTacToeTapp.window[1],false)
end

function acceptTTTQuestion()
    local gameID=0
    local isSelected=false
    local row,col=guiGridListGetSelectedItem ( TicTacToeTapp.gridlist[2] )
    if(row~=-1)then
        gameID=tonumber(guiGridListGetItemText ( TicTacToeTapp.gridlist[2], row, 1 ))
        isSelected=true
    end

    if(isSelected)then
        triggerServerEvent("acceptTTTQuestion_Event",getLocalPlayer(),gameID,lastGameData[gameID]["realGegner"])
    else
        showError(getLocalPlayer(),"Du hast kein Spiel zum annehmen ausgewählt!")
    end
end

function cancelTTTQuestion()
    local gameID=0
    local isSelected=false
    local row,col=guiGridListGetSelectedItem ( TicTacToeTapp.gridlist[2] )
    if(row~=-1)then
        gameID=tonumber(guiGridListGetItemText ( TicTacToeTapp.gridlist[2], row, 1 ))
        isSelected=true
    end

    if(isSelected)then
        triggerServerEvent("cancelTTTQuestion_Event",getLocalPlayer(),gameID,lastGameData[gameID]["realGegner"])
    else
        showError(getLocalPlayer(),"Du hast kein Spiel zum ablehnen ausgewählt!")
    end
end

function startGameQuestion()
    local gegnerName=guiGetText(TicTacToeTapp.edit[1])
    triggerServerEvent("tictactoe_herausforderung",getLocalPlayer(),gegnerName)
end

function getSpielStein(gameID, Field)
    if(Field==0)then
        return "-"
    elseif(Field==1)then
        if(lastGameData[gameID]["Nickname"]==getPlayerName(getLocalPlayer()))then
            return "X"
        else
            return "O"
        end
    else
        if(lastGameData[gameID]["Nickname"]==getPlayerName(getLocalPlayer()))then
            return "O"
        else
            return "X"
        end
    end
end

function setGameView() -- Anzeige des Spielfeldes generieren
    local gameID=0
    local isSelected=false
    local isStartedGame=false

    if(source==TicTacToeTapp.gridlist[1])then
        local row,col=guiGridListGetSelectedItem ( TicTacToeTapp.gridlist[1] )
        if(row~=-1)then
            gameID=tonumber(guiGridListGetItemText ( TicTacToeTapp.gridlist[1], row, 1 ))
            isSelected=true
            isStartedGame=true
        end
    elseif(source==TicTacToeTapp.gridlist[2])then
        local row,col=guiGridListGetSelectedItem ( TicTacToeTapp.gridlist[2] )
        if(row~=-1)then
            gameID=tonumber(guiGridListGetItemText ( TicTacToeTapp.gridlist[2], row, 1 ))
            isSelected=true
        end
    elseif(source==TicTacToeTapp.gridlist[3])then
        local row,col=guiGridListGetSelectedItem ( TicTacToeTapp.gridlist[3] )
        if(row~=-1)then
            gameID=tonumber(guiGridListGetItemText ( TicTacToeTapp.gridlist[3], row, 1 ))
            isSelected=true
        end
    else
        local row,col=guiGridListGetSelectedItem ( TicTacToeTapp.gridlist[4] )
        if(row~=-1)then
            gameID=tonumber(guiGridListGetItemText ( TicTacToeTapp.gridlist[4], row, 1 ))
            isSelected=true
            isStartedGame=true
        end
    end

    if(isSelected)then
        lastOpenGame=gameID
        local gameFields=getStringComponents(lastGameData[gameID]["Spielstand"])

        for x = 1, 9, 1 do
            guiSetText(TicTacToeTapp["feld"][math.floor(((x-1)/3))+1][math.floor(((x-1)%3)+1)],getSpielStein(gameID,tonumber(gameFields[x])))
        end
    else
        for theKey, theSubTable in pairs(TicTacToeTapp["feld"])do
            for theSubKey, theElement in pairs(theSubTable)do
                guiSetText(theElement,"-")
            end
        end
    end

--
    if(tonumber(lastGameData[gameID]["Winner"])==0)then
    local zug=lastGameData[gameID]["Nickname"]
        if(lastGameData[gameID]["State"]==2)then
            zug=lastGameData[gameID]["Gegner"]
        end
        if(not isStartedGame)then
            zug="Spielstart steht aus"
        end
        guiSetText(TicTacToeTapp.label[5],string.format("Spielfeld:\nGegner%s\nWer ist am Zug: %s", lastGameData[gameID]["realGegner"], zug))
    else
        local Winner=lastGameData[gameID]["Nickname"]
        if(tonumber(lastGameData[gameID]["Winner"])==2)then
            Winner=lastGameData[gameID]["Gegner"]
        elseif(tonumber(lastGameData[gameID]["Winner"])==3)then
            Winner="Unentschieden"
        end
        guiSetText(TicTacToeTapp.label[5],string.format("Spielfeld:\nGegner%s\nGewinner: %s", lastGameData[gameID]["realGegner"], Winner))
    end

end

addEvent("sendTTTDataToClient",true)
function sendTTTDataToClient_func(gameData)
    guiGridListClear (  TicTacToeTapp.gridlist[1] )
    guiGridListClear (  TicTacToeTapp.gridlist[2] )
    guiGridListClear (  TicTacToeTapp.gridlist[3] )
    guiGridListClear (  TicTacToeTapp.gridlist[4] )

    local Wins={}
    for theKey, theGame in ipairs(gameData)do
        local realGegner=""
        local isPlayer=true
        if(theGame["Nickname"]==getPlayerName(getLocalPlayer()))then
            realGegner=theGame["Gegner"]
        else
            realGegner=theGame["Nickname"]
            isPlayer=false
        end
        lastGameData[tonumber(theGame["ID"])]=theGame
        lastGameData[tonumber(theGame["ID"])]["realGegner"]=realGegner

        if(tonumber(theGame["Winner"])~=0)then --  Beendete Spiele
            if(not(Wins[realGegner]))then
               Wins[realGegner]={
                   ["player"]=0,
                   ["gegner"]=0
               }
            end
            local Winner=""
            if(tonumber(theGame["Winner"])==1)then
                Winner=theGame["Nickname"]
                if(isPlayer)then
                    Wins[realGegner]["player"]=Wins[realGegner]["player"]+1
                else
                    Wins[realGegner]["gegner"]=Wins[realGegner]["gegner"]+1
                end
            elseif(tonumber(theGame["Winner"])==2)then
                Winner=theGame["Gegner"]
                if(not isPlayer)then
                    Wins[realGegner]["player"]=Wins[realGegner]["player"]+1
                else
                    Wins[realGegner]["gegner"]=Wins[realGegner]["gegner"]+1
                end
            else
                Winner="Unentschieden"
            end

            local row = guiGridListAddRow ( TicTacToeTapp.gridlist[4] )
            guiGridListSetItemText ( TicTacToeTapp.gridlist[4], row, 1, theGame["ID"], false, false )
            guiGridListSetItemText ( TicTacToeTapp.gridlist[4], row, 2, realGegner, false, false )
            guiGridListSetItemText ( TicTacToeTapp.gridlist[4], row, 3, Winner, false, false )

        else

            if(tonumber(theGame["State"])==0 and theGame["Gegner"]==getPlayerName(getLocalPlayer()))then -- Herrausforderungen von anderen Spielern

                local row = guiGridListAddRow ( TicTacToeTapp.gridlist[2] )
                guiGridListSetItemText ( TicTacToeTapp.gridlist[2], row, 1, theGame["ID"], false, false )
                guiGridListSetItemText ( TicTacToeTapp.gridlist[2], row, 2, realGegner, false, false )
            elseif(tonumber(theGame["State"])==0 and theGame["Nickname"]==getPlayerName(getLocalPlayer()))then--Anfragen an andere Spieler
                local row = guiGridListAddRow ( TicTacToeTapp.gridlist[3] )
                guiGridListSetItemText ( TicTacToeTapp.gridlist[3], row, 1, theGame["ID"], false, false )
                guiGridListSetItemText ( TicTacToeTapp.gridlist[3], row, 2, realGegner, false, false )
            else
                local row = guiGridListAddRow ( TicTacToeTapp.gridlist[1] )
                guiGridListSetItemText ( TicTacToeTapp.gridlist[1], row, 1, theGame["ID"], false, false )
                guiGridListSetItemText ( TicTacToeTapp.gridlist[1], row, 2, realGegner, false, false )
                if(tonumber(theGame["State"])==1)then
                    guiGridListSetItemText ( TicTacToeTapp.gridlist[1], row, 3, theGame["Nickname"], false, false )

                else
                    guiGridListSetItemText ( TicTacToeTapp.gridlist[1], row, 3, theGame["Gegner"], false, false )
                end
            end
        end
    end

    local games=guiGridListGetRowCount ( TicTacToeTapp.gridlist[4] )-1

--    debug.print(Wins)
    for i=0,games,1 do
        local gegenername=guiGridListGetItemText ( TicTacToeTapp.gridlist[4], i, 2 )
--        debug.print(gegenername)
        guiGridListSetItemText ( TicTacToeTapp.gridlist[4], i, 4,Wins[gegenername]["player"].."/"..Wins[gegenername]["gegner"],false,false )
    end



--    guiSetVisible(TicTacToeTapp.window[1],true)

    if(lastOpenGame~=0)then
        local gameID=lastOpenGame
        local isSelected=true
        local isStartedGame=false

        if(lastGameData[gameID]["State"]~=0)then
            isStartedGame=true
        end


        if(isSelected)then
            local gameFields=getStringComponents(lastGameData[gameID]["Spielstand"])

            for x = 1, 9, 1 do
                guiSetText(TicTacToeTapp["feld"][math.floor(((x-1)/3))+1][math.floor(((x-1)%3)+1)],getSpielStein(gameID,tonumber(gameFields[x])))
            end
        else
            for theKey, theSubTable in pairs(TicTacToeTapp["feld"])do
                for theSubKey, theElement in pairs(theSubTable)do
                    guiSetText(theElement,"-")
                end
            end
        end

        --
        if(tonumber(lastGameData[gameID]["Winner"])==0)then
            local zug=lastGameData[gameID]["Nickname"]
            if(lastGameData[gameID]["State"]==2)then
                zug=lastGameData[gameID]["Gegner"]
            end
            if(not isStartedGame)then
                zug="Spielstart steht aus"
            end
            guiSetText(TicTacToeTapp.label[5],string.format("Spielfeld:\nGegner%s\nWer ist am Zug: %s", lastGameData[gameID]["realGegner"], zug))
        else
            local Winner=lastGameData[gameID]["Nickname"]
            if(tonumber(lastGameData[gameID]["Winner"])==2)then
                Winner=lastGameData[gameID]["Gegner"]
            elseif(tonumber(lastGameData[gameID]["Winner"])==3)then
                Winner="Unentschieden"
            end
            guiSetText(TicTacToeTapp.label[5],string.format("Spielfeld:\nGegner%s\nGewinner: %s", lastGameData[gameID]["realGegner"], Winner))
        end
    else
        for theKey, theSubTable in pairs(TicTacToeTapp["feld"])do
            for theSubKey, theElement in pairs(theSubTable)do
                guiSetText(theElement,"-")
            end
        end
        guiSetText(TicTacToeTapp.label[5],"Spielfeld:\nGegner:\nWer ist am Zug:")
    end
end
addEventHandler("sendTTTDataToClient",getRootElement(),sendTTTDataToClient_func)










