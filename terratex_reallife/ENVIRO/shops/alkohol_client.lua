local alkholTimer=false
local alkoholProzent=0
local isAlkholEffect=false


addEvent("checkalkdrug",true)
function checkalkdrug_func()
	triggerServerEvent("sendAlkDrugData",source,drogenGramm,alkoholProzent)


end
addEventHandler("checkalkdrug",getRootElement(),checkalkdrug_func)

addEvent("addAlkohol",true)
function addAlkohol_func(prozent)
	if isTimer(alkholTimer)then
		killTimer(alkholTimer)
	end
	alkoholProzent=alkoholProzent+prozent
	if(alkoholProzent>9.99)then
		outputChatBox("Du hast zuviel getrunken und bist ohnmächtig geworden",255,0,0)
		setElementHealth(getLocalPlayer(),0)
		alkholTimer=false
		alkoholProzent=0
	end
	if(alkoholProzent>0.9) and (alkoholProzent<10) then
		alkholTimer=setTimer(startAlkholEffect,((10-alkoholProzent)*3000+500),1)
	end
	
end
addEventHandler("addAlkohol",getRootElement(),addAlkohol_func)

local alkoholDureTimer=3
local alkoholDirection="left"
local alkDirec={"left","right"}

function AlkholTimer_function()
	
	if(alkoholDureTimer<3)then
		alkoholDureTimer=alkoholDureTimer+1
		if(alkoholDureTimer==3)then
			isAlkholEffect=false
			setControlState("vehicle_left",false)
			setControlState("vehicle_right",false)
		end
	end
	if(alkoholProzent>0)then
		alkoholProzent=alkoholProzent-0.0056
	end
	if(alkoholProzent<0)then
		alkoholProzent=0
	end
	setTimer(AlkholTimer_function,1000,1)
	
	
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),AlkholTimer_function)




function alkoholeffect()
	if(isAlkholEffect)or(alkoholDureTimer<3) then
		if(isPedInVehicle(getLocalPlayer()))then
			if(alkoholDureTimer==3)then
				local rand=math.random(1,2)
				alkoholDirection=alkDirec[rand]
				alkoholDureTimer=0
			end
			--outputChatBox("test "..alkoholDureTimer.." "..tostring(isAlkholEffect))
			if(alkoholDirection=="left")then
				setControlState("vehicle_left",true)
			else
				setControlState("vehicle_right",true)
			end			
				
				
		else
			triggerServerEvent("setAlkholAnimation_Event",getLocalPlayer())
			alkoholDureTimer=3
		end	
		isAlkholEffect=false
	end
end
addEventHandler("onClientRender",getRootElement(),alkoholeffect)






function startAlkholEffect()
	isAlkholEffect=false
	if isTimer(alkholTimer)then
		killTimer(alkholTimer)
		
	end
	if(alkoholProzent>=10)then
		outputChatBox("Du hast zuviel getrunken und bist ohnmächtig geworden",255,0,0)
		setElementHealth(getLocalPlayer(),0)
		killTimer(alkholTimer)
		alkholTimer=false
		alkoholProzent=0
		isAlkholEffect=false
	end
	
	alkholTimer=false
	if(alkoholProzent>0.9) and (alkoholProzent<10) then	
		isAlkholEffect=true
		alkholTimer=setTimer(startAlkholEffect,((10-alkoholProzent)*3000+500),1)
	end
end




function onAlkoholPedDied()
	if(source==getLocalPlayer())then
		if(isTimer(alkholTimer))then
			killTimer(alkholTimer)
			alkholTimer=false
		end
		alkholTimer=false
		alkoholProzent=0
		isAlkholEffect=false
		
	end
end
addEventHandler("onClientPlayerWasted",getRootElement(),onAlkoholPedDied)


--[[
function startAlkoholTimer()
	if(testCounter==10)and(alkholTest==true)then
		triggerServerEvent("setAlkholAnimation_Event",getLocalPlayer())
		testCounter=0
		outputChatBox("testmodeActivated")
	end	
	outputChatBox(tostring(testCounter))
	testCounter=testCounter+1
	setTimer(startAlkoholTimer,1000,1)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startAlkoholTimer)]]








