--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 09.02.14
-- Time: 01:32
-- To change this template use File | Settings | File Templates.
--


function lottoziehung_func(timer)

    local curtime=getRealTime()
    if(curtime["hour"]==19 and curtime["minute"]==10)then
        local winners=0
        local winTab={}
        local lottozahlA=math.random(1,100)
        local lottozahlB=math.random(1,100)
        while (lottozahlA==lottozahlB)do
            lottozahlB=math.random(1,100)
        end
        local lottozahlC=math.random(1,100)
        while (lottozahlA==lottozahlC or lottozahlB==lottozahlC )do
            lottozahlC=math.random(1,100)
        end


        for theKey,thePlayer in ipairs(getElementsByType("player")) do
            if(vioGetElementData(thePlayer,"lotto"))then
                local zahlenstring=getStringComponents(vioGetElementData(thePlayer,"lotto"))
                local zahlen={tonumber(zahlenstring[1]),tonumber(zahlenstring[2]),tonumber(zahlenstring[3])}
                local zahcounter=0
                if(zahlen[1]==lottozahlA or zahlen[1]==lottozahlB or zahlen[1]==lottozahlC)then
                    zahcounter=zahcounter+1
                end
                if(zahlen[2]==lottozahlA or zahlen[2]==lottozahlB or zahlen[2]==lottozahlC)then
                    zahcounter=zahcounter+1
                end
                if(zahlen[3]==lottozahlA or zahlen[3]==lottozahlB or zahlen[3]==lottozahlC)then
                    zahcounter=zahcounter+1
                end
                if(	zahcounter==3 or vioGetElementData(thePlayer,"setMeLottoWin"))then
                    table.insert(winTab,thePlayer)
                    winners=winners+1
                end
            end
        end

        outputChatBox("<<<<Lottoziehung>>>>")
        outputChatBox(string.format("Heute wurden folgende Zahlen gezogen %s, %s, %s", lottozahlA, lottozahlB, lottozahlC))
        if(winners>0)then
            local gewinn=math.round(serversettings["lottojackpot"]/winners)
            outputChatBox(string.format("Die folgenden Spieler haben mit einen 3er jeweils %s$ gewonnen:", gewinn))
            local winnerstring=""
            for theKey,thePlayer in ipairs(winTab) do
                winnerstring=winnerstring..getPlayerName(thePlayer)..", "
                changePlayerBank(thePlayer,gewinn,"sonstiges","Lottogewinn")
                if(vioGetElementData(thePlayer,"Erfolg_Lotto3")~=1)then
                    vioSetElementData(thePlayer,"Erfolg_Lotto3",1)
                    triggerClientEvent(thePlayer,"onClientCreatePokalGUI",thePlayer,"3er Lotto","Gewinne mit einem 3er im Lotto")
                end

            end
            outputChatBox(winnerstring)
            save_log("lotto","Winner(3er):"..winnerstring.." Nummern: "..lottozahlA.." "..lottozahlB.." "..lottozahlC)
            local newjackpot=math.random(3000,7500)
            outputChatBox("Der neue Jackpot startet bei "..newjackpot.."$")
            serversettings["lottojackpot"]=newjackpot

        else
            for theKey,thePlayer in ipairs(getElementsByType("player")) do
                if(vioGetElementData(thePlayer,"lotto"))then
                    zahlenstring=getStringComponents(vioGetElementData(thePlayer,"lotto"))
                    zahlen={tonumber(zahlenstring[1]),tonumber(zahlenstring[2]),tonumber(zahlenstring[3])}
                    zahcounter=0
                    if(zahlen[1]==lottozahlA or zahlen[1]==lottozahlB or zahlen[1]==lottozahlC)then
                        zahcounter=zahcounter+1
                    end
                    if(zahlen[2]==lottozahlA or zahlen[2]==lottozahlB or zahlen[2]==lottozahlC)then
                        zahcounter=zahcounter+1
                    end
                    if(zahlen[3]==lottozahlA or zahlen[3]==lottozahlB or zahlen[3]==lottozahlC)then
                        zahcounter=zahcounter+1
                    end
                    if(	zahcounter==2)then
                        table.insert(winTab,thePlayer)
                        winners=winners+1
                    end
                end
            end
            if(winners>0)then
                local gewinn=math.round((serversettings["lottojackpot"]/2)/winners)
                outputChatBox("Leider gab es keine 3er. 50% können nur von 2ern Gewonnen werden:")
                outputChatBox(string.format("Die folgenden Spieler haben mit einen 2er jeweils %s$ gewonnen:", gewinn))
                local winnerstring=""
                for theKey,thePlayer in ipairs(winTab) do
                    winnerstring=winnerstring..getPlayerName(thePlayer)..", "
                    changePlayerBank(thePlayer,gewinn,"sonstiges","Lottogewinn")
                    if(vioGetElementData(thePlayer,"Erfolg_Lotto2")~=1)then
                        vioSetElementData(thePlayer,"Erfolg_Lotto2",1)
                        triggerClientEvent(thePlayer,"onClientCreatePokalGUI",thePlayer,"2er Lotto","Gewinne mit einem 2er im Lotto")
                    end
                end
                outputChatBox(winnerstring)
                save_log("lotto","Winner(2er):"..winnerstring.." Nummern: "..lottozahlA.." "..lottozahlB.." "..lottozahlC)

                local newjackpot=math.random(1500,5000)+serversettings["lottojackpot"]/2
                outputChatBox(string.format("Der Jackpot liegt jetzt bei %s$", newjackpot))
                serversettings["lottojackpot"]=newjackpot
            else
                for theKey,thePlayer in ipairs(getElementsByType("player")) do
                    if(vioGetElementData(thePlayer,"lotto"))then

                        zahlenstring=getStringComponents(vioGetElementData(thePlayer,"lotto"))
                        zahlen={tonumber(zahlenstring[1]),tonumber(zahlenstring[2]),tonumber(zahlenstring[3])}
                        zahcounter=0
                        if(zahlen[1]==lottozahlA or zahlen[1]==lottozahlB or zahlen[1]==lottozahlC)then
                            zahcounter=zahcounter+1
                        end
                        if(zahlen[2]==lottozahlA or zahlen[2]==lottozahlB or zahlen[2]==lottozahlC)then
                            zahcounter=zahcounter+1
                        end
                        if(zahlen[3]==lottozahlA or zahlen[3]==lottozahlB or zahlen[3]==lottozahlC)then
                            zahcounter=zahcounter+1
                        end
                        if(	zahcounter==1)then
                            table.insert(winTab,thePlayer)
                            winners=winners+1
                        end
                    end
                end

                if(winners>0)then
                    local gewinn=math.round((serversettings["lottojackpot"]/100)/winners)
                    outputChatBox("Leider gab es keine 3er und 2er. 1% können nur von 1ern Gewonnen werden:")
                    outputChatBox(string.format("Die folgenden Spieler haben mit einen 1er jeweils %s$ gewonnen:", gewinn))
                    local winnerstring=""
                    for theKey,thePlayer in ipairs(winTab) do
                        winnerstring=winnerstring..getPlayerName(thePlayer)..", "
                        changePlayerBank(thePlayer,gewinn,"sonstiges","Lottogewinn")
                        if(vioGetElementData(thePlayer,"Erfolg_Lotto1")~=1)then
                            vioSetElementData(thePlayer,"Erfolg_Lotto1",1)
                            triggerClientEvent(thePlayer,"onClientCreatePokalGUI",thePlayer,"1er Lotto","Gewinne mit einem 1er im Lotto")
                        end
                    end
                    outputChatBox(winnerstring)
                    save_log("lotto","Winner(1er):"..winnerstring.." Nummern: "..lottozahlA.." "..lottozahlB.." "..lottozahlC)

                    local newjackpot=math.round(math.random(1500,5000)+(serversettings["lottojackpot"]-serversettings["lottojackpot"]/10),0)
                    outputChatBox(string.format("Der Jackpot liegt jetzt bei %s$", newjackpot))
                    serversettings["lottojackpot"]=newjackpot
                else
                    outputChatBox("Leider hat keiner Gewonnen!")
                    serversettings["lottojackpot"]=math.round(serversettings["lottojackpot"]+math.random(10000,30000),0)
                    outputChatBox(string.format("Der Jackpot liegt jetzt bei %s$", serversettings["lottojackpot"]))
                    save_log("lotto","Winner(keine):".." Nummern: "..lottozahlA.." "..lottozahlB.." "..lottozahlC)

                end
            end


        end
        for theKey,thePlayers in ipairs(getElementsByType("player")) do
            vioSetElementData(thePlayers,"lotto","0|0|0")
        end
        serversettings["lottojackpot"]=math.round(serversettings["lottojackpot"])
    end
    setTimer(lottoziehung_func,60000,1)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),lottoziehung_func)










