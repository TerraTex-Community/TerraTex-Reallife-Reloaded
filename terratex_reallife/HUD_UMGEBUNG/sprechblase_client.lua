local dis=20
function showChatIcon()	
	local px,py,pz=getElementPosition(getLocalPlayer())
	for theKey,thePlayer in ipairs(getElementsByType("player"))do
		local posx,posy,posz=getElementPosition(thePlayer)
		if(getDistanceBetweenPoints3D(px,py,pz ,posx,posy,posz)<dis)then
			if(getElementData(thePlayer,"isChatBoxActivData")=="true" and isLineOfSightClear ( px,py,pz ,posx,posy,posz, true,false,false,true,false,true))then
				local sx,sy,sz=getScreenFromWorldPosition ( posx,posy,posz+0.5  )
				if(sx)then
					--dxDrawText (theTable[7], sx,sy, sx,sy, theTable[6], theTable[11], "default", "left", "top", false ,true,false,false, false)
					dxDrawImage ( sx,sy,25,25, "FILES/IMAGES/blase.png" )
				end
			end
			
		end

        --kopfgeld
		if(getDistanceBetweenPoints3D(px,py,pz ,posx,posy,posz)<200)then
			if(isLineOfSightClear ( px,py,pz ,posx,posy,posz, true,false,false,true,false,true))then
				if(getElementData(thePlayer,"kopfgeld"))then
					if(tonumber(getElementData(thePlayer,"kopfgeld"))>0)and(tonumber(getElementData(getLocalPlayer(),"fraktion")=="8") or tonumber(getElementData(getLocalPlayer(),"job"))==7)then
						local sx,sy,sz=getScreenFromWorldPosition ( posx,posy,posz+0.5  )
						if(sx)then
							dxDrawText (tostring(getElementData(thePlayer,"kopfgeld")).." $", sx,sy, sx,sy,tocolor(255,0,0,255), 1.5, "default", "center", "top", false ,true,false,false, false)
						end
					end
				end
			end
		end
		--admingodmode
        if(getDistanceBetweenPoints3D(px,py,pz ,posx,posy,posz)<dis)then
            if(getElementData(thePlayer,"smode"))then
                local sx,sy,sz=getScreenFromWorldPosition ( posx,posy,posz+0.3  )
                if(sx)then
                    --dxDrawText (theTable[7], sx,sy, sx,sy, theTable[6], theTable[11], "default", "left", "top", false ,true,false,false, false)
                    dxDrawImage ( sx-32,sy-32,64,64, "FILES/IMAGES/admingod.png" )
                end
            end

        end

	end	
end
addEventHandler("onClientRender",getRootElement(),showChatIcon)

addEvent("onChatBoxActivChange",true)
function onChatBoxActivChange_func(data)
	setElementData(getLocalPlayer(),"isChatBoxActivData",tostring(data))
end
addEventHandler("onChatBoxActivChange",getRootElement(),onChatBoxActivChange_func)


local wasChatBoxActiv=false
function onClientRenderChatBoxActiv()
	if not(isChatBoxInputActive()==wasChatBoxActiv)then
		wasChatBoxActiv=isChatBoxInputActive()
		triggerEvent("onChatBoxActivChange",getLocalPlayer(),wasChatBoxActiv)
	end
end
addEventHandler("onClientRender",getRootElement(),onClientRenderChatBoxActiv)









