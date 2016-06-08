
SexShopMarkers={}
function createSexShopMarkers()

	marker=createMarker(-105.3212890625,-11.2841796875,1000.71875,"corona",2)  
	table.insert(SexShopMarkers,{marker,-105.3212890625,-11.2841796875,1000.71875}) 
	setElementInterior(marker,3)
	for i=1,20,1 do
		local marker= createMarker(-105.3212890625,-11.2841796875,1000.71875,"corona",1)
		setElementInterior(marker,3)
		setElementDimension(marker,i)
	end
		
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createSexShopMarkers)

--{weapID,Preis}
SexShopWaren={{11,4.99},{12,9.99},{13,9.99},{10,14.99},{-1,2.50}}
addEvent("buySexShopGUI_Event",true)
function buySexShopGUI(id)
	--outputChatBox(tostring(id))
	if(getPlayerMoney(source)<SexShopWaren[id][2])then
		showError(source,"Du hast nicht genug Geld!")	
	else
        changePlayerMoney(source,-SexShopWaren[id][2],"sonstiges","Einkauf im Sexshop")
		if(SexShopWaren[id][1]~=-1)then
			giveWeapon ( source, SexShopWaren[id][1] )
			showError(source,"Du hast erfolgreich diesen Dildo gekauft!")
            changeBizKasse(12, SexShopWaren[id][2], "Einkauf")
		else
			if(id==5)then
				vioSetElementData(source,"Kondome",vioGetElementData(source,"Kondome")+5)
				showError(source,"Du hast erfolgreich eine 5er Packung Kondome gekauft!")
                changeBizKasse(12, 2.50, "Einkauf")
			end
		
		
		end
	end
end
addEventHandler("buySexShopGUI_Event",getRootElement(),buySexShopGUI)



function loadSexShop_func(hitElement)
	for theKey,theMarker in ipairs (SexShopMarkers)do
		if(theMarker[1]==source)then
			vioSetElementData(hitElement,"lastSexShop",theKey)			
			triggerClientEvent(hitElement,"showSexGUI_Event",hitElement)
			break
		end
	
	end
end
addEventHandler("onMarkerHit",getRootElement(),loadSexShop_func)

addEvent("closeSexShopGUI_Event",true)
function closeSexShopGUI()
	local id=vioGetElementData(source,"lastSexShop")
	setElementPosition(source,SexShopMarkers[id][2],SexShopMarkers[id][3],SexShopMarkers[id][4])
end
addEventHandler("closeSexShopGUI_Event",getRootElement(),closeSexShopGUI)








