



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
