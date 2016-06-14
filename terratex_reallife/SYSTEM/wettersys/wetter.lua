FlutInAction=false
lastWTimer=false
isWetterEventID=0 --1 => Atom | 2=>Flut | 3=>Flut und Atom | 4=>ÖlPest | 5=>Sauberer Regen | 6=>Verbesserung der Umweltqualität | 7=>Streik | 8=> Hitzewelle
sondermeldungstext={
[0]="Keine Nachichten vorhanden",
"Die Atomverseuchung ist noch nicht vorbei!",
"Die Flut dauert immernoch an!",
"Es dauert eine Flut und eine Atomkatastrophe an!",
"Die Ölplattform hat einen defekt, es kam zu einer Ölpest!",
"Durch sauberen Regen in der richtigen Menge, konnte eine Verbesserung der Umweltqualität festgestellt werden!",
"Die Umwelt erholt sich, die Wiesen scheinen grüner zu werden!",
"Die Arbeiter von wichtigen Unternehmen fangen an zu streiken, die Zeitarbeiter werden derzeit stark gefördert!",
"Die hohen Temperaturen stören die Arbeiter und die Umwelt!"}
oldrainlevel=0
rainlevel=0
newHeatSize=0

local timeankuendigung=10*60*1000
local timenewweather=40*60*1000

weatherchangeTimer=false
weatheraktualTimer=false

function setWetterOnResourceStart()
	setCloudsEnabled ( true)
	--regenleve
	rainlevel=MySql.helper.getValueSync("data_settings", "Wert", { Name = "regenlevel" });

	changeWeather()
	local pickup=createPickup(1473.146484375,-1771.8291015625,18.795755386353,3,1239,5000)
	addEventHandler("onPickupHit",pickup,sendOeffiWetterMessage,false)
	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),setWetterOnResourceStart)

function sendOeffiWetterMessage(player)
	outputChatBox("Der Zeitige wichtige Staats- und Öffentlichkeitsmitteilungen: ",player,255,255,0)
	outputChatBox(sondermeldungstext[isWetterEventID],player,255,255,0)
end



function snw_func(thePlayer,cmd,srain)
	if(isAdminLevel(thePlayer,3))then
		if(isTimer(lastWTimer))then
			killTimer(lastWTimer)
		end
		rainlevel=tonumber(srain)	
		changeWeather(rainlevel)
	end
end
addCommandHandler("snw",snw_func,false,false)

function changeWeather(setrainlevel)
	isWetterEventID=0
	resetWaterLevel()
	resetWaterColor ()
	
	--setWaterColor(255,255,255,255) -- WINTER
	
	
	lastWTimer=setTimer(changeWeather,timenewweather,1)
    weatheraktualTimer=lastWTimer
	rainchange=(math.random(0,100)-50)/100
	oldHeatSize=newHeatSize
	newrainlevel=0
    weatherchangeTimer=setTimer(setHeatHaze,timeankuendigung-5000,1,0)
	setTimer(resetRainLevel,timeankuendigung-5000,1)
	newWindy=0
	nebel=false
	newdarkhimmel=false
	newNebel=false
	newClouds=false
	newHeatSize=0
	if(rainchange+rainlevel>4 or rainchange+rainlevel<-4)then
		rainchange=-rainchange
	end
	local clouds=getCloudsEnabled()
	if(rainchange+rainlevel>0 and not(clouds))then
		newrainlevel=0
	else
		newrainlevel=rainchange+rainlevel
    end

    --rainlevel unreal mit weniger regen

    --newrainlevel=(math.random(0,700)-350)/100
    local newrainlevel=math.random(0,311)/100
    if(math.random(1,16)~=2)then
        newrainlevel=-newrainlevel
    end

    if(setrainlevel)then
       newrainlevel=setrainlevel
    end

    if(math.round(0,1)==1)then
        newClouds=false
    else
        newClouds=true
    end
    if(newrainlevel>0)then
        setTimer(setRainLevel,timeankuendigung,1,newrainlevel)
        newClouds=true
    end
	setCloudsEnabled(newClouds)
	if(newrainlevel>0.5)then
		newdarkhimmel=true	end
	local x=math.random(-100,100)/100
	local y=math.random(-100,100)/100
	local z=math.random(-100,0)/100
	setTimer(setWindVelocity,timeankuendigung,1,x,y,z)
	newWindy=math.sqrt(x*x+y*y+z*z)
	if(newrainlevel<-2.5)then
		x=math.random(0,20)
		y=math.random(1,30)
		z=math.random(1,30)
		a=math.random(1,75)
		b=math.random(1,75)
		newHeatSize=(x+y+z+a+b)/5
		setTimer(setHeatHaze,timeankuendigung,1,x,0,y,z,a,b,80,85,true)
	end
	if(math.random(0,1)==1 and newrainlevel<-2.5 ) or (newrainlevel>1 and math.random(0,1)==1)then
		setWeather(9)
		setTimer(setFogDistance,timeankuendigung,1,math.random(5,50))
		setTimer(setFarClipDistance,timeankuendigung,1,math.random(100,500))
		nebel=true
	else
		setWeather(0)
		nebel=false
		setFogDistance(50)
		if(rainlevel>0)then
			setTimer(setFarClipDistance,timeankuendigung,1,math.random(500,1000))
		else
			setTimer(setFarClipDistance,timeankuendigung,1,math.random(500,3000))
		end
	end
	local wellenhoehe=0
	if(newWindy)then
		local wellenmax=newWindy*2
		if(newWindy<0.5)then
			wellenhoehe=math.random(0,(wellenmax*100))/100
		else
			wellenhoehe=math.random((wellenmax*50),(wellenmax*100))/100
		end		
	end
	setTimer(setWaveHeight,timeankuendigung,1,wellenhoehe)
	if(newdarkhimmel)then
		setSunSize ( 0)
		local blau=math.random(20,80)
		local gruen=10000
		while(gruen>blau) do
			gruen=math.random(5,70)
		end
		local rot=10000
		while(rot>gruen) do
			rot=math.random(0,60)
		end
		setTimer(setSunColor,timeankuendigung,1,rot,gruen,blau,rot,gruen,blau)
		setTimer(setSkyGradient,timeankuendigung,1,rot,gruen,blau,rot,gruen,blau)
		
		--setSkyGradient(50, 50, 50, 50, 50, 50) --Winter
		
	else
		resetSunSize()
		resetSunColor()
		local blau=math.random(80,220)
		local gruen=10000
		while(gruen>blau) do
			gruen=math.random(70,170)
		end
		local rot=10000
		while(rot>gruen)do
			rot=math.random(60,140)
		end			
		setSunSize ( 10)
		local timer=getRealTime()
		if (timer.hour==5 or timer.hour==6 or timer.hour==19 or timer.hour==20 or((newrainlevel<-2.5 and nebel)))then
			blau=math.random(60,100)
			gruen=math.random(80,140)
			rot=math.random(100,255)
			setSunSize ( 10)
		end
		setTimer(setSunColor,timeankuendigung,1,255,240,150,255,240,150)
		setTimer(setSkyGradient,timeankuendigung,1,rot,gruen,blau,rot,gruen,blau)
		
		--setSkyGradient(175, 175, 175, 175, 175, 175)---WINTER
	end
	
	local timer=getRealTime()
	if(timer.hour>20 or timer.hour<5)then
		blau=math.random(0,20)
		setTimer(setSkyGradient,timeankuendigung,1,0,0,blau,0,0,blau)
	end
	
	if(newrainlevel>0)then
		setTimer(setRainLevel,timeankuendigung,1,newrainlevel)
    end
    oldrainlevel=rainlevel
	rainlevel=newrainlevel
	
	--outputChatBox(tostring(rainlevel))
	--AUSGABE AN DIE NEWSREPORTER

	
	local isflutnow=false
	if(rainlevel<-3 and oldHeatSize>30)or(rainlevel>3)then
		if(math.random(1,4)==4)then
			if not(isWetterEventID==1) then
				isWetterEventID=2
			else
				isWetterEventID=3
			end
			setTimer(start_flut,timeankuendigung,1)
			isflutnow=true
		end
	end
	
	if not(isflutnow) then
		local regenstaerke=""
		wind="windstill bis wenig Wind"
		local besonderheiten=""
		local sendTextRegen=""
			if(newrainlevel>0)then
				regenstaerke="tröpfeln"
				if(newrainlevel>0.1)then
					regenstaerke="leicht"
				end
				if(newrainlevel>0.7)then
					regenstaerke="mittel"
				end
				if(newrainlevel>2)then
					regenstaerke="stark"
				end
				sendTextRegen=string.format("Regen: %s", regenstaerke)
				--outputChatBox("Regen: "..regenstaerke,theNewsReporter,0,255,0)
			else
				regenstaerke="Kein Regen"
				sendTextRegen="Regen: schönes Wetter"
				--outputChatBox("Regen: schönes Wetter",theNewsReporter,0,255,0)
			end
			
			if(newWindy>0.5 and newWindy<1)then
				wind="windig"
			end
			if(newWindy>1)then
				wind="stark"
			end
			if(newHeatSize>0)then
				heattext="leicht"
				if(newHeatSize>20)then
					heattext="mittel"
				end
				if(newHeatSize>35)then
					heattext="stark"
				end				
			end
			
			if(newrainlevel<-2.5 and nebel)then
				besonderheiten="Sandsturm,"
			end
			if(newrainlevel>0 and nebel)then
				besonderheiten=string.format("%s Nebel,", besonderheiten)
			end
			if(newdarkhimmel)then
				besonderheiten=string.format("%s Bewölkt,", besonderheiten)
			end
			if not(newClouds) then
				besonderheiten=string.format("%s wolkenlos", besonderheiten)
			end
			if(isWetterEventID==0)then
				if(math.random(1,4)==2)then
						if(newrainlevel>1 and newrainlevel<2.1)then
							if(math.random(1,4)==2)then
								isWetterEventID=5
							end
						elseif(newrainlevel<-1 and newrainlevel>-2.1)then
							if(math.random(1,4)==2)then
								isWetterEventID=6
							end
						elseif(newrainlevel<-2)then
							if(math.random(1,4)==2)then
								isWetterEventID=8
							end
						elseif(math.random(1,15)==5)then
								isWetterEventID=4
								setWaterColor(0,0,0,255)
						elseif(math.random(1,15)==5)then
								isWetterEventID=7
						end
							
				end
			end
		if(isElement(team[3]))then
			for theKey,theNewsReporter in ipairs(getPlayersInTeam(team[3])) do
				outputChatBox("Die Wetterstation meldet einen Wetterwechsel in 3 Minuten:",theNewsReporter,0,255,0)
				outputChatBox(sendTextRegen,theNewsReporter,0,255,0)		
				outputChatBox(string.format("Wind: %s", wind),theNewsReporter,0,255,0)
				if(newHeatSize>0)then
					outputChatBox(string.format("Hitzewelle: %s", heattext),theNewsReporter,0,255,0)
				end
				outputChatBox(string.format("Besonderheiten: %s", besonderheiten),theNewsReporter,0,255,0)
				outputChatBox(string.format("Wellenhoehe: %s", wellenhoehe),theNewsReporter,0,255,0)			
				if(isWetterEventID~=0)then
					outputChatBox(string.format("zusätzliche Sondermeldung: %s", sondermeldungstext[isWetterEventID]),theNewsReporter,0,255,0)
				end			
			end
		end
		local times=getRealTime()
		local logtext="["..times.monthday.."."..(times.month+1).."."..(times.year+1900).." - "..times.hour..":"..times.minute..":"..times.second.."] "..newrainlevel..": "..regenstaerke.." "..besonderheiten
		save_log("wetter",logtext)
	
	end
	outputDebugString("Wetter changed")
end

function start_flut()
	rainlevel=0
	newHeatSize=0
	if (isTimer(lastWTimer)) then
		killTimer(lastWTimer)
	end
	local waves=math.random(200,500)/100
	local randHigh=math.random(600,2000)/100
	flutwater=createWater(-2998,-2998,0, 2998,-2998,0, -2998,2998,0,2998,2998,0)
	setWeather(9)			
	setWaterLevel(flutwater, 0)
	setWaveHeight(waves)
	outputChatBox("EILMELDUNG: EINE FLUT IST IN SAN ANDREAS AUSGEBROCHEN!",getRootElement(),255,0,0)
	wait=1
	flutstatus=1
	FlutInAction=true
	setTimer(startFlut,5000,1,flutwater,randHigh+0,0)

end


function startFlut(flutwater,maxhighed,lastwaterlevel)
	if(flutstatus==1)then
        if not(isWetterEventID==1 and not isWetterEventID==3) then
            isWetterEventID=2
        else
            isWetterEventID=3
        end
		setRainLevel ( math.random(1,6) )
		setWindVelocity ( math.random(0,5),math.random(0,5),math.random(0,5) )
		setWaterLevel((lastwaterlevel+0.055))          
		setWaterLevel(flutwater,(lastwaterlevel+0.055))
		lastwaterlevel=lastwaterlevel+0.055
		setTimer(startFlut,1000,1,flutwater,maxhighed,lastwaterlevel)
		if(lastwaterlevel>maxhighed)then
			flutstatus=2
		end
	else
			if(lastwaterlevel<0)then
				destroyElement(flutwater)
				resetRainLevel()
				resetWindVelocity()
				setTimer(changeWeather,5000,1)
				setWaterLevel(0)
				FlutInAction=false
				if not(isWetterEventID==3) then
					isWetterEventID=0
				else
					isWetterEventID=1
				end
			else		
				if(flutstatus==2)then
					local randtime=math.random(5,15)*60*1000
					flutstatus=3
					setTimer(startFlut,randtime,1,flutwater,maxhighed,lastwaterlevel)					
				else
					setWaterLevel((lastwaterlevel)-0.055)
					setWaterLevel(flutwater,lastwaterlevel-0.055)
					lastwaterlevel=lastwaterlevel-0.055
					setTimer(startFlut,1000,1,flutwater,maxhighed,lastwaterlevel)	
				end
			end
	end


end


function sendWetterEventToClient()
	triggerClientEvent(getRootElement(),"sendWetterEventToClient_Event",getRootElement(),isWetterEventID)
	setTimer(sendWetterEventToClient,60000,1)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),sendWetterEventToClient)








