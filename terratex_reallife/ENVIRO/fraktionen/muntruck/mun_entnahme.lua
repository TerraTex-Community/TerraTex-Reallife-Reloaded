munkisten={
    {false,false,false,false},
    {2503.994140625,-1697.0048828125,12.556974411011,0},
    {false,false,false,false},
    {false,false,false,false},
    {false,false,false,false},
    {732.4462890625,-1450.859375,17.1953125,0},
    {false,false,false,false},
    {false,false,false,false},
    {false,false,false,false},
    {false,false,false,false},
    {2025.013671875,1896.83984375,11.753378868103,0},
    {2788.0625,2261.7734375,10.3203125,0},
    {2378.23828125,1041.6494140625,10.3203125,0}
}

ersatzkiste=false

munkistenFrak={false,false,false,false,false,false,false,false,false,false,false,false,false}



attackerFraktionOfDepot=0
defenderFraktionOfDepot=0
wasAttackInLastFiveHoursOfDepot=false
isAttackofDepot=false
attackOfDepotTimer=false



function onCreateMunEntnahme()
    local kiste=false
    local kisteb=false

    kiste=createObject(1271,1565.615234375,27.0537109375,23.4640625)
    kisteb=createObject(2041,1565.615234375,27.0537109375,23.4640625+0.5)
    ersatzkiste =kiste
    addEventHandler("onElementClicked",kiste,clickonMunKiste)

    for theKey,theCords in pairs(munkisten)do
        if(munkisten[theKey][1]~=false)then
            kiste=createObject(1271,munkisten[theKey][1],munkisten[theKey][2],munkisten[theKey][3])
            kisteb=createObject(2041,munkisten[theKey][1],munkisten[theKey][2],munkisten[theKey][3]+0.5)
            setElementInterior(kiste,munkisten[theKey][4])
            setElementInterior(kisteb,munkisten[theKey][4])
            munkistenFrak[theKey]=kiste
            addEventHandler("onElementClicked",kiste,clickonMunKiste)

            --outputDebugString("loaded MunKiste: "..tostring(theKey).." "..munkisten[theKey][1].." "..munkisten[theKey][2].." "..munkisten[theKey][3].." "..munkisten[theKey][4])
        end
    end


end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),onCreateMunEntnahme)

function checkMunKistenDistance(thePlayer)
    local frak= vioGetElementData(thePlayer,"fraktion")
    local x,y,z=getElementPosition(thePlayer)
    local dis=getDistanceBetweenPoints3D(x,y,z,munkisten[frak][1],munkisten[frak][2],munkisten[frak][3])

    if(frak == defenderFraktionOfDepot and isAttackofDepot)then
        local kx,ky,kz = getElementPosition(ersatzkiste)
        dis=getDistanceBetweenPoints3D(x,y,z,kx,ky,kz)
    end
    if(dis<10)then
        return true
    else
        outputChatBox("Du bist nicht bei der Waffenkiste!",thePlayer,255,0,0)
        return false
    end
end

addEvent("GetMunOutOfFrakMun",true)
function GetMunOutOfFrakMun_func(howMany,weapon)
    if(checkMunKistenDistance(source))then
        local fraktion=vioGetElementData(source,"fraktion")
        if(howMany>frakmun[fraktion])then
            showError(source,"Es liegt nicht soviel Munition im Depot!")
        else
            if(howMany<0)then howMany=-howMany end
            giveWeapon ( source, weapon, howMany)
            frakdepot_log(fraktion,3,-howMany,getPlayerName(source))
            showError(source,string.format("Du hast erfolgreich %s Patronen fuer deine %s aus dem Depot entnommen!", howMany, getWeaponNameFromID(weapon)))
            frakmun[fraktion]=frakmun[fraktion]-howMany
            triggerClientEvent(source,"aktualizeMunDepotGUI",source,frakmun[fraktion])
        end
    end

end
addEventHandler("GetMunOutOfFrakMun",getRootElement(),GetMunOutOfFrakMun_func)


function clickonMunKiste(mouseButton,buttonState, playerWhoClicked)
    if(buttonState=="down")then
        local fraktion=vioGetElementData(playerWhoClicked,"fraktion")
        if(munkistenFrak[fraktion]==source or (source == ersatzkiste and fraktion == defenderFraktionOfDepot and isAttackofDepot))then
            local mun=frakmun[fraktion]
            if(mun==0)then
                showError(playerWhoClicked,"Im Depot befindet sich keine Munition!")
            else
                triggerClientEvent(playerWhoClicked,"showMunTruckEntnahmeGUI",playerWhoClicked,mun)
            end
        elseif(source ~= ersatzkiste)then
            if(munkistenFrak[fraktion])then

                if(not(wasAttackInLastFiveHoursOfDepot))then
                    local beginAttackAT=0
                    for theKey,theKiste in ipairs(munkistenFrak)do
                        if(theKiste==source)then
                            beginAttackAT=theKey
                        end
                    end
                    local playerOnlineOfDefender=0
                    for theKey,thePlayer in ipairs(getPlayersInTeam(team[beginAttackAT]))do
                        playerOnlineOfDefender=playerOnlineOfDefender+1
                    end
                    local x,y,z=getElementPosition(playerWhoClicked)
                    if(getDistanceBetweenPoints3D(x,y,z,munkisten[beginAttackAT][1],munkisten[beginAttackAT][2],munkisten[beginAttackAT][3]))then
                        if(playerOnlineOfDefender>0)then
                            wasAttackInLastFiveHoursOfDepot=true
                            isAttackofDepot=true
                            attackerFraktionOfDepot=fraktion
                            defenderFraktionOfDepot=beginAttackAT
                            for theKey,thePlayers in ipairs(getPlayersInTeam(team[beginAttackAT]))do
                                outputChatBox("Das Fraktionsdepot wird angegriffen!",thePlayers,255,0,0)
                            end
                            for theKey,thePlayers in ipairs(getPlayersInTeam(team[fraktion]))do
                                outputChatBox("Ihr habt ein Angriff auf ein Fraktionsdepot gestartet! Haltet 15 Minuten an der Kiste aus um das Sicherheitssystem zu knacken!",thePlayers,255,0,0)
                            end
                            attackOfDepotTimer=setTimer(winAttackOfDepot,900000,1)
                            setTimer(resetAttackingOfDepot,18000000,1)

                            spawnErsatzKistenAttackCars(defenderFraktionOfDepot)

                        else
                            outputChatBox("Es sind nicht genügend Spieler Online von der Fraktion die du angreifen möchtest!",playerWhoClicked,255,0,0)
                        end
                    end
                else
                    outputChatBox("Es wurde bereits ein Depot innerhalb der letzten 5 Stunden überfallen!",playerWhoClicked,255,0,0)
                end
            end

        end
    end
end

-- local vehicle = createVehicle(507, 658.591796875, -1501.5361328125, 14.692559242249, 359.7802734375, 359.99450683594, 270.03845214844, "LLS")    --  mafiaauto
-- table.insert(frakselfcars[6], vehicle)

local ersatzCars={}
function spawnErsatzKistenAttackCars(attackerFrak)

    ersatzCars = {}
    local model = getElementModel(frakselfcars[attackerFrak][math.random(1,table.getSize(frakselfcars[attackerFrak]))])

    local vehicle = createVehicle(model,1568.3740234375,31.169921875,23.884763717651,359.296875,359.06616210938,92.103881835938, "Ersatz")
    table.insert(ersatzCars, vehicle)
    model = getElementModel(frakselfcars[attackerFrak][math.random(1,table.getSize(frakselfcars[attackerFrak]))])
    vehicle = createVehicle(model,1587.92578125,33.2548828125,24.274959564209,357.23693847656,357.22595214844,94.482421875, "Ersatz")
    table.insert(ersatzCars, vehicle)
    model = getElementModel(frakselfcars[attackerFrak][math.random(1,table.getSize(frakselfcars[attackerFrak]))])
    vehicle = createVehicle(model,1587.4111328125,26.125,24.084836959839,357.16003417969,356.72607421875,93.9990234375, "Ersatz")
    table.insert(ersatzCars, vehicle)
    model = getElementModel(frakselfcars[attackerFrak][math.random(1,table.getSize(frakselfcars[attackerFrak]))])
    vehicle = createVehicle(model,1550.408203125,-27.4443359375,20.967119216919,0.2252197265625,359.97802734375,271.68640136719, "Ersatz")
    table.insert(ersatzCars, vehicle)
    model = getElementModel(frakselfcars[attackerFrak][math.random(1,table.getSize(frakselfcars[attackerFrak]))])
    vehicle = createVehicle(model,1544.142578125,13.6328125,23.937568664551,0.0384521484375,359.83520507813,282.09045410156, "Ersatz")
    table.insert(ersatzCars, vehicle)
    model = getElementModel(frakselfcars[attackerFrak][math.random(1,table.getSize(frakselfcars[attackerFrak]))])
    vehicle = createVehicle(model,1543.28125,16.6611328125,23.938821792603,359.96154785156,0.1373291015625,282.02453613281, "Ersatz")
    table.insert(ersatzCars, vehicle)
    model = getElementModel(frakselfcars[attackerFrak][math.random(1,table.getSize(frakselfcars[attackerFrak]))])
    vehicle = createVehicle(model,1542.5888671875,19.484375,23.940605163574,0,359.98901367188,280.52490234375, "Ersatz")
    table.insert(ersatzCars, vehicle)

    local colorA,colorB,colorC,colorD,colorE,colorF=getVehicleColor(frakselfcars[attackerFrak][1])
    for key, theVehicle in pairs(ersatzCars) do
        prepare(theVehicle, attackerFrak)
        setVehicleColor (theVehicle, colorA,colorB,colorC,colorD,colorE,colorF)
        vioSetElementData(theVehicle, "tank", 100)
        addEventHandler("onVehicleStartEnter", theVehicle, dontEnterErsatzCars)
        table.insert(frakcars, theVehicle)
    end

end

function dontEnterErsatzCars(player, seat, jacked ,door)
    if ((vioGetElementData(player,"fraktion")~=defenderFraktionOfDepot)and(seat==0))then
        cancelEvent()
    end
end

function resetAttackingDefendCars(attackerFrak)

    for theKey, theVehicle in pairs(ersatzCars)do
        frakcars = table.deletevalue(frakcars,theVehicle,true)
        destroyElement(theVehicle)
    end
    ersatzCars = {}
end


function winAttackOfDepot()
    setTimer(resetAttackingDefendCars,10000,1,defenderFraktionOfDepot)

    local peopleInNearOfDepot=0
    local kx,ky,kz=getElementPosition(munkistenFrak[defenderFraktionOfDepot])
    for theKey,thePlayers in ipairs(getPlayersInTeam(team[attackerFraktionOfDepot]))do
        local px,py,pz=getElementPosition(thePlayers)
        local dis=getDistanceBetweenPoints3D(px,py,pz,kx,ky,kz)
        if(dis<20)then
            peopleInNearOfDepot=peopleInNearOfDepot+1
        end
    end
    if(peopleInNearOfDepot>0)then
        local erbeutung=math.random(5,15)
        local zerstoerung=math.random(1,7)
        local ermon=math.round(frakkasse[defenderFraktionOfDepot]/100*erbeutung)
        local erdro=math.round(frakdrogen[defenderFraktionOfDepot]/100*erbeutung)
        local ermun=math.round(frakmun[defenderFraktionOfDepot]/100*erbeutung)

        local zermon=math.round(frakkasse[defenderFraktionOfDepot]/100*zerstoerung)
        local zerdro=math.round(frakdrogen[defenderFraktionOfDepot]/100*zerstoerung)
        local zermun=math.round(frakmun[defenderFraktionOfDepot]/100*zerstoerung)

        frakkasse[attackerFraktionOfDepot]=frakkasse[attackerFraktionOfDepot]+ermon
        frakdrogen[attackerFraktionOfDepot]=frakdrogen[attackerFraktionOfDepot]+erdro

        frakmun[attackerFraktionOfDepot]=frakmun[attackerFraktionOfDepot]+ermun
        frakdepot_log(attackerFraktionOfDepot,1,ermon,"Kistenangriff")
        frakdepot_log(attackerFraktionOfDepot,2,erdro,"Kistenangriff")
        frakdepot_log(attackerFraktionOfDepot,3,ermun,"Kistenangriff")


        frakkasse[defenderFraktionOfDepot]=frakkasse[defenderFraktionOfDepot]-ermon-zermon
        frakdrogen[defenderFraktionOfDepot]=frakdrogen[defenderFraktionOfDepot]-erdro-zerdro
        frakmun[defenderFraktionOfDepot]=frakmun[defenderFraktionOfDepot]-ermun-zermun
        frakdepot_log(defenderFraktionOfDepot,1,(-ermon-zermon),"Kistenangriff")
        frakdepot_log(defenderFraktionOfDepot,2,(-erdro-zerdro),"Kistenangriff")
        frakdepot_log(defenderFraktionOfDepot,3,(-ermun-zermun),"Kistenangriff")


        for theKey,thePlayers in ipairs(getPlayersInTeam(team[attackerFraktionOfDepot]))do
            outputChatBox(string.format("Der Angriff war erfolgreich! Ihr habt %s, %sg Drogen und %s Munition erbeutet!", toprice(ermon), erdro, ermun),thePlayers,255,0,0)
        end
        for theKey,thePlayers in ipairs(getPlayersInTeam(team[defenderFraktionOfDepot]))do
            outputChatBox(string.format("Ihr konntet das Depot nicht verteidigen! Die Gegner haben %s, %sg Drogen und %s Munition erbeutet!", toprice(ermon), erdro, ermun),thePlayers,255,0,0)
            outputChatBox(string.format("Leider wurden weitere %s, %sg Drogen und %s Munition zerstört", toprice(zermon), zerdro, zermun),thePlayers,255,0,0)
        end
        attackerFraktionOfDepot=0
        defenderFraktionOfDepot=0
        isAttackofDepot=false
        attackOfDepotTimer=false

    else
        for theKey,thePlayers in ipairs(getPlayersInTeam(team[attackerFraktionOfDepot]))do
            outputChatBox("Ihr konntet leider nicht an der Kiste bleiben! Der Angriff ist fehlgeschlagen!",thePlayers,255,0,0)
        end
        for theKey,thePlayers in ipairs(getPlayersInTeam(team[defenderFraktionOfDepot]))do
            outputChatBox("Ihr habt den Angriff erfolgreich abgewehrt!",thePlayers,255,0,0)
        end
        attackerFraktionOfDepot=0
        defenderFraktionOfDepot=0
        isAttackofDepot=false
        attackOfDepotTimer=false
    end
end

function resetAttackingOfDepot()
    attackerFraktionOfDepot=0
    defenderFraktionOfDepot=0
    wasAttackInLastFiveHoursOfDepot=false
    isAttackofDepot=false
    attackOfDepotTimer=false

end


function checkDeathOfDepot()
    if(isAttackofDepot)then
        if(vioGetElementData(source,"fraktion")==attackerFraktionOfDepot)then
            local peopleInNearOfDepot=0
            local kx,ky,kz=getElementPosition(munkistenFrak[defenderFraktionOfDepot])
            for theKey,thePlayers in ipairs(getPlayersInTeam(team[attackerFraktionOfDepot]))do
                local px,py,pz=getElementPosition(thePlayers)
                local dis=getDistanceBetweenPoints3D(px,py,pz,kx,ky,kz)
                if(dis<10)and not(isPedDead ( thePlayers ))then
                    peopleInNearOfDepot=peopleInNearOfDepot+1
                end
            end
            if(peopleInNearOfDepot==0)then
                setTimer(resetAttackingDefendCars,10000,1,defenderFraktionOfDepot)
                for theKey,thePlayers in ipairs(getPlayersInTeam(team[attackerFraktionOfDepot]))do
                    outputChatBox("Ihr konntet leider nicht an der Kiste bleiben! Der Angriff ist fehlgeschlagen!",thePlayers,255,0,0)
                end
                for theKey,thePlayers in ipairs(getPlayersInTeam(team[defenderFraktionOfDepot]))do
                    outputChatBox("Ihr habt den Angriff erfolgreich abgewehrt!",thePlayers,255,0,0)
                end
                attackerFraktionOfDepot=0
                defenderFraktionOfDepot=0
                isAttackofDepot=false
                killTimer(attackOfDepotTimer)
                attackOfDepotTimer=false
            end
        end

    end
end
addEventHandler("onPlayerWasted",getRootElement(),checkDeathOfDepot)













