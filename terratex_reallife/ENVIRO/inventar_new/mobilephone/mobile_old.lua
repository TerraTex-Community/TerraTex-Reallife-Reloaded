--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 15.08.2014
-- Time: 15:47
-- To change this template use File | Settings | File Templates.
--


function pickup_func(thePlayer)
    if(vioGetElementData(thePlayer,"telestatus")==2)and not(vioGetElementData(thePlayer,"isCaller"))then
        vioSetElementData(thePlayer,"telestatus",1)
        vioSetElementData(thePlayer,"telefontoggle",2)
        triggerClientEvent(thePlayer,"stopTeleKlingel",thePlayer)
        triggerClientEvent(vioGetElementData(thePlayer,"callwith"),"stopTeleKlingel",vioGetElementData(thePlayer,"callwith"))
        vioSetElementData(vioGetElementData(thePlayer,"callwith"),"isCaller",false)
        vioSetElementData(vioGetElementData(thePlayer,"callwith"),"telestatus",1)
        outputChatBox("Du bist rangegangen! Du kannst auflegen mit /hangup!",thePlayer)
        outputChatBox("Der Spieler ist rangegangen! Auflegen kannst du mit /hangup!",vioGetElementData(thePlayer,"callwith"))
    else
        showError(thePlayer,"Du wurdest nicht angerufen!")
    end
end
addCommandHandler("pickup",pickup_func,false,false)


function hangup_func(thePlayer)
    if(vioGetElementData(thePlayer,"telestatus")==1) or (vioGetElementData(thePlayer,"telestatus")==2)then
        local theSMS=vioGetElementData(thePlayer,"callwith")
        outputChatBox("Du hast aufgelegt!",thePlayer)
        if(isElement(theSMS))then
            outputChatBox("Der Gesprächspartner hat aufgelegt!",vioGetElementData(thePlayer,"callwith"))
        end
        triggerClientEvent(thePlayer,"stopTeleKlingel",thePlayer)
        triggerClientEvent(vioGetElementData(thePlayer,"callwith"),"stopTeleKlingel",vioGetElementData(thePlayer,"callwith"))
        vioSetElementData(thePlayer,"callwith",false)
        vioSetElementData(thePlayer,"telestatus",0)
        vioSetElementData(thePlayer,"telefontoggle",0)
        if(isElement(theSMS))then
            vioSetElementData(theSMS,"callwith",false)
            vioSetElementData(theSMS,"telestatus",0)
            vioSetElementData(theSMS,"telefontoggle",0)
        end

    elseif(vioGetElementData(thePlayer,"notfallcalling"))then
        vioSetElementData(thePlayer,"notfallreason",false)
        vioSetElementData(thePlayer,"notfallort",false)
        vioSetElementData(thePlayer,"notfalltater",false)
        vioSetElementData(thePlayer,"notfallzeuge",false)
        vioSetElementData(thePlayer,"notfallcallingpoint",false)
        vioSetElementData(thePlayer,"notfallcalling",false)
        outputChatBox("Du hast den Notruf abgebrochen!",thePlayer,255,0,0)
    end
end
addCommandHandler("hangup",hangup_func,false,false)


function onPlayerDisconnect_Hangup()
    executeCommandHandler ( "hangup", source )
end
addEventHandler("onPlayerQuit",getRootElement(),onPlayerDisconnect_Hangup)


function togglephone_func(thePlayer)
    if(vioGetElementData(thePlayer,"telefontoggle")==1)then
        vioSetElementData(thePlayer,"telefontoggle",0)
        showError(thePlayer,"Du hast dein Handy erfolgreich eingeschaltet!")
    else
        vioSetElementData(thePlayer,"telefontoggle",1)
        showError(thePlayer,"Du hast dein Handy erfolgreich ausgeschaltet!")
    end
end
addCommandHandler("togglephone",togglephone_func,false,false)


function showServiceNummern(thePlayer)
    outputChatBox("Folgende Servicenummern sind vergeben:",thePlayer,0,255,0)
    outputChatBox("110,112,911 - Notrufnummern",thePlayer,0,255,0)
    outputChatBox("11880 - Telefonauskunft",thePlayer,0,255,0)
    outputChatBox("1111 - NewsService SMS Nummer (call => blitzermeldung)",thePlayer,0,255,0)
    outputChatBox("222222 - Mechanikernotruf",thePlayer,0,255,0)
    outputChatBox("400 - Taxi",thePlayer,0,255,0)
    outputChatBox("Alle Servicenummern sind kostenfrei!",thePlayer,0,255,0)
end
addCommandHandler("service",showServiceNummern,false,false)


function killMechaBlip(theBlip)
    destroyElement(theBlip)
end

function call_func(thePlayer,Command,telenummer)
    if(vioGetElementData(thePlayer,"telefontoggle")==1)then
        showError(thePlayer,"Dein Telefon ist ausgeschaltet!")
    elseif(vioGetElementData(thePlayer,"telefontoggle")==2)then
        showError(thePlayer,"Du Telefonierst bereits (auflegen mit /hangup) oder dein Handy klingelt!")
    else
        local numberexist=false
        telenummer=tonumber(telenummer)
        if(vioGetElementData(thePlayer,"telefon")==telenummer)then
            showError(thePlayer,"..... besetzt .... ")
        elseif(telenummer==1111)then
            if(not(vioGetElementData(thePlayer,"blitzer_meld")))then
                local x,y,z=getElementPosition(thePlayer)
                outputChatBox("Die Newsreporter wurden über den Blitzer informiert!",thePlayer,255,255,0)
                local mechaBlip=createBlip ( x,y,z, 0, 2, 255, 0, 0,255, 0, 99999.0 )
                setElementVisibleTo ( mechaBlip, getRootElement(), false )
                for theKey,thePerson in ipairs(getPlayersInTeam ( team[3])) do
                    setElementVisibleTo ( mechaBlip, thePerson, true )
                    outputChatBox(string.format("Der Spieler %s hat einen Blitzer gemeldet! (Rote Markierung)", getPlayerName(thePlayer)),thePerson,0,255,0)
                end
                numberexist=true
                vioSetElementData(thePlayer,"blitzer_meld",true)
                setTimer(vioSetElementData,120000,1,thePlayer,"blitzer_meld",false)
                setTimer(killMechaBlip,120000,1,mechaBlip)
            else
                outputChatBox("Du hast vor 2 Minuten einen blitzer gemeldet, warte ein wenig!",thePlayer,255,0,0)

            end
            numberexist=true
        elseif(telenummer==400)then
            taxicounter=0
            for theKey,thePlayers in ipairs(getPlayersInTeam ( team[4])) do
                if(vioGetElementData(thePlayers,"taxi_duty"))then
                    taxicounter=taxicounter+1
                end
            end
            if(taxicounter>0)then
                local canGetTaxi=true
                local timer=getRealTime()
                if(vioGetElementData(thePlayer,"wantTaxi"))then
                    if((timer.timestamp-(60*3))<vioGetElementData(thePlayer,"wantTaxi"))then
                        canGetTaxi=false
                    end
                end
                if(canGetTaxi)then
                    for theKey,thePerson in ipairs(getPlayersInTeam ( team[4])) do
                        outputChatBox(string.format("Der Spieler %s (%s) hat ein Taxi gerufen! (Annehmen mit /taxiget %s", getPlayerName(thePlayer), getElementZoneName ( thePlayer,true ), getPlayerName(thePlayer)),thePerson,0,255,0)
                    end
                    vioSetElementData(thePlayer,"wantTaxi",timer.timestamp)
                    vioSetElementData(thePlayer,"hasTaxiDriver",false)
                    outputChatBox("Bitte warten Sie bis ihr taxiruf angenommen wurde!",thePlayer,255,255,0)
                else
                    outputChatBox("Du kannst nur alle 3 Minuten ein Taxirufen bitte warten!",thePlayer,255,255,0)
                end
            else
                outputChatBox("Es ist leider kein Taxifahrer im Dienst!",thePlayer,255,255,0)
            end
            numberexist=true
        elseif(telenummer==222222)then
            outputChatBox("Die Mechaniker wurden informiert bleibe wo du bist!",thePlayer,255,255,0)
            local mechaBlip=createBlipAttachedTo(thePlayer)
            setElementVisibleTo ( mechaBlip, getRootElement(), false )
            for theKey,thePerson in ipairs(getElementsByType("player")) do
                if(vioGetElementData(thePerson,"job"))then
                    if(vioGetElementData(thePerson,"job")==5)then
                        setElementVisibleTo ( mechaBlip, thePerson, true )
                        outputChatBox(string.format("Der Spieler %s hat einen Mechaniker gerufen! Fahre schnell und hilf! (Rote Markierung)", getPlayerName(thePlayer)),thePerson,0,255,0)

                    end
                end
            end
            numberexist=true
            setTimer(killMechaBlip,120000,1,	mechaBlip)
        elseif(telenummer==11880)then
            outputChatBox("Willkommen bei der Auskunft! Wessen Telefonnummer möchten sie wissen?",thePlayer,255,255,0)
            vioSetElementData(thePlayer,"Auskunft",true)
        elseif(telenummer==112)or(telenummer==110)or(telenummer==911)then
            vioSetElementData(thePlayer,"notfallcalling",true)
            vioSetElementData(thePlayer,"notfallcallingpoint",1)
            outputChatBox("Willkommen bei der Notrufleitzentrale!",thePlayer,0,255,0)
            outputChatBox("Was ist Vorgefallen?",thePlayer,0,255,0)
        else
            if(getPlayerMoney(thePlayer)>3.49)then
                for theKey,theSMS in ipairs(getElementsByType ( "player" ) ) do
                    if(vioGetElementData(theSMS,"telefon")==telenummer)then
                        numberexist=true
                        if(vioGetElementData(theSMS,"telefontoggle")==1)then
                            showError(thePlayer,"Das Telefon des Spielers ist ausgeschaltet!")
                        elseif(vioGetElementData(theSMS,"telefontoggle")==2)then
                            showError(thePlayer,"Es kommt ein BesetztZeichen!")
                        else
                            changePlayerMoney(thePlayer,-3.50,"sonstiges","Anruf")
                            changeBizKasse(10, 3.5, "Anruf")
                            outputChatBox(string.format("Dein Telefon klingelt. Es wird die Nummer von %s angezeigt....(abheben mit /pickup)", getPlayerName(thePlayer)),theSMS,0,255,0)
                            triggerClientEvent(theSMS,"playTeleKlingel",theSMS)
                            outputChatBox("Es klingelt....",thePlayer,0,255,0)
                            vioSetElementData(theSMS,"callwith",thePlayer)
                            vioSetElementData(thePlayer,"callwith",theSMS)
                            vioSetElementData(thePlayer,"telestatus",2)
                            vioSetElementData(thePlayer,"isCaller",true)
                            vioSetElementData(theSMS,"telestatus",2)
                            vioSetElementData(thePlayer,"telefontoggle",2)
                            vioSetElementData(theSMS,"telefontoggle",2)
                            setTimer(checkHangUp,120000,1,thePlayer)
                        end
                    end
                end
                if(numberexist==false)then
                    showError(thePlayer,"Diese Telefonnummer ist nicht vergeben!")
                end
            else
                showError(thePlayer,"Du hast nicht genuegend Geld!\nDu benötigst 350$ Verbindungsgebühr (bei Servicenummern erhälst du sie zurück!)")
            end
        end
    end
end
addCommandHandler("call",call_func,false,false)



function onChatNotfall(message,messageType)
    if(source)then
        if(messageType==0)and(vioGetElementData(source,"notfallcalling"))then
            local station=vioGetElementData(source,"notfallcallingpoint")
            if(station==1)then
                vioSetElementData(source,"notfallreason",message)
                vioSetElementData(source,"notfallcallingpoint",2)
                outputChatBox("Wo ist es vorgefallen?",source,0,255,0)
            elseif(station==2)then
                vioSetElementData(source,"notfallort",message)
                vioSetElementData(source,"notfallcallingpoint",3)
                outputChatBox("Wer ist der Täter (Wenn es keinen gibt schreibe keiner)?",source,0,255,0)
            elseif(station==3)then
                vioSetElementData(source,"notfalltater",message)
                vioSetElementData(source,"notfallcallingpoint",4)
                outputChatBox("Gibt es Zeugen (Wenn es keinen gibt schreibe keiner)?",source,0,255,0)
            else
                vioSetElementData(source,"notfallzeuge",message)
                outputChatBox("Die Nachricht wurde an die Polizei weitergeleitet!",source,0,255,0)

                local policemens=getPlayersInTeam ( team[1] )
                for theKey,thePlayer in ipairs(policemens) do
                    outputChatBox(string.format("Ein Notruf wurde abgesetzt von %s", getPlayerName(source)),thePlayer,0,255,0)
                    outputChatBox(string.format("Was?: %s", vioGetElementData(source,"notfallreason")),thePlayer,0,255,0)
                    outputChatBox(string.format("Wo?: %s", vioGetElementData(source,"notfallort")),thePlayer,0,255,0)
                    outputChatBox(string.format("Wer?: %s", vioGetElementData(source,"notfalltater")),thePlayer,0,255,0)
                    outputChatBox(string.format("Zeugen?: %s", vioGetElementData(source,"notfallzeuge")),thePlayer,0,255,0)
                end

                local policemens=getPlayersInTeam ( team[5] )
                for theKey,thePlayer in ipairs(policemens) do
                    outputChatBox(string.format("Ein Notruf wurde abgesetzt von %s", getPlayerName(source)),thePlayer,0,255,0)
                    outputChatBox(string.format("Was?: %s", vioGetElementData(source,"notfallreason")),thePlayer,0,255,0)
                    outputChatBox(string.format("Wo?: %s", vioGetElementData(source,"notfallort")),thePlayer,0,255,0)
                    outputChatBox(string.format("Wer?: %s", vioGetElementData(source,"notfalltater")),thePlayer,0,255,0)
                    outputChatBox(string.format("Zeugen?: %s", vioGetElementData(source,"notfallzeuge")),thePlayer,0,255,0)
                end
                local policemens=getPlayersInTeam ( team[7] )
                for theKey,thePlayer in ipairs(policemens) do
                    outputChatBox(string.format("Ein Notruf wurde abgesetzt von %s", getPlayerName(source)),thePlayer,0,255,0)
                    outputChatBox(string.format("Was?: %s", vioGetElementData(source,"notfallreason")),thePlayer,0,255,0)
                    outputChatBox(string.format("Wo?: %s", vioGetElementData(source,"notfallort")),thePlayer,0,255,0)
                    outputChatBox(string.format("Wer?: %s", vioGetElementData(source,"notfalltater")),thePlayer,0,255,0)
                    outputChatBox(string.format("Zeugen?: %s", vioGetElementData(source,"notfallzeuge")),thePlayer,0,255,0)
                end

                local policemens=getPlayersInTeam ( team[9] )
                for theKey,thePlayer in ipairs(policemens) do
                    outputChatBox(string.format("Ein Notruf wurde abgesetzt von %s", getPlayerName(source)),thePlayer,0,255,0)
                    outputChatBox(string.format("Was?: %s", vioGetElementData(source,"notfallreason")),thePlayer,0,255,0)
                    outputChatBox(string.format("Wo?: %s", vioGetElementData(source,"notfallort")),thePlayer,0,255,0)
                    outputChatBox(string.format("Wer?: %s", vioGetElementData(source,"notfalltater")),thePlayer,0,255,0)
                    outputChatBox(string.format("Zeugen?: %s", vioGetElementData(source,"notfallzeuge")),thePlayer,0,255,0)
                end

                local policemens=getPlayersInTeam ( team[10] )
                for theKey,thePlayer in ipairs(policemens) do
                    outputChatBox(string.format("Ein Notruf wurde abgesetzt von %s", getPlayerName(source)),thePlayer,0,255,0)
                    outputChatBox(string.format("Was?: %s", vioGetElementData(source,"notfallreason")),thePlayer,0,255,0)
                    outputChatBox(string.format("Wo?: %s", vioGetElementData(source,"notfallort")),thePlayer,0,255,0)
                    outputChatBox(string.format("Wer?: %s", vioGetElementData(source,"notfalltater")),thePlayer,0,255,0)
                    outputChatBox(string.format("Zeugen?: %s", vioGetElementData(source,"notfallzeuge")),thePlayer,0,255,0)
                end

                vioSetElementData(source,"notfallreason",false)
                vioSetElementData(source,"notfallort",false)
                vioSetElementData(source,"notfalltater",false)
                vioSetElementData(source,"notfallzeuge",false)
                vioSetElementData(source,"notfallcallingpoint",false)
                vioSetElementData(source,"notfallcalling",false)
            end



        end
    end
end
addEventHandler("onPlayerChat",getRootElement(),onChatNotfall)


function sms_func(thePlayer,Command,telefonnr,...)
    if(getPlayerMoney(thePlayer))then
        local message=table.concat({...}," ")
        if(telefonnr=="1111")then
            local newsTeam=getPlayersInTeam ( team[3] )
            chat_log(thePlayer,"(news-sms) "..message)
            for theKey,theNewsReporter in ipairs(newsTeam) do
                outputChatBox(string.format("NewsService SMS von %s (TNR: %s): %s", getPlayerName(thePlayer), vioGetElementData(thePlayer,"telefon"), message),theNewsReporter,0,255,0)
            end
            outputChatBox("Die ServiceSms wurde versendet!",thePlayer,0,255,0)

        else
            if(getPlayerMoney(thePlayer)>1.49)then

                local wassendet=1

                telefonnr=tonumber(telefonnr)
                for theKey,theSMS in ipairs(getElementsByType ( "player" ) ) do
                    local number=vioGetElementData(theSMS,"telefon")
                    if(number==telefonnr)then
                        if(vioGetElementData(theSMS,"telefontoggle")==0)then
                            changePlayerMoney(thePlayer,-1.50,"sonstiges","SMS")
                            changeBizKasse(10, 1.5, "SMS")
                            wassendet=3
                            outputChatBox(string.format("SMS von %s (%s): %s", getPlayerName(thePlayer), vioGetElementData(thePlayer,"telefon"), message),theSMS,255,255,0)
                            outputChatBox("Deine SMS wurde erfolgreich versendet!",thePlayer,255,255,0)
                            chat_log(thePlayer,"(SMS) "..message)
                        else
                            wassendet=2
                        end
                    end
                end
                if(wassendet==1)then
                    outputChatBox("SMS von ERRORReport: Diese Telefonnummer existiert nicht!",thePlayer,255,255,0)
                end
                if(wassendet==2)then
                    outputChatBox("SMS von ERRORReport: Das Telefon des Spielers ist ausgeschaltet!",thePlayer,255,255,0)
                end

            else
                showError(thePlayer,"Du hast nicht genuegend Geld!")
            end
        end
    end
end
addCommandHandler("sms",sms_func,false,false)


function checkHangUp(thePlayer)
    if (vioGetElementData(thePlayer,"telestatus")==2)then
        outputChatBox(string.format("Der Spieler %s ist nicht ans Telefon gegangen!", getPlayerName(vioGetElementData(thePlayer,"callwith"))),thePlayer,255,0,0)
        local theSMS=vioGetElementData(thePlayer,"callwith")
        vioSetElementData(theSMS,"isCaller",false)
        vioSetElementData(thePlayer,"isCaller",false)
        --outputChatBox("Du hast aufgelegt!",thePlayer)
        if(isElement(theSMS))then
            outputChatBox("Der Gesprächspartner hat aufgelegt!",vioGetElementData(thePlayer,"callwith"))
        end
        triggerClientEvent(thePlayer,"stopTeleKlingel",thePlayer)
        triggerClientEvent(vioGetElementData(thePlayer,"callwith"),"stopTeleKlingel",vioGetElementData(thePlayer,"callwith"))
        vioSetElementData(thePlayer,"callwith",false)
        vioSetElementData(thePlayer,"telestatus",0)
        vioSetElementData(thePlayer,"telefontoggle",0)
        if(isElement(theSMS))then
            vioSetElementData(theSMS,"callwith",false)
            vioSetElementData(theSMS,"telestatus",0)
            vioSetElementData(theSMS,"telefontoggle",0)
        end


    end
end








