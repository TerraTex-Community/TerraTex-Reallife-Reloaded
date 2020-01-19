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
	local dis=getDistanceBetweenPoints3D(x,y,z,1812.8000488281, -2072.3620605469, 14.265000343323)
	if(dis<20)then
		if(vioGetElementData(thePlayer,"fraktion")==4)then
			if(taxiObjectOpen)then
				moveObject(taxiObject,2500,1812.8000488281, -2072.3620605469, 14.265000343323)
				taxiObjectOpen=false
			else
				moveObject(taxiObject,2500,1812.8000488281, -2063.8000488281, 14.265000343323)
				taxiObjectOpen=true
			end
		end
	end
end
addCommandHandler("mv",mv_taxi_func,false,false)

function onCreatetaxicars_func()
	-- Fraktionstor
	taxiObject=createObject(2933, 1812.8000488281, -2072.3620605469, 14.265000343323, 0, 0, 90)
	-- Cabbie
	frakselfcars[4][1]  = createVehicle(438, 1808.900390625, -2037.7001953125, 13.539999961853, 0, 0, 0, "SA-TAXI")
	frakselfcars[4][2]  = createVehicle(438, 1805.299804687, -2037.7001953125, 13.539999961853, 0, 0, 0, "SA-TAXI")
	frakselfcars[4][3]  = createVehicle(438, 1801.599609375, -2037.7001953125, 13.539999961853, 0, 0, 0, "SA-TAXI")
	frakselfcars[4][4]  = createVehicle(438, 1797.7998046875, -2037.7001953125, 13.539999961853, 0, 0, 0, "SA-TAXI")
	frakselfcars[4][5]  = createVehicle(438, 1794.099609375, -2037.7001953125, 13.539999961853, 0, 0, 0, "SA-TAXI")
	-- Taxi
	frakselfcars[4][6]  = createVehicle(420, 1808.900390625, -2024.2998046875, 13.35000038147, 0, 0, 180, "SA-TAXI")
	frakselfcars[4][7]  = createVehicle(420, 1805.299804687, -2024.2998046875, 13.35000038147, 0, 0, 180, "SA-TAXI")
	frakselfcars[4][8]  = createVehicle(420, 1801.599609375, -2024.2998046875, 13.35000038147, 0, 0, 180, "SA-TAXI")
	frakselfcars[4][9]  = createVehicle(420, 1797.799804687, -2024.2998046875, 13.35000038147, 0, 0, 180, "SA-TAXI")
	frakselfcars[4][10]  = createVehicle(420, 1794.099609375, -2024.2998046875, 13.35000038147, 0, 0, 180, "SA-TAXI")
	-- Maverick
	frakselfcars[4][11] = createVehicle(487, 1736.099609375, -2063.099609375, 17.75, 0, 0, 212, "SA-TAXI")
	-- Stafford
	frakselfcars[4][12]  = createVehicle(580, 1807.6999511719, -2043.3000488281, 13.345000267029, 0, 0, 90, "SA-TAXI")
	frakselfcars[4][13]  = createVehicle(580, 1807.6999511719, -2047.0999755859, 13.345000267029, 0, 0, 90, "SA-TAXI")
	frakselfcars[4][14]  = createVehicle(580, 1807.6999511719, -2050.8999023438, 13.345000267029, 0, 0, 90, "SA-TAXI")
	-- Stretch
	frakselfcars[4][15] = createVehicle(409, 1806.8000488281, -2054.6000976563, 13.319999694824, 0, 0, 90, "SA-TAXI")
	-- Bus
	frakselfcars[4][16] = createVehicle(431, 1805, -2058.3994140625, 13.655, 0, 0, 90, "SA-TAXI")

	for theKey,theVehicle in ipairs(frakselfcars[4]) do
	setVehicleColor ( theVehicle, 6,6,6,6 )
	prepare(theVehicle,4)
	addEventHandler("onVehicleEnter",theVehicle,donotentertaxi)
	vioSetElementData(theVehicle,"tank",100)
	table.insert(frakcars,theVehicle)
	end
	loadTaxiPricesFromDB()
end
addEventHandler("factionLoadingReady",getResourceRootElement(getThisResource()),onCreatetaxicars_func)

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

function taxicarNotEnter(thePlayer, seat, jacked, door)
	if (seat == 0) then
		for theKey, theVehicle in pairs(frakselfcars[4]) do
			if (source == theVehicle) then
				if not(vioGetElementData(thePlayer, "fraktion") == 4) then
                    			showError(thePlayer, "Du kannst das nicht benutzen. Du bist kein Taxifahrer!")
					cancelEvent()
				end
			end
		end
	end 
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), taxicarNotEnter )

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

