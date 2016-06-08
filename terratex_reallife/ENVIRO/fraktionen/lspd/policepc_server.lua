policePC={}
function onPolicePCCreate()
	policePC[1]=createObject(2190,234.10,167.399,1003,0,0,272)
	setElementInterior(policePC[1],3)
	policePC[2]=createObject(2190,292.7,181.5,1007.1,0,0,130.75)
	setElementInterior(policePC[2],3)
	policePC[3]=createObject(2190,247.3,119.4,1003.4,0,0,180.75)
	setElementInterior(policePC[3],10)
    policePC[4]=createObject(2190, 230,124.59999847412,1010.0999755859,0,0,214)
    setElementInterior(policePC[4],10)
    policePC[5]=createObject(2190,237,111.19999694824,1010.0999755859,0,0,21.997192382813)
    setElementInterior(policePC[5],10)
    policePC[6]=createObject(2190,250.19999694824,122.69999694824,1003.0999755859,0,0,200)
    setElementInterior(policePC[6],10)
    policePC[7]=createObject(2190,244.39999389648,122.59999847412,1003.0999755859,0,0,199.9951171875)
    setElementInterior(policePC[7],10)
    policePC[8]=createObject(2190,264.39999389648,109.59999847412,1004.299987793,0,0,292)
    setElementInterior(policePC[8],10)

end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),onPolicePCCreate)

function onplayerclickpc(but,vutst,ele)
	if(table.hasValue(policePC,ele))then
		if(isBeamter(source))then
			triggerClientEvent(source,"onShowPolicePC",source,policeVehicles)
		end
	end
end
addEventHandler("onPlayerClick",getRootElement(),onplayerclickpc)

function openPolicePCInPoliceVehicle(thePlayer)
    if(isBeamter(thePlayer))then
       if(isPedInVehicle(thePlayer))then
          if(table.hasValue(policeVehicles, getPedOccupiedVehicle(thePlayer)))then
              triggerClientEvent(thePlayer,"onShowPolicePC",thePlayer,policeVehicles)
          end
       end
    end
end
addCommandHandler("pc", openPolicePCInPoliceVehicle, false,false)







