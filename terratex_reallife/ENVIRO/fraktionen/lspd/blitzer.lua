blitzer={false,false,false,false,false,false,false,false,false,false}
local blitzermark={false,false,false,false,false,false,false,false,false,false}
local hasblitzer={false,false,false,false,false,false,false,false,false,false}

addEvent("sendMeBlitzerPos",true)
addEventHandler("sendMeBlitzerPos",getRootElement(), function ()
    triggerClientEvent(source,"sendBlitzerPos",source,blitzer)
end)

function createBlitzer_func(thePlayer,cmd,blitzerid)
	if(isBeamter(thePlayer)and not(isPedInVehicle(thePlayer)))then
		if(blitzerid)then
			local blitzerids=tonumber(blitzerid)
			if(blitzerids)then
				if not(blitzerids>10 or blitzerids<1) then
					if(blitzer[blitzerids])then					
						outputChatBox("Der Blitzer ist zur Zeit in Benutzung! Weitere Infos unter /sblitzer",thePlayer,255,0,0)
					else
						local px,py,pz=getElementPosition(thePlayer)
						local isZuNah=false
						for theKey,blitzeri in ipairs(blitzer)do
							if(blitzeri)then
								local bx,by,bz=getElementPosition(blitzeri)
								if(getDistanceBetweenPoints3D(px,py,pz,bx,by,bz)<50)then
									isZuNah=true
								end
							end
						end
						if(isZuNah)then
							outputChatBox("Ein anderer Blitzer is bereits in der Nähe aufgebaut! Infos unter /sblitzer",thePlayer,255,0,0)
						else
							local obj=createObject(1250,px,py,pz-0.5)
							setElementPosition(thePlayer,px,py,pz+0.5)
							blitzer[blitzerids]=obj
							local marker=createMarker ( px,py,pz-0.5, "cylinder", 30, 0,0,0,0 , getRootElement())
							blitzermark[blitzerids]=marker
							addEventHandler("onMarkerHit",marker,checkClearLineBetweenBlitzerAndPlayer)
							outputChatBoxForPolice(string.format("Der Blitzer %s wurde von %s aufgebaut!", blitzerids, getPlayerName(thePlayer)))
							outputChatBox("Der Blitzer wurde erfolgreich aufgebaut! Abbauen mit /dblitzer [ID]",thePlayer,255,0,0)
						end
					end	
				else
					outputChatBox("Nutzung: /cblitzer [1-5]",thePlayer,255,0,0)				
				end
			else
				outputChatBox("Nutzung: /cblitzer [1-5]",thePlayer,255,0,0)

			end
		end
	end	
end
addCommandHandler("cblitzer",createBlitzer_func,false,false)

function dblitzer_func(thePlayer,cmd,blitzerid)
	if(isBeamter(thePlayer))then
		if(blitzerid)then
			local blitzerids=tonumber(blitzerid)
			if(blitzerids)then
				if(blitzer[blitzerids])then		
					destroyElement(blitzer[blitzerids])
					blitzer[blitzerids]=false
					destroyElement(blitzermark[blitzerids])
					blitzermark[blitzerids]=false
					outputChatBox("Der Blitzer wurde erfolgreich abgebaut!",thePlayer,255,0,0)
					outputChatBoxForPolice(string.format("Der Blitzer %s wurde von %s abgebaut!", blitzerids, getPlayerName(thePlayer)))
				else
					outputChatBox("Der Blitzer ist zur Zeit nicht in Benutzung! Weitere Infos unter /sblitzer",thePlayer,255,0,0)
				end
			elseif(blitzerid=="all")then
				for n=1,10,1 do
					if(isElement(blitzer[n]))then
						destroyElement(blitzer[n])
					end
					blitzer[n]=false
					if(isElement(blitzermark[n]))then
						destroyElement(blitzermark[n])
					end
					blitzermark[n]=false
				end
				outputChatBox("Alle Blitzer wurden erolgreich abgebaut!",thePlayer,255,0,0)
				outputChatBoxForPolice(string.format("Alle Blitzer wurden von %s abgebaut!", getPlayerName(thePlayer)))
			end
		end
	end	
end
addCommandHandler("dblitzer",dblitzer_func,false,false)

function sblitzer_func(thePlayer)
	if(isBeamter(thePlayer))then
		outputChatBox("Blitzer der Beamten:",thePlayer,255,0,0)
		local px,py,pz=getElementPosition(thePlayer)
		for theKey,theBlitzer in ipairs(blitzer)do
			if(theBlitzer)then
				local bx,by,bz=getElementPosition(theBlitzer)
				local dis=getDistanceBetweenPoints3D(px,py,pz,bx,by,bz)
				outputChatBox(string.format("Nr. %s: Ort: %s Entfernung: %s", theKey,getZoneName ( bx,by,bz), math.round(dis)),thePlayer,255,0,0)
			else
				outputChatBox(string.format("Nr. %s: nicht in Benutzung!", theKey),thePlayer,255,0,0)
			end		
		end
	end
end
addCommandHandler("sblitzer",sblitzer_func,false,false)

function checkClearLineBetweenBlitzerAndPlayer(HitElement)
if(getElementType(HitElement)=="player")then
	--outputChatBox("lala")
	local blitzerids=1
	for theKey,theBlitzer in ipairs(blitzer)do
							if(blitzermark[theKey]==source)then
								blitzerids=theKey
							end
						end
		if not(hasblitzer[blitzerids])	then
			hasblitzer[blitzerids]=true
	--outputChatBox(tostring(blitzerids))
			triggerClientEvent(HitElement,"CheckClearLine_Blitzer",HitElement,source,blitzer[blitzerids])
			setTimer(resetBlitzerChecker,1000,1,blitzerids)
		end
	end
end

function resetBlitzerChecker(id)
hasblitzer[id]=false
end

addEvent("blitzme_event",true)
function playerInBlitzer(HitElement)
		--		outputChatBox("2")
	if(getElementType(HitElement)=="vehicle")then


		--		outputChatBox("2")
		local tx,ty,tz=getElementVelocity ( HitElement )
		local speed=180*math.sqrt(tx*tx+ty*ty+tz*tz)
		local anzeigespeed=speed
		speed=math.round(speed-(speed/10),2)
		if(speed>83)then
			local driver=getVehicleOccupant (HitElement)
            local id=0
            for theKey,theBlitzer in ipairs(blitzer)do
                if(blitzermark[theKey]==source)then
                    id=theKey
                end
            end


			triggerClientEvent(driver,"setBlitzerEnabled",driver)
			local isInBeamtenCar=false
			for theKey,theBeamte in ipairs(policeVehicles)do
				if(theBeamte==HitElement)then
					isInBeamtenCar=true
				end
			end

            if(vioGetElementData(driver,"inRacing"))then
                outputChatBoxForPolice(string.format("Ein Fahrer eines Fahrzeuges ist zu schnell durch Blitzer %s gefahren. Es handelt sich um ein illegales Straßenrennen.", tostring(id)))
                return false
            end
			local rechspeed=speed-80
			local stvo=math.round(rechspeed/20)
			local geldstrafe=math.round(math.round(rechspeed/20,2)*55)+450
			if(((vioGetElementData(HitElement,"frakid")==0)or(not(vioGetElementData(HitElement,"frakid"))))and not(vioGetElementData(HitElement,"atomveh"))and not(vioGetElementData(HitElement,"muntruck")))then
				if(speed>100)then
					vioSetElementData(driver,"stvo",vioGetElementData(driver,"stvo")+stvo)
					outputChatBox(string.format("Du wurdest mit %s km/h geblitzt! Du erhälst dafür %s StVO-Punkte vom Blitzersystem", anzeigespeed, stvo),driver,0,0,255)
					outputChatBox(string.format("Du hast jetzt %s StVO-Punkte", vioGetElementData(driver,"stvo")),driver,0,0,255)
					if(vioGetElementData(driver,"stvo")>=20)then
						vioSetElementData(driver,"autoLic",-5)
						vioSetElementData(driver,"bikeLic",-5)
						vioSetElementData(driver,"truckLic",-5)
						outputChatBox("Du hast somit gerade deinen Fuehrerschein verloren",driver,0,0,255)
						vioSetElementData(driver,"stvo",0)		
					end

					outputChatBox(string.format("Zusätzlich musst du %s Strafe zahlen!", toprice(geldstrafe)),driver,0,0,255)
                    changePlayerMoney(driver,-geldstrafe,"sonstiges","Blitzer")
					outputChatBoxForPolice(string.format("%s hat %s StVO-Punkte erhalten! Grund: Mobiler Blitzer NR %s", getPlayerName(driver), stvo, id))
							if(vioGetElementData(driver,"stvo")>0)then
								outputChatBoxForPolice(string.format("Er hat %s StVO-Punkte!", vioGetElementData(driver,"stvo")))
							
							else
								outputChatBoxForPolice("Er hat somit gerade seinen Fuehrerschein verloren")
							end
						
					vioSetElementData(driver,"stvoFreePayDays",0)	
				
			
				else
					outputChatBox(string.format("Du wurdest mit %s km/h geblitzt!", speed),driver,0,0,255)
					outputChatBox("Du musst daher 100$ Verwarngeld bezahlen",driver,0,0,255)
                    changePlayerMoney(driver,-100,"sonstiges","Blitzer")
				end
			end
			outputChatBox("Die maximal zulässige Höchstgeschwindigkeit in der Stadt beträgt 80 km/h",driver,255,0,0)
		end
	end
end
addEventHandler("blitzme_event",getRootElement(),playerInBlitzer)








