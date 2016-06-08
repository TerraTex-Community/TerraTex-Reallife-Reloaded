--
-- Created by IntelliJ IDEA.
-- User: Geramy
-- Date: 11.08.2014
-- Time: 20:37
-- To change this template use File | Settings | File Templates.
--

function checkAddLaufUndSchwimm()
    setTimer(checkAddLaufUndSchwimm,1000,1)
    for theKey,thePlayer in ipairs(getElementsByType("player"))do
        if(isPlayerLoggedIn(thePlayer))then
            if(not isPedInVehicle(thePlayer) and getElementInterior(thePlayer)==0)then
                if(isElementInWater ( thePlayer ))then
                   local x,y,z=getElementPosition(thePlayer)
                   if(vioGetElementData(thePlayer,"lastSwimRunState")=="water")then
                       local oldKoord=vioGetElementData(thePlayer,"lastSwimRunKoords")
                       local dis=getDistanceBetweenPoints3D(oldKoord[1],oldKoord[2],oldKoord[3],x,y,z)
                       vioSetElementData(thePlayer,"Punkte_Rekordschwimmer",vioGetElementData(thePlayer,"Punkte_Rekordschwimmer")+dis)
                       if(vioGetElementData(thePlayer,"Punkte_Rekordschwimmer")>10000)then
                           if(vioGetElementData(thePlayer,"Erfolg_Rekordschwimmer")~=1)then
                               vioSetElementData(thePlayer,"Erfolg_Rekordschwimmer",1)
                               triggerClientEvent(thePlayer,"onClientCreatePokalGUI",thePlayer,"Rekordschwimmer","10km geschwommen.")
                           end
                       end
                   end

                   vioSetElementData(thePlayer,"lastSwimRunKoords",{x,y,z})
                   vioSetElementData(thePlayer,"lastSwimRunState","water")

                elseif(isPedOnGround ( thePlayer))then
                    local x,y,z=getElementPosition(thePlayer)
                    if(vioGetElementData(thePlayer,"lastSwimRunState")=="ground")then
                        local oldKoord=vioGetElementData(thePlayer,"lastSwimRunKoords")
                        local dis=getDistanceBetweenPoints3D(oldKoord[1],oldKoord[2],oldKoord[3],x,y,z)
                        vioSetElementData(thePlayer,"Punkte_Langlaeufer",vioGetElementData(thePlayer,"Punkte_Langlaeufer")+dis)
                        if(vioGetElementData(thePlayer,"Punkte_Langlaeufer")>1000000)then
                            if(vioGetElementData(thePlayer,"Erfolg_Langlaeufer")~=1)then
                                vioSetElementData(thePlayer,"Erfolg_Langlaeufer",1)
                                triggerClientEvent(thePlayer,"onClientCreatePokalGUI",thePlayer,"Langläufer","1,000km gelaufen.")
                            end
                        end
                    end

                    vioSetElementData(thePlayer,"lastSwimRunKoords",{x,y,z})
                    vioSetElementData(thePlayer,"lastSwimRunState","ground")
                end
            end
        end
    end

end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),checkAddLaufUndSchwimm)










