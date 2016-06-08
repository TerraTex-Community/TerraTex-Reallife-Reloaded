function int_func(thePlayer,command,int)
    if (isAdminLevel(thePlayer, 1)) then
        setElementInterior(thePlayer, tonumber(int))
    end
end
addCommandHandler("int", int_func, false, false)

spactater = {}

function onspecjoin()
    vioSetElementData(source, "isinSpec", false)
    vioSetElementData(source, "intbespec", false)
    vioSetElementData(source, "dimbespec", false)
    vioSetElementData(source, "xbe", false)
    vioSetElementData(source, "ybe", false)
    vioSetElementData(source, "zbe", false)
    spactater[source] = {}
end
addEventHandler("onPlayerJoin",getRootElement(),onspecjoin)

function spec_func(thePlayer, Command, toPlayerName)
    if (isAdminLevel(thePlayer, 0)) then
        if (toPlayerName) then
            local toPlayer = getPlayerFromIncompleteName(toPlayerName)
            if (toPlayer) and not (vioGetElementData(thePlayer, "isinSpec")) and not (toPlayer == thePlayer) then
                if not(spactater[toPlayer]) then
                    spactater[toPlayer] = {}
                end
                table.insert(spactater[toPlayer], thePlayer)	-- Beobachteten Spieler der Table hinzufügen
                local x, y, z = getElementPosition(thePlayer)	-- Position des Admins holen
                vioSetElementData(thePlayer, "xbe", x)	-- x Coordinate vom Admin speichern
                vioSetElementData(thePlayer, "ybe", y)	-- y Coordinate vom Admin speichern
                vioSetElementData(thePlayer, "zbe", z)	-- z Coordinate vom Admin speichern
                vioSetElementData(thePlayer, "isinSpec", toPlayer)	-- Beobachteten Spieler beim Admin hinzufügen
                local bi = getElementInterior(thePlayer)	-- Interior vom Admin holen
                vioSetElementData(thePlayer, "intbespec", bi)	-- Interior vom Admin speichern
                local dmb = getElementDimension(thePlayer)	-- Dimension vom Admin holen
                vioSetElementData(thePlayer, "dimbespec", dmb)	-- Dimension vom Admin speichern

                local interior = getElementInterior(toPlayer)	-- Intersior vom Beobachteten Spieler holen
                local dim = getElementDimension(toPlayer)	-- Dimension vom Beobachteten Spieler holen

                local tpx,tpy,tpz=getElementPosition(toPlayer)

                if(isPedInVehicle(toPlayer))then
                    setCameraMatrix ( thePlayer, tpx,tpy,tpz+100,tpx,tpy,tpz)

                    setTimer(setCameraTarget,1000,1,thePlayer, toPlayer)	-- Camera des Admins auf den Beobachteten setzen
                else
                    setCameraTarget(thePlayer, toPlayer)
                end
                if(vioGetElementData(toPlayer,"swismi"))then
                    outputChatBox(getPlayerName(thePlayer).." started Spectating You",toPlayer)
                end

                setCameraInterior(thePlayer, interior)	-- Camera Interior des Admins auf den Beobachteten setzen
                setElementDimension(thePlayer, dim) -- Warum den Spieler dorthin versetzen
                setElementInterior(thePlayer, interior) -- Warum den Spieler dorthin versetzen
                            -- Theoretisch sollte man nun richtig speccen. Gut wäre es nun noch, den Spieler zu freezen
                setElementFrozen(thePlayer, true)
                                -- Spieler sollte nun gefreezed sein, damit kann er nicht durch den boden fallen.




            else
                if (vioGetElementData(thePlayer,"isinSpec")) then
                    local toPlayer = vioGetElementData(thePlayer, "isinSpec")
                    if(isElement(toPlayer))then
                        if(vioGetElementData(toPlayer,"swismi"))then
                            outputChatBox(getPlayerName(thePlayer).." stopped Spectating You",toPlayer)
                        end
                        for theKey,theAdmin in ipairs(spactater[toPlayer])do
                            if(theAdmin == thePlayer)then
                                spactater[toPlayer][theKey] = false
                            end
                        end
                    end
                    vioSetElementData(thePlayer, "isinSpec", false)
                    setCameraTarget(thePlayer, thePlayer)
                    local specdim = vioGetElementData(thePlayer, "dimbespec")
                    setElementDimension(thePlayer, tonumber(specdim))
                    local specint = vioGetElementData(thePlayer, "intbespec")
                    setElementInterior(thePlayer, tonumber(specint))
                    setElementPosition(thePlayer,vioGetElementData(thePlayer,"xbe"), vioGetElementData(thePlayer, "ybe"), vioGetElementData(thePlayer, "zbe"))
                    if(isPedInVehicle(thePlayer))then
                        setElementPosition(getPedOccupiedVehicle(thePlayer), vioGetElementData(thePlayer, "xbe"), vioGetElementData(thePlayer, "ybe"), vioGetElementData(thePlayer, "zbe"))

                    end
                    vioSetElementData(thePlayer, "dimbespec", false)
                    vioSetElementData(thePlayer, "intbespec", false)
                    setElementFrozen(thePlayer, false) -- Spieler entfreezen
                else
                    showError(thePlayer, "Benutzen mit: /spec [Name] (Zum beenden der beobachtung falschen Namen eingeben)")
                end
            end
        else
            if (vioGetElementData(thePlayer, "isinSpec")) then
                local toPlayer = vioGetElementData(thePlayer, "isinSpec")
                if(isElement(toPlayer))then
                    if(vioGetElementData(toPlayer,swismi))then
                       outputChatBox(getPlayerName(thePlayer).." stopped Spectating You",toPlayer)
                    end
                    for theKey,theAdmin in ipairs(spactater[toPlayer])do
                        if(theAdmin == thePlayer)then
                            spactater[toPlayer][theKey] = false
                        end
                    end
                end
                vioSetElementData(thePlayer, "isinSpec", false)
                setCameraTarget(thePlayer, thePlayer)
                local specdim = vioGetElementData(thePlayer, "dimbespec")
                setElementDimension(thePlayer, tonumber(specdim))
                local specint = vioGetElementData(thePlayer, "intbespec")
                setElementInterior(thePlayer, tonumber(specint))
                setElementPosition(thePlayer, vioGetElementData(thePlayer, "xbe"), vioGetElementData(thePlayer, "ybe"), vioGetElementData(thePlayer, "zbe"))
                if(isPedInVehicle(thePlayer))then
                    setElementPosition(getPedOccupiedVehicle(thePlayer), vioGetElementData(thePlayer, "xbe"), vioGetElementData(thePlayer, "ybe"), vioGetElementData(thePlayer, "zbe"))

                end
                vioSetElementData(thePlayer, "dimbespec", false)
                vioSetElementData(thePlayer, "intbespec", false)
                setElementFrozen(thePlayer, false) -- Spieler entfreezen
            else
                showError(thePlayer, "Usage: /spec Playername(Falschen Namen eingeben zum Beenden!)")
            end
        end
    end
end
addCommandHandler("spec", spec_func, false, false)

function intdimchange_func(theInterior, theDimension)
    if (spactater[source]) then
        if (theInterior ~= -1) then
            for theKey, theAdmin in ipairs(spactater[source]) do
                if (isElement(theAdmin)) then
                    setCameraInterior(theAdmin, theInterior)
                    setElementInterior(theAdmin, theInterior)
                end
            end
        end
        if (theDimension ~= -1) then
            for theKey, theAdmin in ipairs(spactater[source]) do
                if (isElement(theAdmin)) then
                    setElementDimension(theAdmin, theDimension)
                end
            end
        end
    end
end
addEventHandler("onIntDimChange", getRootElement(), intdimchange_func)

function discospec()
    if (spactater[source]) then
        for theKey, theAdmin in ipairs(spactater[source]) do
            if (isElement(theAdmin)) then
                local toPlayer = vioGetElementData(theAdmin, "isinSpec")
                if (spactater[toPlayer]) then
                    for theKey, theAdmins in ipairs(spactater[toPlayer]) do
                        table.remove(spactater[toPlayer], theKey)
                    end
                end
                vioSetElementData(theAdmin, "isinSpec",false)
                setCameraTarget(theAdmin, theAdmin)
                local specdim = vioGetElementData(theAdmin, "dimbespec")
                setElementDimension(theAdmin, tonumber(specdim))
                local specint = vioGetElementData(theAdmin, "intbespec")
                setElementInterior(theAdmin, tonumber(specint))
                setElementPosition(theAdmin, vioGetElementData(theAdmin, "xbe"), vioGetElementData(theAdmin, "ybe"), vioGetElementData(theAdmin, "zbe"))
                if(isPedInVehicle(theAdmin))then
                    setElementPosition(getPedOccupiedVehicle(theAdmin), vioGetElementData(theAdmin, "xbe"), vioGetElementData(theAdmin, "ybe"), vioGetElementData(theAdmin, "zbe"))

                end
                vioSetElementData(theAdmin,"dimbespec", false)
                vioSetElementData(theAdmin,"intbespec", false)
                setElementFrozen(theAdmin, false)
            end
        end
    end
end
addEventHandler("onPlayerQuit", getRootElement(), discospec)


function whoIsSpectatingMe(thePlayer)
    if(isAdminLevel(thePlayer,3))then
        if(spactater[thePlayer])then
            if(table.getSize(spactater[thePlayer])>0)then
                outputChatBox("Folgende Spieler beobachten dich: ",thePlayer)
                for theKey,toPlayer in ipairs(spactater[thePlayer])do
                    if(isPlayerLoggedIn(toPlayer))then
                        outputChatBox(getPlayerName(toPlayer),thePlayer)
                    end
                end
            else
                outputChatBox("Du wirst von niemanden gespect",thePlayer)
            end
        else
            outputChatBox("Du wirst von niemanden gespect",thePlayer)
        end
    end
end
addCommandHandler("wism",whoIsSpectatingMe,false,false)

function setWhoIsSpectatingMeInfo(thePlayer)
    if(isAdminLevel(thePlayer,3))then
        vioSetElementData(thePlayer,"swismi",not vioGetElementData(thePlayer,"swismi"))
        outputChatBox("SpecInfoSTate: "..tostring(vioGetElementData(thePlayer,"swismi")),thePlayer)
    end
end
addCommandHandler("swismi",setWhoIsSpectatingMeInfo,false,false)








