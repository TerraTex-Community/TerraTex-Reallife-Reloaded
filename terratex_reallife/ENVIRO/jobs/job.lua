JobPickups={}

function createJobPickups()
	local pickele=createPickup(393.251953125,-2073.3642578125,7.8359375,3,1239,5000)
	JobPickups[1]={pickele,"Fischerjob",393.251953125,-2073.3642578125,7.8359375}
	pickele=createPickup(328.5732421875,1125.552734375,1083.8828125,3,1239,5000)
	setElementInterior(pickele,5)
	JobPickups[2]={pickele,"Drogendealer",328.5732421875,1125.552734375,1083.8828125}
	local pickele=createPickup(2200.1708984375,-1970.1962890625,13.78413105011,3,1239,5000)
	JobPickups[3]={pickele,"Muellmannjob",2200.1708984375,-1970.1962890625,13.78413105011}	
	local pickele=createPickup(1219.38671875,-1812.4951171875,16.59375,3,1239,5000)
	JobPickups[4]={pickele,"Busfahrer",1219.38671875,-1812.4951171875,16.59375}	
	local pickele=createPickup(1644.615234375,-1841.912109375,13.543103218079,3,1239,5000)
	JobPickups[5]={pickele,"Mechaniker",1644.615234375,-1841.912109375,13.543103218079}	
	local pickele=createPickup(1412.23046875,-1789.8720703125,15.282786369324,3,1239,5000)
	JobPickups[6]={pickele,"Detektiv",1412.23046875,-1789.8720703125,15.282786369324}	
	local pickele=createPickup(1574.3349609375,-1340.13671875,16.484375,3,1239,5000)
	JobPickups[7]={pickele,"Hitman",1574.3349609375,-1340.13671875,16.484375}	
	local pickele=createPickup(2125.380859375,-1823.4150390625,13.554768562317,3,1239,5000)
	JobPickups[8]={pickele,"Pizza",2125.380859375,-1823.4150390625,13.554768562317}	
	local pickele=createPickup(1549.666015625,-1670.4208984375,13.563942909241,3,1239,5000)
	JobPickups[9]={pickele,"Anwalt",1549.666015625,-1670.4208984375,13.563942909241}	
	local pickele=createPickup(1366.583984375,-1274.91796875,13.546875,3,1239,5000)
	JobPickups[10]={pickele,"Waffendealer",1366.583984375,-1274.91796875,13.546875}	
	local pickele=createPickup(2771.8046875,-2463.8359375,13.637566566467,3,1239,5000)
	JobPickups[11]={pickele,"Trucker",2771.8046875,-2463.8359375,13.637566566467}	
	local pickele=createPickup(1514.890625,1683.7958984375,10.8203125,3,1239,5000)
	JobPickups[12]={pickele,"Pilot",1514.890625,1683.7958984375,10.8203125}	
	local pickele=createPickup(1648.7177734375,701.60546875,10.8203125,3,1239,5000)
	JobPickups[13]={pickele,"Straßenputzer",1648.7177734375,701.60546875,10.8203125}	
	local pickele=createPickup(-1058.248046875,-1195.4794921875,129.17562866211,3,1239,5000)
	JobPickups[14]={pickele,"Farmer",-1058.248046875,-1195.4794921875,129.17562866211}	
	local pickele=createPickup(816.7919921875,856.6943359375,12.7890625,3,1239,5000)
	JobPickups[15]={pickele,"Bergwerksarbeiter",816.7919921875,856.6943359375,12.7890625}
	local pickele=createPickup(2415.14,-1220.74,24.7,3,1239,5000)
	JobPickups[16]={pickele,"Nutte",2415.14,-1220.74,24.7}	
	local pickele=createPickup(2500.166015625,-2259.4609375,3,3,1239,5000)
	JobPickups[17]={pickele,"Meeresreinigung",2500.166015625,-2259.4609375,3}	
	local pickele=createPickup(-49.994140625,-232.490234375,6.7646160125732,3,1239,5000)
	JobPickups[18]={pickele,"Hotdogverkäufer",-49.994140625,-232.490234375,6.7646160125732}	
	--JobBlips
	for theKey,theJob in ipairs(JobPickups) do
		setElementShowText(theJob[1],{255,255,255,255},theJob[2],true,15,1,0.5)
		if(getElementInterior(theJob[1])==0)and theKey~=7 then
			createBlip(theJob[3],theJob[4],theJob[5],58,2,255,0,0,255,0,50)
		end
	end
	createBlip(2166.3935546875,-1671.7578125,15.074158668518,58,2,255,0,0,255,0,50)--drogendealer
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createJobPickups)

function enterJobPickup(thePickupToUse)
	for theKey,thePickup in ipairs(JobPickups) do
		if(thePickupToUse==thePickup[1])then
			if(vioGetElementData(source,"job")==0)then
				showError(source,string.format("Willkommen beim %s um ihn anzunehmen verwende /getjob", thePickup[2]))
			end
			if(thePickup[2]=="Hitman")then
				outputChatBox("Setzte Kopfgeld aus mit /kopfgeld [Name] [Betrag]",source,0,255,0)
			end
		end
	end
end
addEventHandler("onPlayerPickupHit",getRootElement(),enterJobPickup)

function getjob_func(thePlayer)
	if(vioGetElementData(thePlayer,"job")==0)then
		local px,py,pz=getElementPosition(thePlayer)
		for theKey,thePickup in ipairs(JobPickups) do			
			if(getDistanceBetweenPoints3D(px,py,pz,thePickup[3],thePickup[4],thePickup[5])<3.0)then
				if not(theKey==7) and not(key==6) then
					showError(thePlayer,string.format("Du hast den %s erfolgreich angenommen! Weitere Informationen findest du unter /jobhelp! Solltest du den Job kuendigen wollen komm wieder an diese Position und mache /quitjob !", thePickup[2]))
					vioSetElementData(thePlayer,"job",theKey)
				else
					showError(thePlayer,"Diesen Job bekommt man nur durch einen Administrator! Contracts kannst du mit /kopfgeld aussetzen!")
				end
			end

		end	
	else
			showError(thePlayer,"Du musst dein Job vorher mit /quitjob kündigen!")	
	end
end
addCommandHandler("getjob",getjob_func,false,false)

function isPedAtJobIcon(thePlayer)
	local icon=false
	local px,py,pz=getElementPosition(thePlayer)
	for theKey,thePickup in ipairs(JobPickups)do
		local dis=getDistanceBetweenPoints3D(px,py,pz,thePickup[3],thePickup[4],thePickup[5])
		if(dis<5)then
			icon=true
		end
	end
	return icon
end

function quitjob_func(thePlayer)
	local jobid=vioGetElementData(thePlayer,"job")
	if(jobid~=0)then
		if not(isPedInVehicle(thePlayer))then
			if(isPedAtJobIcon(thePlayer))then
				showError(thePlayer,string.format("Du hast den %s erfolgreich gekuendigt!", JobPickups[jobid][2]))
				vioSetElementData(thePlayer,"job",0)
			else
				showError(thePlayer,"Dazu musst du dich dort befinden wo du den Job angenommen hast!")		
			end
		end
	end
end
addCommandHandler("quitjob",quitjob_func,false,false)

function jobhelp_func(thePlayer)
	local jobid=vioGetElementData(thePlayer,"job")
	if(jobid==1)then
		outputChatBox("Gehe an eine Angel und nutze /fish um zu fischen! Nach dem du maximal 20 Fische",thePlayer,255,0,0)
		outputChatBox("gefangen hast kannst du sie bei dem Fischer über das Klicksystem abgeben!",thePlayer,255,0,0)
	elseif(jobid==2)then
		outputChatBox("Gehe zu dem freundlichen Dealer in der CrackBude! Er wird dir drogen anbieten ",thePlayer,255,0,0)
		outputChatBox("die du mit /selldrugs [Spieler] [Menge] [Preis] verkaufen kannst",thePlayer,255,0,0)
	elseif(jobid==3)then
		outputChatBox("Nutze einen Müllwagen an der LS-Mülldeponie weitere Infos erhälst du im Fahrzeug!",thePlayer,255,0,0)
	elseif(jobid==4)then
		outputChatBox("Fahr einfach die Haltestellen ab und bring die Leute zu den Haltestellen! Starten einer Route mit /busstart [rookie/all/fraktion/job/sehenswert]",thePlayer,255,0,0)
	elseif(jobid==5)then
		outputChatBox("Nutze den Tow Truck und helfe liegen geblieben Fahrzeugen (Repairbefehl: /repair [Name] [Betrag])!",thePlayer,255,0,0)
	elseif(jobid==6)then
		outputChatBox("Nutze /find [Name] um Leute zu finden!",thePlayer,255,0,0)
	elseif(jobid==7)then
		outputChatBox("Töte Contracts auf /contracts!",thePlayer,255,0,0)
	elseif(jobid==8)then
		outputChatBox("Liefere die Pizzen aus! Nutze dazu den Pizzaroller!",thePlayer,255,0,0)
	elseif(jobid==9)then
		outputChatBox("Helfe den Leuten im Knast! Hol sie mit /free [Name] aus dem Knast!",thePlayer,255,0,0)
		outputChatBox("ACHTUNG! Du benötigst erst eine Genehmigung von einen Polizeiofficer eine bestimmte Person herrauszuholen!",thePlayer,255,0,0)
		outputChatBox("Um eine Genehmigung kannst du bitten mit /anwalt [CopName] [Name des Verbrechers]",thePlayer,255,0,0)
	elseif(jobid==10)then
		outputChatBox("Kaufen sie im Ammunation Materialien und verkaufe Waffen mit /sellweapon!",thePlayer,255,0,0)
	elseif(jobid==14)then
		outputChatBox("Annehmen einer Farmermission mit /startfarm!",thePlayer,255,0,0)
	elseif(jobid==17)then
		outputChatBox("Starten des Jobs mit /startboot!",thePlayer,255,0,0)
	elseif(jobid==18)then
		outputChatBox("Hol dir Hotdogs an der Fleischfabrik und verkauf sie an Spieler mit /sellhotdog [Menge] [Preis] [Spielername]",thePlayer,255,0,0)
	end
end
addCommandHandler("jobhelp",jobhelp_func,false,false)

function sethitman_func(thePlayer,theCommand,toPlayerName)
	if(isAdminLevel(thePlayer,4))then
		local toPlayer=getPlayerFromIncompleteName(toPlayerName)
		vioSetElementData(toPlayer,"job",7)	
	end
end
addCommandHandler("sethitman",sethitman_func)

addEvent("showJobMarklerBlip",true)
function showJobMarklerBlip_func(nr)
	if(nr~=2)then
		local blip=createBlip(JobPickups[nr][3],JobPickups[nr][4],JobPickups[nr][5],0,4,255,0,0,255,2,50,source)
		setTimer(destroyJobBlip,60000,1,blip)
	else
		local blip=createBlip(2166.3935546875,-1671.7578125,15.074158668518,0,4,255,0,0,255,2,50,source)
		setTimer(destroyJobBlip,60000,1,blip)
	end
end
addEventHandler("showJobMarklerBlip",getRootElement(),showJobMarklerBlip_func)

function destroyJobBlip(dest)
	if(isElement(dest))then
		destroyElement(dest)
	end
end









