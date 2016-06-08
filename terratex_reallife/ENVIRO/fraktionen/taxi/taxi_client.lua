
local taxiTaxa=false
local taxaTime=0
local tarif=0
local taxaprice=0
local taxaTimer=false

addEvent("startTaxameter",true)
function startTaxaMeterTimer(grundpreis,tarifer)
	tarif=math.round(tarifer/60,2)
	taxaprice=grundpreis
	taxaTime=0
	taxaTimer=setTimer(taxaAdd,1000,1)
	taxiTaxa=true
end
addEventHandler("startTaxameter",getRootElement(),startTaxaMeterTimer)

addEvent("newTaxaTarif",true)
function setNewTaxaTarif(tarifer)
	tarif=0
	tarif=math.round(tarifer/60,2)

end
addEventHandler("newTaxaTarif",getRootElement(),setNewTaxaTarif)

local taxazahlcounterfortaxidriver=0
function taxaAdd()
	taxaprice=taxaprice+tarif
	taxazahlcounterfortaxidriver=taxazahlcounterfortaxidriver+1
	if(getPlayerMoney(getLocalPlayer())<taxaprice)then
		taxaend("notmoremoney",taxaprice)
		taxiTaxa=false
		killTimer(taxaTimer)
	else
		taxaTime=taxaTime+1
		taxaTimer=setTimer(taxaAdd,1000,1)
	end
	triggerServerEvent("saveTaxaMeter",getLocalPlayer(),taxaprice)
	if(taxazahlcounterfortaxidriver>10)then
		triggerServerEvent("showTaxaMeterToDriver",getLocalPlayer(),taxaprice)
		taxazahlcounterfortaxidriver=0
	end
	
end

function taxaend(reason,price)
	price=math.round(price,0)
	triggerServerEvent("stopTaxaMeter",getLocalPlayer(),reason,price)


end

function onTaxaVehicleExit(thePlayer,Seat)
	if(thePlayer==getLocalPlayer())then
		if(taxiTaxa)then
			taxiTaxa=false
			killTimer(taxaTimer)
			taxaend("isgoneout",taxaprice)
		end
	end
end
addEventHandler("onClientVehicleExit",getRootElement(),onTaxaVehicleExit)


function showTaxaMeter()
	if(taxiTaxa)then

        dxDrawRectangle(544.0,18.0,456.0,86.0,tocolor(0,0,0,255),false)
		local taxastring="Zeit: "..taxaTime.."s"
        dxDrawText(taxastring,561.0,22.0,938.0,51.0,tocolor(255,255,255,255),2.0,"default","left","top",false,false,false)
        taxastring="Preis: "..math.round(taxaprice,0).."$"
		dxDrawText(taxastring,561.0,55.0,985.0,84.0,tocolor(255,255,255,255),2.0,"default","left","top",false,false,false)

	end
end
addEventHandler("onClientRender",getRootElement(),showTaxaMeter)


function onPedWastedInTaxi()
	if(source==getLocalPlayer())then
		if(taxiTaxa)then
			taxiTaxa=false
			killTimer(taxaTimer)
			taxaend("dead",taxaprice)
		end
	
	end
end
addEventHandler("onClientPlayerWasted",getRootElement(),onPedWastedInTaxi)












