
local armyTorOA=createObject(987,141.39999389648,1964.6999511719,18.5,0,0,177.99450683594)
local armyTorOB=createObject(987,261.39999389648,1827.4000244141,16.60000038147,0,0,272)
local armyTorStatusOA=false
local armyTorStatusOB=false
  
  
  function armytordurchsichtig()
	local armyTor=createObject(969,341.39999389648,1795.5,17.299999237061,0,356,32)
	setElementAlpha(armyTor,0)
	
	
	
	local markerTOROAOUT=createMarker (134.833984375,1937.8203125,19.283094406128 ,"cylinder" )
	local markerTOROAIN=createMarker (135.189453125,1946.001953125,19.354345321655,"cylinder"  )
	local markerTOROBOUT=createMarker ( 290.2548828125,1821.2412109375,17.640625,"cylinder")
	local markerTOROBIN=createMarker (280.5712890625,1821.2919921875,17.640625,"cylinder" )
	
	addEventHandler( "onMarkerHit", markerTOROAOUT,  setPlayerOutArmyBaseTorOA)
	addEventHandler( "onMarkerHit", markerTOROAIN,  setPlayerInArmyBaseTorOA)
	addEventHandler( "onMarkerHit", markerTOROBOUT, setPlayerInArmyBaseTorOB )
	addEventHandler( "onMarkerHit", markerTOROBIN, setPlayerOutArmyBaseTorOB )
	
	
	
	
  
  
  end
  addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),armytordurchsichtig)
    function setPlayerOutArmyBaseTorOB(theElement)
		setElementPosition(theElement,299.9501953125,1822.9091796875,17.640625)  
  end
  
  function setPlayerInArmyBaseTorOB(theElement) 
		setElementPosition(theElement,267.83984375,1821.4609375,17.640625)  
  end
  function setPlayerOutArmyBaseTorOA(theElement)
		setElementPosition(theElement,134.8681640625,1958.4658203125,19.452768325806) 
  end
  
  function setPlayerInArmyBaseTorOA(theElement)  
		setElementPosition(theElement,135.7529296875,1928.3173828125,19.20415687561)  
  end
  
  
  
  
  function armyOpenTor(thePlayer)
	if(vioGetElementData(thePlayer,"fraktion")==7)then
	
		local px,py,pz=getElementPosition(thePlayer)
		if(getDistanceBetweenPoints3D(px,py,pz,141.39999389648,1964.6999511719,18.5)<20)then
			if(armyTorStatusOA)then
                armyTorStatusOA=false
				moveObject(armyTorOA,5000,141.39999389648,1964.6999511719,18.5)
			
			else
				armyTorStatusOA=true			
				moveObject(armyTorOA,5000,141.39999389648,1964.6999511719,12.5)
			end	
		
		
		end
		if(getDistanceBetweenPoints3D(px,py,pz,261.39999389648,1827.4000244141,16.60000038147)<20)then
			if(armyTorStatusOB)then			
				armyTorStatusOB=false
				moveObject(armyTorOB,5000,261.39999389648,1827.4000244141,16.60000038147)
			
			else
				armyTorStatusOB=true			
				moveObject(armyTorOB,5000,261.39999389648,1827.4000244141,10.60000038147)
			end	
	
	
	
	
	
		end
  
  
	end
  end
  addCommandHandler("mv",armyOpenTor,false,false)
  
  
  
  
  	local armyshape=false
  
  
  function onArmyBaseCreate()
	local shape= createColRectangle ( -61.787109375,1739.208984375, 471.8, 368)
	createRadarArea ( -61.787109375,1739.208984375, 471.8, 368, 255, 0, 0, 150,getRootElement()  )
	armyshape=shape
	addEventHandler ( "onColShapeHit", shape, enterArmyShape )
	
  
  end
  addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),onArmyBaseCreate)
  
  
  local armyRoketActivating=true
  local delayArmyRoket=true
  
  function defend_deactivate_func(thePlayer)
	if(vioGetElementData(thePlayer,"fraktion")==7) and (vioGetElementData(thePlayer,"fraktionsrang")>1)then
		local px,py,pz=getElementPosition(thePlayer)
		local dis=getDistanceBetweenPoints3D(px,py,pz,213.2734375,1822.810546875,6.4140625)
		if(dis<10)then
			armyRoketActivating=not(armyRoketActivating)
			outputChatBox("Defendsystem: "..tostring(armyRoketActivating),thePlayer)
		end  
	end
  end
  addCommandHandler("defend",defend_deactivate_func,false,false)
  
  
  
  
  
  function enterArmyShape(hitElement,dim)
	if(getElementType(hitElement)=="player")then
		if(vioGetElementData(hitElement,"fraktion")~=7 and getElementInterior(hitElement)==0)then
			outputChatBox("Sie haben eine Sperrzone betretten! Verlassen sie die Zone wieder oder sie erhalten 6 Wanteds!",hitElement,255,0,0)
			outputChatBox("Sie werden ohne weitere vorwarnung abgeschossen!",hitElement,255,0,0)
			for theKey,thePlayer in ipairs(getPlayersInTeam(team[7]))do
				
				outputChatBox("Jemand hat die Sperrzone betreten!",thePlayer,255,0,0)
			end
			
			
			
		end
	end
	if(getElementType(hitElement)=="vehicle") and armyRoketActivating and getElementInterior(hitElement)==0 then
		local iscopcar=false
		for key, theVehicle in pairs(policeVehicles) do
			if(theVehicle==hitElement)then
				iscopcar=true
			end
		
		end
		if not(iscopcar) then
			if(delayArmyRoket)then
				local px,py,pz=getElementPosition(hitElement)
				if(pz>32)then
					triggerClientEvent(getRootElement(),"defend_rocket_to",hitElement)
					delayArmyRoket=false
					setTimer(unDelayRocketStations,5000,1,hitElement)
				end
			else
				setTimer(reCheckAfterDelayRocket,5000,1,hitElement)
			
			end
		end
	end
  end
  
  function reCheckAfterDelayRocket(hitElement)
			if(delayArmyRoket)then
				local px,py,pz=getElementPosition(hitElement)
				if(pz>32 and table.getn(getVehicleOccupants ( hitElement ))>0)then
					triggerClientEvent(getRootElement(),"defend_rocket_to",hitElement)
					delayArmyRoket=false
					setTimer(unDelayRocketStations,5000,1,hitElement)
				end
			else
				setTimer(reCheckAfterDelayRocket,5000,1,hitElement)
			
			end
  
  
  end
  
  function unDelayRocketStations(hitElement)
  
  delayArmyRoket=true
	  --if(isElement(hitElement))then
		--if(isElementWithinColShape(hitElement,armyshape))then
			--local px,py,pz=getElementPosition(hitElement)
			--if(pz>32)then
				--triggerClientEvent(getRootElement(),"defend_rocket_to",hitElement)
				--delayArmyRoket=false
				--setTimer(unDelayRocketStations,5000,1,hitElement)
			--end
		--end
	  --end
  end
  
  
  













