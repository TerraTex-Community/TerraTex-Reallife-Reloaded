--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 15.05.14
-- Time: 19:34
-- To change this template use File | Settings | File Templates.
--



function createMoebelMarker()
    local marker=createMarker(966.8759765625,2160.5458984375,10.8203125,"corona",1.0)
    addEventHandler("onMarkerHit",marker,hitMoebelMarker)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createMoebelMarker)

function hitMoebelMarker(thePlayer)
    if(getElementType(thePlayer)=="player")then
        if(not isPedInVehicle(thePlayer))then
            if(vioGetElementData(thePlayer,"wanteds")==0)then
                if(vioGetElementData(thePlayer,"hkey")>0)then
                    local hID=vioGetElementData(thePlayer,"hkey")
                    local haus=haeuser[hID]
                    local validIR={}
                    for theKey, theIR in pairs(iraeume)do
                        if(theIR:getStockwerke()<=haus:getStockwerke())then --Innenraum darf nicht mehr Stockwerke haben als das Haus
                            if(theIR:getQM()<=haus:getQM())then --IR darf nicht mehr QM haben als Haus
                                if(theIR:getWert()<=haus:getWert())then --IR darf nicht mehr Wert haben als Haus
                                    table.insert(validIR,theIR)
                                end
                            end
                        end
                    end
                    triggerClientEvent(thePlayer,"recieveValidIraum",thePlayer,validIR,haus:getIRaum())
                else
                    showError(thePlayer,"Du bist nicht Besitzer eines Hauses. Du kannst unseren Laden nicht benutzen.")
                end
            else
                showError(thePlayer,"Tut uns Leid, aber Verbrecher wollen wir nicht in unserem Laden. Werde erst deine Wanteds los!")
            end
        end
    end
end

addEvent("leaveMoebel_event",true)
function portPlayerOutOfMoebel()
    setElementInterior(source,0)
    setElementDimension(source,0)
    setElementPosition(source,967.048828125,2153.7392578125,10.8203125)
end
addEventHandler("leaveMoebel_event",getRootElement(),portPlayerOutOfMoebel)

addEvent("sellOldIR_event",true)
function sellOldIR_event_func()
    local haus=haeuser[vioGetElementData(source,"hkey")]
    if(haus:getIRaum()>0)then
        local irid=haus:getIRaum()
        local preis=iraeume[irid]:getPreis()*0.65
        changePlayerBank(source,preis,"sonstiges","Innenraum-Verkauf")
        showError(source,"Du hast dein Innenraum für "..toprice(preis).." verkauft. Das Geld wurde dir aufs Konto überwiesen!")
        haus:setIRaum(0)
    end
end
addEventHandler("sellOldIR_event",getRootElement(),sellOldIR_event_func)

addEvent("buyNewIR_event",true)
function sellNewIR_event_func(irID)
    local haus=haeuser[vioGetElementData(source,"hkey")]
    local preis=0
    if(haus:getIRaum()>0)then
        --Wert Alter Innenraum
        local irid=haus:getIRaum()
        preis=iraeume[irid]:getPreis()*0.65
    end
    local newPreis=iraeume[irID]:getPreis()
    newPreis=newPreis-preis
    if(newPreis>0 and getPlayerBank(source)>=newPreis)then
        showError(source,"Du hast den neuen Innenraum für "..toprice(newPreis).." (Verrechnet mit alten Innenraum) erworben.")
        changePlayerBank(source,-newPreis,"sonstiges","Innenraum-Kauf")
        haus:setIRaum(irID)
        triggerClientEvent(source,"syncNewIR_event",source,irID)
    elseif(newPreis>0)then
        showError(source,"Dein Kontostand ist nicht hoch genug, um diesen Innenraum zu kaufen!")
    else
        showError(source,"Du hast den neuen Innenraum gekauft. Nach der Verrechnung mit dem alten Innenraum wurden dir noch "..toprice(-newPreis).." gutgeschrieben")
        changePlayerBank(source,-newPreis,"sonstiges","Innenraum-Kauf")
        haus:setIRaum(irID)
        triggerClientEvent(source,"syncNewIR_event",source,irID)
    end
end
addEventHandler("buyNewIR_event",getRootElement(),sellNewIR_event_func)








