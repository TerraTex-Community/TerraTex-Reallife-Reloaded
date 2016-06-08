function createMarklerMark()
MarklerMarker=createMarker(358.3369140625,168.7734375,1007.3828125,"cylinder",2.0)
setElementInterior(MarklerMarker,3)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createMarklerMark)


function enterScheineMarker(hitElement)
	if(source==MarklerMarker)then

        local bizZoneTable={}
		for theKey,theBiz in ipairs(bizData) do
			local x,y,z=getElementPosition(theBiz["Pickup"])
            bizZoneTable[theKey]=getZoneName(x,y,z)
		end
	
	
	
		triggerClientEvent(hitElement,"openMarklerGui",hitElement,haeuser,bizData,bizZoneTable)
	end
end
addEventHandler( "onMarkerHit", getRootElement(), enterScheineMarker )


addEvent("findHouseMarkler",true)
addEvent("findBizMarkler",true)

function findHouseMarkler_function(theHouseID)
	if(getPlayerMoney(source)>49.99)then
        changePlayerMoney(source,-50,"sonstiges","Nutzung des Maklers in der Stadthalle")
        local x,y,z=haeuser[theHouseID]:getCoords()
		local blip=createBlip (x,y,z ,0,2,0,255,0,255, 0 , 99999.0, source )
		outputChatBox("Das Haus befindet sich an der grün Markierten Stelle! (Die Markierung verschwindet automatisch nach 2 Minuten!)",source)
		setTimer(deleteBlipmarkler,120000,1,blip)
	else
		showError(source,"Du brauchst 5000$ um den Dienst eines Maklers zu nutzen!")
	end



end
addEventHandler("findHouseMarkler",getRootElement(),findHouseMarkler_function)

function findBizMarkler_function(theBizID)
	if(getPlayerMoney(source)>49.99)then
        changePlayerMoney(source,-50,"sonstiges","Nutzung des Maklers in der Stadthalle")
		local bx,by,bz=getElementPosition(bizData[theBizID]["Pickup"])
		local blip=createBlip ( bx,by,bz ,0,2,0,255,0,255, 0 , 99999.0, source )
		outputChatBox("Das Biz befindet sich an der grün Markierten Stelle! (Die Markierung verschwindet automatisch nach 2 Minuten!)",source)
		setTimer(deleteBlipmarkler,120000,1,blip)	
	else
		showError(source,"Du brauchst 5000$ um den Dienst eines Maklers zu nutzen!")
	end


end
addEventHandler("findBizMarkler",getRootElement(),findBizMarkler_function)

function deleteBlipmarkler(blip)
	destroyElement(blip)
end








