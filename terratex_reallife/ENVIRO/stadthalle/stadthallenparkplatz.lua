createObject(10779,4412.79980469,-2082.39941406,1064.40002441,0.00000000,0.00000000,0.00000000)--; //object(aircarpark_06_sfse) (1)
createObject(10780,4493.41992188,-2098.87988281,1064.40002441,0.00000000,0.00000000,90.00000000)--; //object(aircarpark_07_sfse) (1)


function createStadthallenParkplatzmarker()
	local marker=createMarker(1500.9052734375,-1585.8505859375,13.046875,"cylinder",2)
	addEventHandler("onMarkerHit",marker,setPlayerInStadthallenParkplatz)
	marker=createMarker(4395.998046875,-2044.05078125,1061.3297119141,"cylinder",2)
	addEventHandler("onMarkerHit",marker,setPlayerAusStadthallenParkplatz)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createStadthallenParkplatzmarker)


function setPlayerInStadthallenParkplatz(player)
	if(getElementType(player)=="player")then
		if(isPedInVehicle(player))then
			if(getPedOccupiedVehicleSeat(player)==0)then
				if(getPlayerMoney(player)>49.99)then
                    changePlayerMoney(player,-50,"sonstiges","Parkhaus am LSPD")
					setElementFrozen(getPedOccupiedVehicle(player),true)
					setElementPosition(getPedOccupiedVehicle(player),4395.9990234375,-2058.658203125,1062.8297119141)
					local rx,ry,rz=getElementRotation(getPedOccupiedVehicle(player))
					setElementRotation(getPedOccupiedVehicle(player),rx,ry,(rz-180))
					setTimer(setElementFrozen,2000,1,getPedOccupiedVehicle(player),false)
				else
					outputChatBox("Du hast nicht genug Geld (50$)",player,255,0,0)
				end
			end
		else
			setElementPosition(player,4395.9990234375,-2058.658203125,1061.8297119141)
		end
	end
end--

function setPlayerAusStadthallenParkplatz(player)
	setElementPosition(player,1495.01171875,-1586.9228515625,13.271103858948)
	
	local rx,ry,rz=getElementRotation(player)
	setElementRotation(player,rx,ry,(rz-180))
end








