addEvent("foundHufeisen_func",true)
function foundHufeisen()
	vioSetElementData(source,"Hufeisen",vioGetElementData(source,"Hufeisen")+1)
	outputChatBox("Du hast ein Hufeisen gefunden! Es war 100$ wert!",source,100,255,100)
    changePlayerMoney(source,100,"sonstiges","Hufeisen")
	
	if(vioGetElementData(source,"Hufeisen")>9)then
		if(vioGetElementData(source,"Erfolg_10Hufeisen")==0)then
			vioSetElementData(source,"Erfolg_10Hufeisen",1)
			triggerClientEvent(source,"onClientCreatePokalGUI",source,"Hufeisenprinz","Finde 10 Hufeisen")
		
		end	
	end

	if(vioGetElementData(source,"Hufeisen")>99)then
		if(vioGetElementData(source,"Erfolg_100Hufeisen")==0)then
			vioSetElementData(source,"Erfolg_100Hufeisen",1)
			triggerClientEvent(source,"onClientCreatePokalGUI",source,"Hufeisenkönig","Finde 100 Hufeisen")
		
		end	
	end

	if(vioGetElementData(source,"Hufeisen")>999)then
		if(vioGetElementData(source,"Erfolg_1000Hufeisen")==0)then
			vioSetElementData(source,"Erfolg_1000Hufeisen",1)
			triggerClientEvent(source,"onClientCreatePokalGUI",source,"Hufeisenkaiser","Finde 1000 Hufeisen")
		
		end	
	end


end
addEventHandler("foundHufeisen_func",getRootElement(),foundHufeisen)








