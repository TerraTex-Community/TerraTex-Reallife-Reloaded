local sweeperJobAbgabeMarker=false
local sweeperJobBlip=false

local kilometers=0
local checkpoints=0
local lastmarker=-1
local abgabeMarker=false
local abgabeBlip=false
local lastx=0
local lasty=0
local lastz=0
local sweepermarker = {}

function createSweeperMarker()
	table.insert(sweepermarker,{1990.2216796875,2120.9443359375,10.545271873474}) 
	table.insert(sweepermarker,{1919.8896484375,2061.8447265625,10.545431137085}) 
	table.insert(sweepermarker,{2053.9931640625,1742.9453125,10.545502662659}) 
	table.insert(sweepermarker,{2033.7548828125,1543.2744140625,10.545404434204}) 
	table.insert(sweepermarker,{2032.7705078125,1304.1708984375,10.545435905457}) 
	table.insert(sweepermarker,{2020.4755859375,1155.9287109375,10.545454978943}) 
	table.insert(sweepermarker,{2030.9169921875,1013.568359375,10.545429229736}) 
	table.insert(sweepermarker,{2153.771484375,947.626953125,10.545571327209}) 
	table.insert(sweepermarker,{2173.517578125,1117.146484375,12.399363517761}) 
	table.insert(sweepermarker,{2233.068359375,1282.6484375,10.550708770752}) 
	table.insert(sweepermarker,{2182.271484375,1285.7490234375,10.46167755127}) 
	table.insert(sweepermarker,{2349.5595703125,1365.998046875,10.545431137085}) 
	table.insert(sweepermarker,{2516.017578125,1365.5,10.545437812805}) 
	table.insert(sweepermarker,{2553.2216796875,1448.3154296875,10.545432090759}) 
	table.insert(sweepermarker,{2489.6650390625,1530.2841796875,10.542452812195}) 
	table.insert(sweepermarker,{2415.1416015625,1620.16796875,10.54542350769}) 
	table.insert(sweepermarker,{2319.6611328125,1780.3095703125,10.537552833557}) 
	table.insert(sweepermarker,{2156.1201171875,1844.515625,10.545430183411}) 
	table.insert(sweepermarker,{2367.7509765625,1950.5087890625,10.546677589417}) 
	table.insert(sweepermarker,{2446.3017578125,1980.9970703125,10.545428276062}) 
	table.insert(sweepermarker,{2425.4208984375,2060.6240234375,10.537686347961}) 
	table.insert(sweepermarker,{2366.685546875,2122.724609375,10.553468704224}) 
	table.insert(sweepermarker,{2314.8349609375,2156.4072265625,10.545428276062}) 
	table.insert(sweepermarker,{2235.8828125,2128.67578125,10.545431137085}) 
	table.insert(sweepermarker,{2160.044921875,2120.7548828125,10.545315742493})
	-- outputChatBox(getDistanceBetweenPoints3D(1990.2216796875,2120.9443359375,10.545271873474, 2446.3017578125,1980.9970703125,10.545428276062), getRootElement())
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),createSweeperMarker)

function onEnterMarker_sweeperjob_func(thePlayer)
	if(source==sweeperJobAbgabeMarker)and(thePlayer==getLocalPlayer())then
		checkpoints=checkpoints+1
		outputChatBox(string.format("Danke für die bisherige Arbeit (bisher %s Dreck). Fahren sie nun die nächste Strecke ab!", checkpoints))		
		if(abgabeMarker)then
			destroyElement(abgabeMarker)
		end
		if(abgabeBlip)then
			destroyElement(abgabeBlip)
		end
		if(sweeperJobAbgabeMarker)then
			destroyElement(sweeperJobAbgabeMarker)
		end
		if(sweeperJobBlip)then
			destroyElement(sweeperJobBlip)
		end
		kilometers=kilometers+getDistanceBetweenPoints3D(lastx,lasty,lastz,sweepermarker[lastmarker][1],sweepermarker[lastmarker][2],sweepermarker[lastmarker][3])
		lastx,lasty,lastz=getElementPosition(getLocalPlayer())	
		lastmarker=-1
		sweeperJobBlip=false
		sweeperJobAbgabeMarker=false
		abgabeBlip=false
		abgabeMarker=false
		lastmarker=math.random(1,table.getn(sweepermarker))
		sweeperJobAbgabeMarker=createMarker(sweepermarker[lastmarker][1],sweepermarker[lastmarker][2],sweepermarker[lastmarker][3],"cylinder",3.0,13,130,0)
		sweeperJobBlip= createBlip(sweepermarker[lastmarker][1],sweepermarker[lastmarker][2],sweepermarker[lastmarker][3],0,2,13,130,0)
		abgabeMarker=createMarker(1646.8671875,688.380859375,10.545481681824,"cylinder",3.0,0,0,255)
		abgabeBlip=createBlip(1646.8671875,688.380859375,10.545481681824,0,2,0,0,255,255,0,1200)
		outputChatBox("Fahr die Marker ab um die Straße zu säubern. -> grüner Marker")
		outputChatBox("Oder liefern Sie den bereits im Fahrzeug gesammelten Dreck ab. -> blauer Marker")
	elseif(source==abgabeMarker)and(thePlayer==getLocalPlayer())then
		triggerServerEvent("giveBackSweeperJob",getLocalPlayer(),kilometers,checkpoints)	
		kilometers=0
		checkpoints=0		
	end
end
addEventHandler("onClientMarkerHit",getRootElement(),onEnterMarker_sweeperjob_func)

addEvent("exitSweeperJob",true)
function exitSweeperJob_func()
	if(source==getLocalPlayer())then
		if(abgabeMarker)then
			destroyElement(abgabeMarker)
		end
		if(abgabeBlip)then
			destroyElement(abgabeBlip)
		end
		if(sweeperJobAbgabeMarker)then
			destroyElement(sweeperJobAbgabeMarker)
		end
		if(sweeperJobBlip)then
			destroyElement(sweeperJobBlip)
		end
		sweeperJobBlip=false
		sweeperJobAbgabeMarker=false
		abgabeBlip=false
		abgabeMarker=false
	end
end
addEventHandler("exitSweeperJob",getRootElement(),exitSweeperJob_func)
addEventHandler("onClientPlayerWasted",getRootElement(),exitSweeperJob_func)

addEvent("startSweeperJob",true)
function startSweeperJob_func()
	if(lastmarker~=-1)then
		sweeperJobAbgabeMarker=createMarker(sweepermarker[lastmarker][1],sweepermarker[lastmarker][2],sweepermarker[lastmarker][3],"cylinder",3.0,13,130,0)
		sweeperJobBlip=createBlip(sweepermarker[lastmarker][1],sweepermarker[lastmarker][2],sweepermarker[lastmarker][3],0,2,13,130,0)
		abgabeMarker=createMarker(1646.8671875,688.380859375,10.545481681824,"cylinder",3.0,0,0,255)
		abgabeBlip=createBlip(1646.8671875,688.380859375,10.545481681824,0,2,0,0,255,255,0,1200)
		outputChatBox("Fahr die Marker ab um die Straße zu säubern. -> grüner Marker")
		outputChatBox("Oder liefern Sie den bereits im Fahrzeug gesammelten Dreck ab. -> blauer Marker")
	else
		lastmarker=math.random(1,table.getn(sweepermarker))
		sweeperJobAbgabeMarker=createMarker(sweepermarker[lastmarker][1],sweepermarker[lastmarker][2],sweepermarker[lastmarker][3],"cylinder",3.0,13,130,0)
		sweeperJobBlip=createBlip(sweepermarker[lastmarker][1],sweepermarker[lastmarker][2],sweepermarker[lastmarker][3],0,2,13,130,0)
		abgabeMarker=createMarker(1646.8671875,688.380859375,10.545481681824,"cylinder",3.0,0,0,255)
		outputChatBox("Fahr die Marker ab um die Straße zu säubern. -> grüner Marker")
		outputChatBox("Oder liefern Sie den bereits im Fahrzeug gesammelten Dreck ab. -> blauer Marker")
		lastx,lasty,lastz=getElementPosition(getLocalPlayer())		
	end
end
addEventHandler("startSweeperJob",getRootElement(),startSweeperJob_func)

--DRECKANZEIGE
addEventHandler("onClientRender", root,
    function()
		if(isElement(sweeperJobBlip))then
			local screenW, screenH = guiGetScreenSize()    
			textstring=checkpoints
			dxDrawRectangle(screenW - 220 - 10, (screenH - 46) / 2, 220, 46, tocolor(0, 13, 71, 220), false)
			dxDrawText("Dreck: "..textstring, screenW - 201 - 10, (screenH - 46) / 2, (screenW - 201 - 10) + 201, ( (screenH - 46) / 2) + 46, tocolor(255, 255, 255, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
		end
	end
)









