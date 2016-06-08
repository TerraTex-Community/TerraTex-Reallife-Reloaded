policeSkin={[150]=true,[265]=true,[266]=true,[268]=true,[280]=true,[281]=true,[282]=true,[283]=true,[284]=true,[288]=true}
groveSkin={[105]=true,[106]=true,[107]=true,[269]=true,[270]=true,[271]=true}
	skinMarkers={}

function createSkinMarkers()

	local marker=createMarker(460.65234375,-1500.869140625,30.558277130127,"corona",1)
	table.insert(skinMarkers,{marker,456.22265625,-1500.8525390625,31.046058654785})
	marker=createMarker(2245.095703125,-1664.7392578125,14.9765625,"corona",1)
	table.insert(skinMarkers,{marker,2243.0283203125,-1661.962890625,15.4765625})
	
	marker=createMarker(2102.32421875,2257.0927734375,11.0234375,"corona",1)
	table.insert(skinMarkers,{marker,2105.9892578125,2257.35546875,11.0234375})
	marker=createMarker(2779.8193359375,2453.58203125,11.0625,"corona",1)
	table.insert(skinMarkers,{marker,2778.298828125,2450.9716796875,11.0625})
	marker=createMarker(-1694.751953125,951.8681640625,24.890625,"corona",1)
	table.insert(skinMarkers,{marker,-1697.5615234375,948.3056640625,24.890625})
	marker=createMarker(-2374.4619140625,909.8408203125,45.4453125,"corona",1)
	table.insert(skinMarkers,{marker,-2378.3623046875,910.052734375,45.445312})
	
	for theKey,theTable in ipairs(skinMarkers)do
		local x,y,z=getElementPosition(theTable[1])
		--outputDebugString(tostring(x))
		createBlip(x,y,z,45,0.5,255,0,0,255,0,255,getRootElement())
	end
	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createSkinMarkers)

function setMySkin_func(skin)
	setElementModel(source,skin)
end
addEvent("setMySkin",true)
addEventHandler("setMySkin",getRootElement(),setMySkin_func)

--[[
function fskin_func(hitElement)
	if(vioGetElementData(hitElement,"fraktion")>0)then
			local randdim=math.random(1,50)
			setElementDimension(hitElement,randdim)
			vioSetElementData(hitElement,"SkinFuncMarker",-1)	
			triggerClientEvent(hitElement,"showSkinGui",hitElement)

			toggleAllControls(hitElement,false)	
	end
end
addCommandHandler("fskin",fskin_func)]]



function skin_func(hitElement)
	if(isElement(hitElement))then
		if(getElementType(hitElement)=="player")then
			if(not vioGetElementData(hitElement,"isCopSwat"))then
				if not(isPedInVehicle(hitElement)) then
					for theKey,theMarker in pairs(skinMarkers) do
						if(theMarker[1]==source)then
							setElementInterior(hitElement,5)
							setElementPosition(hitElement,209.673828125,-5.7900390625,1001.4109375)
							local randdim=math.random(1,50)
							setElementDimension(hitElement,randdim)
							vioSetElementData(hitElement,"SkinFuncMarker",theKey)
							if(isBeamter(hitElement) or vioGetElementData(hitElement,"fraktion")==4 or vioGetElementData(hitElement,"fraktion")==10)then
								if(vioGetElementData(hitElement,"taxi_duty") or vioGetElementData(hitElement,"isCopDuty") or vioGetElementData(hitElement,"isMedicDuty"))then
									triggerClientEvent(hitElement,"showSkinGui",hitElement,false)	
								else
									triggerClientEvent(hitElement,"showSkinGui",hitElement,true)	
								end						
							else
								triggerClientEvent(hitElement,"showSkinGui",hitElement,false)	
							end
						end		
					end
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",getRootElement(),skin_func)

function buy_skin_func(skinid)
	if(getPlayerMoney(source)>4.99)then
		setElementModel(source,skinid)

		if(vioGetElementData(source,"fraktion")>0)then
			if(isBeamter(source) or vioGetElementData(source,"fraktion")==4 or vioGetElementData(source,"fraktion")==10)then
				if(vioGetElementData(source,"taxi_duty") or vioGetElementData(source,"isCopDuty") or vioGetElementData(source,"isMedicDuty"))then
					vioSetElementData(source,"FrakSkin",skinid)
					setElementModel(source,vioGetElementData(source,"FrakSkin"))	
				else
					vioSetElementData(source,"skinid",skinid)
					setElementModel(source,vioGetElementData(source,"skinid"))
                    changePlayerMoney(source,-5,"sonstiges","Skinkauf")
				end						
			else
				vioSetElementData(source,"FrakSkin",skinid)
				setElementModel(source,vioGetElementData(source,"FrakSkin"))			
			end
			
		else		
			vioSetElementData(source,"skinid",skinid)
			setElementModel(source,vioGetElementData(source,"skinid"))
            changePlayerMoney(source,-5,"sonstiges","Skinkauf")
		end
        changeBizKasse(15,0.10, "Einkauf")
	else
		outputChatBox("Du hast nicht genug Geld (500$)",source,255,0,0)			
	end
		
		if(vioGetElementData(source,"SkinFuncMarker")==-1)then
			setElementDimension(source,0)
			vioSetElementData(source,"SkinFuncMarker",nil)	
		else
			local marker=vioGetElementData(source,"SkinFuncMarker")
			setElementInterior(source,0)
			setElementPosition(source,skinMarkers[marker][2],skinMarkers[marker][3],skinMarkers[marker][4])
			setElementDimension(source,0)	
			vioSetElementData(source,"SkinFuncMarker",nil)	
		end	
end
addEvent("buy_skin",true)
addEventHandler("buy_skin",getRootElement(),buy_skin_func)




function break_skin_func()
		if(vioGetElementData(source,"fraktion")>0)then
			setElementModel(source,vioGetElementData(source,"FrakSkin"))
		else
		
			setElementModel(source,vioGetElementData(source,"skinid"))
			
		end
	if(vioGetElementData(source,"SkinFuncMarker")==-1)then
		setElementDimension(source,0)
		vioSetElementData(source,"SkinFuncMarker",nil)	
	else
			local marker=vioGetElementData(source,"SkinFuncMarker")
			setElementInterior(source,0)
			setElementPosition(source,skinMarkers[marker][2],skinMarkers[marker][3],skinMarkers[marker][4])
			setElementDimension(source,0)	
			vioSetElementData(source,"SkinFuncMarker",nil)	
	end
end
addEvent("break_skin",true)
addEventHandler("break_skin",getRootElement(),break_skin_func)








