frakselfcars[4]={}
taxiPrices={}
--taxiPrices[timezone][tarifzone]
--zeiten= 6:00-12:00 12:00-18:00 18:00-6:00
taxiPrices[1]={0,0,0}
taxiPrices[2]={0,0,0}
taxiPrices[3]={0,0,0}
taxiObject=false
taxiObjectOpen=false
taxiGrundPrice=0
function mv_taxi_func(thePlayer)
	local x,y,z=getElementPosition(thePlayer)
	local dis=getDistanceBetweenPoints3D(x,y,z,1812.78833008,-2067.48437500,14.27042961)
	if(dis<20)then
		if(vioGetElementData(thePlayer,"fraktion")==4)then
			if(taxiObjectOpen)then
				moveObject(taxiObject,2500,1812.78833008,-2067.48437500,14.27042961)
				taxiObjectOpen=false
			else
				moveObject(taxiObject,2500,1812.8666,-2057.4194,14.2704)
				taxiObjectOpen=true
			end
		end
	end
end
addCommandHandler("mv",mv_taxi_func,false,false)

function onCreatetaxicars_func()
	taxiObject=createObject(7657,1812.78833008,-2067.48437500,14.27042961,0.00000000,0.00000000,90.00000000) 



	frakselfcars[4][1]  = createVehicle(438,1734.79345703,-2056.68554688,13.50827503,0,0,269.00000000,"SA-TAXI")
	frakselfcars[4][2]  = createVehicle(438,1734.77001953,-2061.51147461,13.50827503,0,0,268.99475098,"SA-TAXI")
	frakselfcars[4][3]  = createVehicle(438,1734.76867676,-2066.27319336,13.50827503,0,0,268.99475098,"SA-TAXI")
	frakselfcars[4][4]  = createVehicle(420,1807.98669434,-2035.22729492,13.38613224,0,0,180.00000000,"SA-TAXI")
	frakselfcars[4][5]  = createVehicle(420,1800.49230957,-2034.95031738,13.38613224,0,0,180.00000000,"SA-TAXI")
	frakselfcars[4][6]  = createVehicle(420,1792.58642578,-2034.79431152,13.38613224,0,0,180.00000000,"SA-TAXI")
	frakselfcars[4][7]  = createVehicle(420,1784.74621582,-2034.45043945,13.18613529,0,0,180.00000000,"SA-TAXI")
	frakselfcars[4][8]  = createVehicle(420,1767.39538574,-2051.28198242,13.53612995,0,0,269.95190430,"SA-TAXI")
	frakselfcars[4][9]  = createVehicle(420,1767.33703613,-2047.39233398,13.53612995,0,0,269.95056152,"SA-TAXI")
	frakselfcars[4][10] = createVehicle(487,1748.5380859375,-2045.2353515625,20.824502944946,0.263671875,359.736328125,146.78283691406,"SA-TAXI")    --  taxiheli 
	frakselfcars[4][11]  = createVehicle(580,1768.2158203125,-2029.9619140625,13.483623504639,353.40270996094,359.86267089844,270.36804199219,"SA-TAXI")
	frakselfcars[4][12]  = createVehicle(580,1768.4052734375,-2033.77734375,13.47914981842,353.95202636719,359.89013671875,270.76354980469,"SA-TAXI")
	frakselfcars[4][13]  = createVehicle(580,1768.244140625,-2038.46875,13.316600799561,0.010986328125,359.76928710938,269.68688964844,"SA-TAXI")
	frakselfcars[4][14] = createVehicle(409,1762.4755859375,-2056.18359375,13.384185791016,0.010986328125,359.79125976563,270.77453613281,"SA-TAXI") 


	for theKey,theVehicle in ipairs(frakselfcars[4]) do
		setVehicleColor ( theVehicle, 6,6,6,6 )
		prepare(theVehicle,4)
		addEventHandler("onVehicleEnter",theVehicle,donotentertaxi)
		vioSetElementData(theVehicle,"tank",100)
			table.insert(frakcars,theVehicle)
	end
	loadTaxiPricesFromDB()
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),onCreatetaxicars_func)

function loadTaxiPricesFromDB()
	local tarifa = MySql.helper.getValueSync("data_taxi_prices", "preis", {timezone = 1, tarifzone = 1});
	local tarifb = MySql.helper.getValueSync("data_taxi_prices", "preis", {timezone = 1, tarifzone = 2});
	local tarifc = MySql.helper.getValueSync("data_taxi_prices", "preis", {timezone = 1, tarifzone = 3});
	taxiPrices[1]={tarifa,tarifb,tarifc}
	
	tarifa = MySql.helper.getValueSync("data_taxi_prices", "preis", {timezone = 2, tarifzone = 1});
	tarifb = MySql.helper.getValueSync("data_taxi_prices", "preis", {timezone = 2, tarifzone = 2});
	tarifc = MySql.helper.getValueSync("data_taxi_prices", "preis", {timezone = 2, tarifzone = 3});
	taxiPrices[2]={tarifa,tarifb,tarifc}
	
	tarifa = MySql.helper.getValueSync("data_taxi_prices", "preis", {timezone = 3, tarifzone = 1});
	tarifb = MySql.helper.getValueSync("data_taxi_prices", "preis", {timezone = 3, tarifzone = 2});
	tarifc = MySql.helper.getValueSync("data_taxi_prices", "preis", {timezone = 3, tarifzone = 3});
	taxiPrices[3]={tarifa,tarifb,tarifc}
	taxiGrundPrice = MySql.helper.getValueSync("data_taxi_prices", "preis", {timezone = 0, tarifzone = 0});
end

function aktualizeTaxiPricesFromDB()
	MySql.helper.update("data_taxi_prices", { preis = taxiPrices[1][1] }, { timezone = 1, tarifzone = 1});
	MySql.helper.update("data_taxi_prices", { preis = taxiPrices[1][2] }, { timezone = 1, tarifzone = 2});
	MySql.helper.update("data_taxi_prices", { preis = taxiPrices[1][3] }, { timezone = 1, tarifzone = 3});
	MySql.helper.update("data_taxi_prices", { preis = taxiPrices[2][1] }, { timezone = 2, tarifzone = 1});
	MySql.helper.update("data_taxi_prices", { preis = taxiPrices[2][2] }, { timezone = 2, tarifzone = 2});
	MySql.helper.update("data_taxi_prices", { preis = taxiPrices[2][3] }, { timezone = 2, tarifzone = 3});
	MySql.helper.update("data_taxi_prices", { preis = taxiPrices[3][1] }, { timezone = 3, tarifzone = 1});
	MySql.helper.update("data_taxi_prices", { preis = taxiPrices[3][2] }, { timezone = 3, tarifzone = 2});
	MySql.helper.update("data_taxi_prices", { preis = taxiPrices[3][3] }, { timezone = 3, tarifzone = 3});
	MySql.helper.update("data_taxi_prices", { preis = taxiGrundPrice }, { timezone = 0, tarifzone = 0});
end


function setTarif_func(thePlayer,Command,timezone,tarifzone,preis)
	if(vioGetElementData(thePlayer,"fraktion")==4 and vioGetElementData(thePlayer,"fraktionsrang")==6)then
		if(timezone and tarifzone and preis)then
			local timezon=tonumber(timezone)
			local tarifzon=tonumber(tarifzone)
			local prei=tonumber(preis)
			if(timezon and tarifzon and prei)then
				taxiPrices[timezon][tarifzon]=prei
				showError(thePlayer,string.format("Der Neue Preis der Tarifzone %s der Zeitzone %s wurde gesetzt!", tarifzon, timezon))
						
			else
				showError(thePlayer,"Nutzung: /settarif [timezone 1-3] [tarifzone 1-3] [Preis]")
			end
			aktualizeTaxiPricesFromDB()
		else
			showError(thePlayer,"Nutzung: /settarif [timezone 1-3] [tarifzone 1-3] [Preis]")
		end
	else
		showError(thePlayer,"Du bist nicht der Taxileader!")
	end
end
addCommandHandler("settarif",setTarif_func,false,false)

function setGrundTarif_func(thePlayer,Command,preis)
	if(vioGetElementData(thePlayer,"fraktion")==4 and vioGetElementData(thePlayer,"fraktionsrang")==6)then
		if(preis)then

			local prei=tonumber(preis)
			if(prei)then
				taxiGrundPrice=prei
				showError(thePlayer,"Der Neue Grundpreis wurde gesetzt")
						
			else
				showError(thePlayer,"Nutzung: /setgrundtarif [Preis]")
			end
			aktualizeTaxiPricesFromDB()
		else
			showError(thePlayer,"Nutzung: /setgrundtarif [Preis]")
		end
	else
		showError(thePlayer,"Du bist nicht der Taxileader!")
	end
end
addCommandHandler("setgrundtarif",setGrundTarif_func,false,false)



function getTaxiTimeZone()
	local timer=getRealTime()
	local hour=timer["hour"]
	if(hour>=8 and hour<15)then
		return 1
	elseif(hour>=15 and hour<24)then
		return 2
	else
		return 3
	end
end

function donotentertaxi(thePlayer,seat)

	if(seat==0)then
		if(vioGetElementData(thePlayer,"fraktion")~=4)then
			removePedFromVehicle(thePlayer)
			showError(thePlayer,"Du bist kein Taxifahrer!")
		end
	else
		local ttime=getTaxiTimeZone()
	
		outputChatBox("Willkommen im SA-TAXI! Folgende Preise gelten:",thePlayer)
		outputChatBox(string.format("Tarifzone 1:%s", toprice(taxiPrices[ttime][1])),thePlayer)
		outputChatBox(string.format("Tarifzone 2:%s", toprice(taxiPrices[ttime][2])),thePlayer)
		outputChatBox(string.format("Tarifzone 3:%s", toprice(taxiPrices[ttime][3])),thePlayer)
		outputChatBox(string.format("Grundtarif:%s", toprice(taxiGrundPrice)),thePlayer)
	
	end

end












