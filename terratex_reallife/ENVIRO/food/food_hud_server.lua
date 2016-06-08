addEvent("FoodLevelIs",true)
function FoodLevelIs_func(menge)
	if(menge>100)then
		menge=menge-100
		local hp=getElementHealth(source)+menge
		if(hp>100)then hp=100 end
		setElementHealth(source,hp)
	elseif(menge<0)then
		killPed(source)
		outputChatBox("Du bist verhungert! Ernähre dich besser!",source,255,0,0)
	end
end
addEventHandler("FoodLevelIs",getRootElement(),FoodLevelIs_func)


addEvent("giveFoodPokal",true)
function giveFoodPokal_func()
	if(vioGetElementData(source,"Erfolg_Mein_erstes_Brot")~=1)then
		vioSetElementData(source,"Erfolg_Mein_erstes_Brot",1)
		triggerClientEvent(source,"onClientCreatePokalGUI",source,"Mein erstes Brot","Iss das erste Mal etwas")
	end


end
addEventHandler("giveFoodPokal",getRootElement(),giveFoodPokal_func)








