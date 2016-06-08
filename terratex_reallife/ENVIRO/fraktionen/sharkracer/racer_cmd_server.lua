--
-- Created by IntelliJ IDEA.
-- User: Geramy
-- Date: 23.02.2015
-- Time: 20:22
-- To change this template use File | Settings | File Templates.
--

addEvent("startRace",true)
function startRace_func(gegner, preis, ziel)
    vioSetElementData(gegner, "Racer", source)
    vioSetElementData(gegner, "RacePrice", preis)

    vioSetElementData(gegner, "RaceTarget", ziel)
    outputChatBox("Du wurdest zu einem Rennen von "..getPlayerName(source).." herrausgefordert. Es geht um "..toprice(preis)..". Um das Rennen zu beginnen nutze /accept race", gegner)
end
addEventHandler("startRace", getRootElement(),startRace_func)

function acceptRace(thePlayer)
    if(vioGetElementData(thePlayer,"Racer"))then
        setElementFrozen(thePlayer, true)
        setElementFrozen(vioGetElementData(thePlayer,"Racer"), true)
        setElementFrozen( getPedOccupiedVehicle ( thePlayer) , true)
        setElementFrozen( getPedOccupiedVehicle ( vioGetElementData(thePlayer,"Racer")) , true)

        outputChatBox(getPlayerName(thePlayer).." hat die Herrausforderung angenommen!", vioGetElementData(thePlayer,"Racer"))
        outputChatBox("Das Rennen beginnt in 20 Sekunden. Wer zuerst am Hellblauen Marker / Flage auf der Karte ist gewinnt.", thePlayer)
        outputChatBox("Das Rennen beginnt in 20 Sekunden. Wer zuerst am Hellblauen Marker / Flage auf der Karte ist gewinnt.", vioGetElementData(thePlayer,"Racer"))
        local ziel = vioGetElementData(thePlayer, "RaceTarget")
        local raceMarker = createMarker ( ziel[1], ziel[2], ziel[3], "checkpoint", 4.0, 0, 213, 255, 255, thePlayer)
        setMarkerIcon ( raceMarker, "finish" )
        setElementVisibleTo(raceMarker, vioGetElementData(thePlayer,"Racer"), true)
        vioSetElementData(raceMarker, "Racer", vioGetElementData(thePlayer,"Racer"))
        vioSetElementData(raceMarker, "Gegner", thePlayer)
        vioSetElementData(raceMarker, "price", vioGetElementData(thePlayer, "RacePrice") * 2)
        local Blip = createBlip ( ziel[1], ziel[2], ziel[3] ,53, 4, 0, 213, 255, 255, 0, 99999.0, thePlayer)
        setElementVisibleTo(Blip, vioGetElementData(thePlayer,"Racer"), true)
        vioSetElementData(raceMarker, "blip", Blip)
        addEventHandler("onMarkerHit", raceMarker, winner_hit_racemarker)
        setTimer(showRaceStartInfo,10000,1,thePlayer,vioGetElementData(thePlayer,"Racer"), 10)

        changePlayerMoney(thePlayer, -vioGetElementData(thePlayer, "RacePrice"), "Race", "Renneinsatz", "")
        changePlayerMoney(vioGetElementData(thePlayer,"Racer"), -vioGetElementData(thePlayer, "RacePrice"), "sonstiges", "Renneinsatz", "")

        vioSetElementData(thePlayer,"inRacing", true)
        vioSetElementData(vioGetElementData(thePlayer,"Racer"),"inRacing", true)

        vioSetElementData(thePlayer, "Racer", false)
        vioSetElementData(thePlayer, "RacePrice", false)
        vioSetElementData(thePlayer, "RaceTarget", false)

        local x,y,z = getElementPosition(thePlayer)
        local start = getZoneName ( x,y,z).." ("..getZoneName ( x,y,z, true)..")"
        local ziel = getZoneName (ziel[1], ziel[2], ziel[3]).." ("..getZoneName (ziel[1], ziel[2], ziel[3], true)..")"

        outputChatBoxForPolice("Informant: Es findet ein illegales Straßenrennen statt mit 2 Teilnehmern von "..start.." nach "..ziel,255,0,0)

    end
end

function showRaceStartInfo(Racer, Gegner, rest)
    if(rest > 5)then
        setTimer(showRaceStartInfo,5000,1,Racer,Gegner,5)
    else
        showRaceStartInfoCountdown(Racer, Gegner, rest, false, false)
    end
    outputChatBox("Das Rennen beginnt in "..rest.." Sekunden. Wer zuerst am Hellblauen Marker / Flage auf der Karte ist gewinnt.", Racer)
    outputChatBox("Das Rennen beginnt in "..rest.." Sekunden. Wer zuerst am Hellblauen Marker / Flage auf der Karte ist gewinnt.", Gegner)
end

function showRaceStartInfoCountdown(Racer, Gegner, rest, display, text)

    if not text and not display then
        display = textCreateDisplay()
        text = textCreateTextItem ( rest , 0.5,0.5,"high",0,213,255,255,10,"center","center",150 )
        textDisplayAddText ( display, text )
        textDisplayAddObserver ( display, Racer )
        textDisplayAddObserver ( display, Gegner )
    end
    textItemSetText ( text, rest )
    if(rest > 0)then
        rest = rest - 1
        setTimer(showRaceStartInfoCountdown,1000,1,Racer, Gegner, rest, display, text)
    else
        textDestroyTextItem (text)
        textDestroyDisplay(display)
        setElementFrozen(Racer, false)
        setElementFrozen(Gegner, false)
        setElementFrozen(getPedOccupiedVehicle(Racer), false)
        setElementFrozen(getPedOccupiedVehicle(Gegner), false)
        outputChatBox("GO GO GO", Racer)
        outputChatBox("GO GO GO", Racer)
        outputChatBox("GO GO GO", Racer)
        outputChatBox("GO GO GO", Gegner)
        outputChatBox("GO GO GO", Gegner)
        outputChatBox("GO GO GO", Gegner)
    end
end


function winner_hit_racemarker(hitElement)
    local Gegner = vioGetElementData(source, "Gegner")
    local Racer = vioGetElementData(source, "Racer")
    local Price = vioGetElementData(source, "price")
    local Blip = vioGetElementData(source, "blip")
    if(hitElement == Gegner)then
        changePlayerMoney(Gegner, Price, "sonstiges", "Renngewinn", "")
        showError(Gegner, "Du hast das Rennen gewonnen. Dir wurde der gesamte Einsatz von "..toprice(Price).." übergeben.")
        showError(Racer, "Tja.... du hast den kürzeren gezogen.")
        destroyElement(Blip)
        destroyElement(source)


        vioSetElementData(Gegner,"inRacing", false)
        vioSetElementData(Racer,"inRacing", false)
    elseif(hitElement == Racer)then
        changePlayerMoney(Racer, Price, "sonstiges", "Renngewinn", "")
        showError(Racer, "Du hast das Rennen gewonnen. Dir wurde der gesamte Einsatz von "..toprice(Price).." übergeben.")
        showError(Gegner, "Tja.... du hast den kürzeren gezogen.")
        destroyElement(Blip)
        destroyElement(source)


        vioSetElementData(Gegner,"inRacing", false)
        vioSetElementData(Racer,"inRacing", false)
    end
end