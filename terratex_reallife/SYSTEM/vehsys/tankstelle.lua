local tankmarkercords={
{1005.279296875,-933.251953125,41.1796875,2.0},
{1938.9326171875,-1773.38671875,12.3828125,2.0},
{1485.7421875,-2425.939453125,13.5546875,6.0}, --Spez
{-94.0146484375,-1175.1796875,1.9937258958817,2.0},
{-100.0068359375,-1172.4462890625,2.1999135017395,2.0},
{-1609.7587890625,-2718.27734375,48.266124725342,2.0},
{-1603.6376953125,-2709.052734375,48.261840820312,2.0},
{-2244.3984375,-2561.1142578125,31.648958206177,2.0},
{-2029.322265625,157.6513671875,28.563018798828,2.0},
{-2414.8896484375,975.119140625,45.023956298828,2.0},
{-2406.9833984375,971.8740234375,45.02632522583,2.0},
{-1329.486328125,2671.9453125,49.789577484131,2.0},
{-1327.01953125,2682.8017578125,49.789585113525,2.0},
{-1466.109375,1863.4296875,32.36164855957,2.0},
{70.408203125,1218.744140625,18.53918838501,2.0},
{621.5537109375,1679.708984375,6.7192716598511,2.0},
{615.46875,1690.236328125,6.7192645072937,2.0},
{609.0615234375,1699.529296875,6.7210984230042,2.0},
{2145.826171875,2750.6884765625,10.547393798828,2.0},
{2638.873046875,1104.259765625,10.543460845947,2.0},
{2115.998046875,922.5361328125,10.547393798828,2.0},
{1594.5703125,2206.6318359375,10.547393798828,2.0},
{658.2744140625,-560.224609375,16.063018798828,2.0},
{-1674.1083984375,418.0009765625,7.1729331016541,2.0},
{-1674.6298828125,404.2578125,7.1708655357361,2.0},
{2311.5166015625,-2420.005859375,-0.26488932967186,6.0}, --spez
{2199.6396484375,2474.56640625,10.8203125,2},
 {-1114.0859375,-174.078125,14.24893283844,6}, --spez
 {1638.0517578125,554.4462890625,-0.74756044149399,6}, --spez
 {1300.533203125,1436.0380859375,10.9107971191410,6}, --spez
 {300.2060546875,2065.2939453125,17.640625,3}, --spez
{-1674.6298828125,404.2578125,7.1708655357361,2.0},
{1637.3968505859, 83.283386230469, 37.073993682861,2.0}
}


local tankmarkers={}
local blipcoord={}
function createTankstellenMarker()
	
	for theKey,theCoord in ipairs(tankmarkercords) do
		local marker=createMarker ( theCoord[1],theCoord[2],theCoord[3],"cylinder",theCoord[4])
		if(theCoord[4]>2)then
			vioSetElementData(marker,"repairMarker",true)
		end
		addEventHandler( "onMarkerHit", marker, TankenMarkerHit )
		table.insert(tankmarkers,marker)
		setElementShowText(marker,0xFFFF00FF,"Tankpreis: ",false,theCoord[4]*15,2,1.5)
		--[[local shape=createMarker ( theCoord[1],theCoord[2],theCoord[3],"cylinder",theCoord[4]*15,0,0,0,0)
		addEventHandler ( "onMarkerHit", shape, showTankPrice )
		addEventHandler ( "onMarkerLeave", shape, hideTankPrice )]]
		--createBlip(theCoord[1],theCoord[2],theCoord[3],42,0.5,255,0,0,255,0,255,getRootElement())
		table.insert(blipcoord,{theCoord[1],theCoord[2],theCoord[3]})
	end	
	

end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createTankstellenMarker)

function onPlayerJoinTransferBlips()
	setTimer(loadBlips,10000,1,source)
end
addEventHandler("onPlayerJoin",getRootElement(),onPlayerJoinTransferBlips)

function loadBlips(source)
	if(isElement(source))then
		for theKey,thecoordPaar in ipairs(blipcoord)do
			triggerClientEvent(source,"createCustomBlip_event",source, thecoordPaar[1],thecoordPaar[2], 12,12, "FILES/IMAGES/blips/tanke.png", 255 )
		end
	end
end
--[[
local tankdisplay=false
local tankdisplaytext=false

function showTankPrice(thePlayer)
	if(getElementType(thePlayer)=="player")then
		textDisplayAddObserver ( tankdisplay, thePlayer )
	elseif(getElementType(thePlayer)=="vehicle")then
		local occupants = getVehicleOccupants(thePlayer) 
        local seats = getVehicleMaxPassengers(thePlayer) 
        for seat = 0, seats,1 do 
			if(occupants[seat])then
				textDisplayAddObserver (tankdisplay,occupants[seat])
			end		
		end 
		
	end
end

function hideTankPrice(thePlayer)
	if(getElementType(thePlayer)=="player")then
		textDisplayRemoveObserver ( tankdisplay, thePlayer )
	elseif(getElementType(thePlayer)=="vehicle")then
		local occupants = getVehicleOccupants(thePlayer) 
        local seats = getVehicleMaxPassengers(thePlayer) 
        for seat = 0, seats,1 do 
			if(occupants[seat])then
				textDisplayRemoveObserver (tankdisplay,occupants[seat])
			end		
		end 
		
	end
end
]]

function globalTankTimer()
		local aenderung=((math.random(1,300)/100)-1.5)/10
		if((serversettings["tankpreis"]+aenderung)<0.80)then
			serversettings["tankpreis"]=0.80
		elseif((serversettings["tankpreis"]+aenderung)>1.815)then
			serversettings["tankpreis"]=1.815
		else
			serversettings["tankpreis"]=serversettings["tankpreis"]+aenderung
		end
		for theKey,theMarker in ipairs(tankmarkers) do
			changeElementShowText(theMarker,0xFFFF00FF,string.format("Tankpreis: %s $/l", serversettings["tankpreis"]))
		end
	--	textItemSetText(tankdisplaytext,"Tankpreis: "..serversettings["tankpreis"].." $/l")
	setTimer(globalTankTimer,3600000,1)
end


function setCreateTextDisplayInMinutes()

		setTimer(globalTankTimer,20000,1)
	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),setCreateTextDisplayInMinutes)



function enSpeedTank_cmd(thePlayer,cmd,type)
    if type then type=tonumber(type) end

    if not type then type=0 end
    if type~=1 and type~=2 then type=0 end
	if(vioGetElementData(thePlayer,"premium")>0)then
		if(vioGetElementData(thePlayer,"speedtank")==0 or type>0)then
            if(type==0)then type=1 end
			vioSetElementData(thePlayer,"speedtank",type)
            if type==1 then
			    outputChatBox("Schnelltanken wurde aktiviert: Doppelter Preis, Halbe Zeit",thePlayer,0,255,0)
            else
			    outputChatBox("Schnelltanken wurde aktiviert: Vierfacher Preis, viertel der Zeit",thePlayer,0,255,0)
            end
		else
			vioSetElementData(thePlayer,"speedtank",0)
			outputChatBox("Schnelltanken wurde deaktiviert: normaler Preis, normale Zeit",thePlayer,0,255,0)
		end
	end
end
addCommandHandler("speedtank",enSpeedTank_cmd,false,false)


function TankenMarkerHit(hitElement)
	if(getElementType(hitElement)=="vehicle")then
		if(vioGetElementData(hitElement,"tank") and getVehicleOccupant ( hitElement ))then
			local price=math.round((100-vioGetElementData(hitElement,"tank"))*serversettings["tankpreis"])
			if(getPlayerMoney(getVehicleOccupant ( hitElement ))<price)then
				outputChatBox(string.format("Du hast leider nicht genug Geld!(Preis pro Liter: %s$)", serversettings["tankpreis"]),getVehicleOccupant ( hitElement ),255,0,0)
			else
			
				local freezetime=math.round((100-vioGetElementData( hitElement ,"tank"))*600)
				if(vioGetElementData(getVehicleOccupant ( hitElement ),"premium")>0 and vioGetElementData(getVehicleOccupant ( hitElement ),"speedtank")==1) then
					freezetime=math.round(((100-vioGetElementData( hitElement ,"tank"))*600)/3)
				elseif(vioGetElementData(getVehicleOccupant ( hitElement ),"premium")>0 and vioGetElementData(getVehicleOccupant ( hitElement ),"speedtank")==2) then
                    freezetime=math.round(((100-vioGetElementData( hitElement ,"tank"))*600)/6)
                end
				
				outputChatBox("Bitte warte... Das Fahrzeug wird aufgetankt!",getVehicleOccupant ( hitElement )	,255,0,0)
				setElementFrozen ( hitElement, true )	
				vioSetElementData(hitElement,"isInTankProcedur",true)				
				vioSetElementData(hitElement,"motor",false)
				setVehicleEngineState ( hitElement, false )
				vioSetElementData(hitElement,"motornum",0)
				if not(privCars[hitElement])then
				--	price=math.round(price/3)					
				end
				if(vioGetElementData(getVehicleOccupant ( hitElement ),"premium")>0 and vioGetElementData(getVehicleOccupant ( hitElement ),"speedtank")==1) then
					price=price*2
				elseif(vioGetElementData(getVehicleOccupant ( hitElement ),"premium")>0 and vioGetElementData(getVehicleOccupant ( hitElement ),"speedtank")==2) then
                    price=price*4
                end
				if(vioGetElementData(source,"repairMarker"))then
					freezetime=freezetime+5000
				end
				if(freezetime<1000)then
					setTankFulTanke(price,hitElement,getVehicleOccupant ( hitElement ),source,(100-vioGetElementData( hitElement ,"tank")))
				else
					setTimer(setTankFulTanke,freezetime,1,price,hitElement,getVehicleOccupant ( hitElement ),source,(100-vioGetElementData( hitElement ,"tank")))
				end
			end
		end
	end
end


function setTankFulTanke(preis,hitElement,driver,marker,liter)
	if(isElement(hitElement))then
		vioSetElementData(hitElement,"isInTankProcedur",false)
		vioSetElementData(hitElement,"tank",100)
		if(vioGetElementData(marker,"repairMarker"))then
			preis=preis+1000
			outputChatBox("Das Fahrzeug wurde repariert!",driver,255,0,0)
			fixVehicle (hitElement)
		end
        changePlayerMoney(driver,-preis,"fahrzeug","Tanken")
        changeBizKasse(7, preis, "Tank")
		outputChatBox(string.format("Du hast erfolgreich  %s l für %s (%s $/Liter) getankt!", math.round(liter,2), toprice(preis), serversettings["tankpreis"]),driver,255,0,0)
		if(vioGetElementData(driver,"speedtank")==1 and vioGetElementData(driver,"premium")>0)then
			outputChatBox("Speedtank aktiviert!",driver,255,0,0)
		end
		setElementFrozen(hitElement,false)
	end	
	
	if(vioGetElementData(driver,"Erfolg_Benzin_leer")~=1)then
		vioSetElementData(driver,"Erfolg_Benzin_leer",1)
		triggerClientEvent(driver,"onClientCreatePokalGUI",driver,"Benzin leer","Gehe das erste Mal tanken")
	end
	
	
	
end








