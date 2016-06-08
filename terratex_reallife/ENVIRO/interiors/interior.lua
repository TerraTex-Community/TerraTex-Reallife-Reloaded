

interiorMarker={}
polizeiraus=false
ammonationmarker=false
lvpdraus=false
casinomarker=false
--table.insert(interiorMarker,{mark,portx,porty,portz,Interior,eigeneDIM,portDIM})
function createInteriorMarker()
local mark=createMarker(1554.6064453125,-1675.6083984375,16.1953125,"corona",2.0) --PDMarker drausen
table.insert(interiorMarker,{mark,246.566085,110.7910156,1002.193481,10,0,0})

mark=createMarker(246.5898895,107.791107,1002.19348,"corona",2.0)	--PDMarker drin
table.insert(interiorMarker,{mark,1549.9189453125,-1675.724609375,15.179713249207,0,0})
setElementInterior(mark,10)

local mark=createMarker(2196.201171875,1677.2685546875,12.3671875,"corona",2.0) --casin drausen
table.insert(interiorMarker,{mark,2233.9443359375,1706.697265625,1010.0504150391,1,0,0})
casinomarker=mark

mark=createMarker(2233.671875,1713.8076171875,1012.2516479492,"corona",2.0)	--casin drin
table.insert(interiorMarker,{mark,2193.09765625,1677.2080078125,12.3671875,0,0})
setElementInterior(mark,1)

mark=createMarker(1480.8837890625,-1770.935546875,18.795755386353,"corona",2.0)	--StadthalleMarker drausen
table.insert(interiorMarker,{mark,386.825317,173.7809600,1007.358520,3,0,0})

mark=createMarker(390.093566,173.8429565,1007.358520,"corona",2.0)	--StadthalleMarker drin
table.insert(interiorMarker,{mark,1481.52734375,-1757.8447265625,17.53125,0,0,0})
setElementInterior(mark,3)

mark=createMarker(2495.396484375,-1690.548828125,14.765625,"corona",2.0)	--grove drausen
table.insert(interiorMarker,{mark,2495.9282,-1694.5155,1014.39141,3,0,0})
setElementInterior(mark,0)

mark=createMarker(2495.98535,-1692.2666,1014.39142,"corona",2.0)	--StadthalleMarker drin
table.insert(interiorMarker,{mark,2495.099609375,-1686.7861328125,13.514009475708,0,0,0})
setElementInterior(mark,3)


mark=createMarker(2166.3935546875,-1671.7578125,15.074158668518,"corona",2.0)--drogenhaus
table.insert(interiorMarker,{mark,318.3349609375,1118.4599609375,1084.8828125,5,0,0})


mark=createMarker(318.916015625,1114.875,1083.8828125,"corona",2.0)--drogenhausdrin
table.insert(interiorMarker,{mark,2168.5478515625,-1674.232421875,15.083921432495,0,0,0})
setElementInterior(mark,5)


mark=createMarker(1568.6015625,-1690.0556640625,6.21875,"corona",2.0)--polizeigarage
table.insert(interiorMarker,{mark,226.0908203125,114.693359375,999.015625,10,0,0})


mark=createMarker(228.830078125,114.5498046875,999.015625,"corona",2.0)--polizeiknast
polizeiraus=mark
table.insert(interiorMarker,{mark,1568.587890625,-1693.400390625,5.890625,0,0,0})
setElementInterior(mark,10)


----<<<<ammonation >>>>>-------

mark=createMarker(1368.4521484375,-1279.8427734375,13.546875,"corona",2.0)--ammoausen
table.insert(interiorMarker,{mark,313.486328125,-139.6767578125,999.6015625,7,0,0})
ammonationmarker=mark

mark=createMarker(316.01171875,-143.65234375,999.6015625,"corona",2.0)--ammoINNEN
table.insert(interiorMarker,{mark,1365.47265625,-1279.580078125,13.546875,0,0,0})
setElementInterior(mark,7)


mark=createMarker(2556.96875,2065.314453125,11.099519729614,"corona",2.0)--ammoausen
table.insert(interiorMarker,{mark,313.486328125,-139.6767578125,999.6015625,7,0,1})
ammonationmarker=mark

mark=createMarker(316.01171875,-143.65234375,999.6015625,"corona",2.0)--ammoINNEN
table.insert(interiorMarker,{mark,2556.94921875,2063.0576171875,10.8203125,0,1,0})
setElementInterior(mark,7)
setElementDimension(mark,1)


----<<<<Startower >>>>>-------

mark=createMarker(1567.7978515625,-1333.490234375,16.484375,"corona",2.0)--unten
table.insert(interiorMarker,{mark,1541.37890625,-1363.5126953125,329.796875,0,0,0})


mark=createMarker(1548.705078125,-1363.7421875,326.21829223633,"corona",2.0)--oben
table.insert(interiorMarker,{mark,1572.984375,-1330.3095703125,16.484375,0,0,0})

createPickup ( 1526.919921875,-1346.65234375,329.97796630859, 2,46, 10000)

----<<<<BANK>>>----
mark=createMarker(1381.412109375,-1088.748046875,27.449289321899,"corona",2.0)--drausen
table.insert(interiorMarker,{mark, 1542.21875,1691.552734375,8373.9833984375,1,0,0})

mark=createMarker(1542.052734375,1694.662109375,8373.9833984375,"corona",2.0)--innen
table.insert(interiorMarker,{mark,1374.775390625,-1089.404296875,25.493423461914,0,0,0})
setElementInterior(mark,1)

---<<<BARS>>>----
---<<<Alhambra>>>----
mark=createMarker(1836.7255859375,-1682.9140625,13.335935592651,"corona",2.0)--drausen
table.insert(interiorMarker,{mark,493.940234375,-21.833984375,1000.6796875,17,0,0})

mark=createMarker(493.1728515625,-24.326171875,1000.6796875,"corona",2.0)--innen
table.insert(interiorMarker,{mark,1833.2099609375,-1683.716796875,13.482824325562,0,0,0})
setElementInterior(mark,17)


---<<<Green Bottels>>>----
mark=createMarker(2310.2158203125,-1643.6650390625,14.827047348022,"corona",2.0)--drausen
table.insert(interiorMarker,{mark,502.8154296875,-71.1513671875,998.7578125,11,0,0})

mark=createMarker(501.888671875,-68.2734375,998.7578125,"corona",2.0)--innen
table.insert(interiorMarker,{mark,2307.0439453125,-1646.88671875,14.754017829895,0,0,0})
setElementInterior(mark,11)

---<<<Pig Pen>>>----
mark=createMarker(2421.4716796875,-1219.5703125,25.540721893311,"corona",2.0)--drausen
table.insert(interiorMarker,{mark,1205.51171875,-10.9794921875,1000.921875,2,0,0})

mark=createMarker(1204.8232421875,-13.6611328125,1000.921875,"corona",2.0)--innen
table.insert(interiorMarker,{mark,2420.7646484375,-1223.6171875,25.239570617676,0,0,0})
setElementInterior(mark,2)



-- kirche
mark=createMarker(2233.33203125,-1333.3525390625,23.981576919556,"corona",2.0)--drausen
table.insert(interiorMarker,{mark,2534.4267578125,-1235.7543945312,21163.900390625,2,0,0})

mark=createMarker(2534.1826171875,-1232.5815429688,21163.890625,"corona",2.0)--innen
table.insert(interiorMarker,{mark,2229.8076171875,-1333.4658203125,23.981603622437,0,0,0})
setElementInterior(mark,2)

-- Mafia
--[[
mark=createMarker(980.294921875,-677.298828125,121.97625732422,"corona",2.0)--drausen
table.insert(interiorMarker,{mark,2324.1064453125,-1147.025390625,1050.7100830078,12,0,0})

mark=createMarker(2324.2900390625,-1149.369140625,1050.7100830078,"corona",2.0)--innen
table.insert(interiorMarker,{mark,979.5908203125,-674.9736328125,121.97625732422,0,0,0})
setElementInterior(mark,12)]]


--lvps unten
mark=createMarker(2289.9482421875,2431.615234375,10.8203125,"corona",2.0)--drausen
table.insert(interiorMarker,{mark,238.9560546875,141.5869140625,1003.0234375,3,0,0})

mark=createMarker( 238.7900390625,138.6328125,1003.0234375,"corona",2.0)--innen
table.insert(interiorMarker,{mark,2288.8681640625,2427.8134765625,10.8203125,0,0,0})
setElementInterior(mark,3)

mark=createMarker(2339.8505859375,2458.2001953125,14.96875,"corona",2.0)--drausen
table.insert(interiorMarker,{mark,288.7470703125,169.58984375,1007.171875,3,0,0})

mark=createMarker( 288.8486328125,166.9208984375,1007.171875,"corona",2.0)--innen
table.insert(interiorMarker,{mark,2340.275390625,2454.53515625,14.96875,0,0,0})
setElementInterior(mark,3)

mark=createMarker(2268.001953125,2449.2890625,3.53125,"corona",2.0)--drausen
table.insert(interiorMarker,{mark,197.5341796875,165.888671875,1003.0234375,3,0,0})

mark=createMarker(196.2041015625,168.798828125,1003.0234375 ,"corona",2.0)--innen
lvpdraus=mark
table.insert(interiorMarker,{mark,2268.1162109375,2445.2587890625,3.2734375,0,0,0})
setElementInterior(mark,3)

mark=createMarker(2252.498046875,2452.4016113281,39.154590606689,"corona",2.0)--drausen
table.insert(interiorMarker,{mark,2291.4521484375,2468.677734375,10.8203125,0,0,0})

mark=createMarker(2297.1162109375,2468.8125,10.8203125,"corona",2.0)--innen
table.insert(interiorMarker,{mark,2248.67578125,2453.189453125,38.683673858643,0,0,0})

--medic

mark=createMarker(1591.5654296875,1784.5583496094,30.95458984375,"corona",2.0)--drausen
table.insert(interiorMarker,{mark,1582.796875,1799.3994140625,10.8203125,0,0,0})

mark=createMarker(1585.03125,1796.748046875,10.8203125,"corona",2.0)--innen
table.insert(interiorMarker,{mark,1591.3857421875,1786.845703125,30.473016738892,0,0,0})

--tombupot LS
mark=createMarker(1631.8291015625,-1172.669921875,24.079999923706,"corona",2.0)--drausen
table.insert(interiorMarker,{mark,830.9775390625,7.99609375,1004.1796875,3,0,0})

mark=createMarker(834.34997558594,7.3800001144409,1004.1900024414,"corona",2.0)--innen
table.insert(interiorMarker,{mark,1631.6650390625,-1167.7939453125,24.078125,0,0,0})
setElementInterior(mark,3)

--tombupot LV


mark=createMarker(2202.0600585938,2124.6599121094,10.819999694824,"corona",1.0)--drausen
table.insert(interiorMarker,{mark,-2158.6398925781,640.89001464844,1052.3800048828,1,0,0})

mark=createMarker(-2158.6398925781,642.89001464844,1052.3800048828,"corona",1.0)--innen
table.insert(interiorMarker,{mark,2201.9921875,2127.953125,10.8203125,0,0,0})
setElementInterior(mark,1)

--jefferson hotel
mark=createMarker(2193.1748046875,-1151.26953125,33.524044036865,"corona",1.0)--drausen
table.insert(interiorMarker,{mark,2193.40234375,-1146.146484375,1033.796875,15,0,0})

mark=createMarker(2193.3193359375,-1147.6650390625,1033.796875,"corona",1.0)--innen
table.insert(interiorMarker,{mark,2193.255859375,-1154.1826171875,33.524044036865,0,0,0})
setElementInterior(mark,15)


mark=createMarker(2233.1064453125,-1159.6708984375,25.890625,"corona",1.0)--drausen
table.insert(interiorMarker,{mark,2216.3818359375,-1150.5595703125,1025.796875,15,0,0})

mark=createMarker(2214.384765625,-1150.525390625,1025.796875,"corona",1.0)--innen
table.insert(interiorMarker,{mark,2231.7529296875,-1159.51171875,25.890625,0,0,0})
setElementInterior(mark,15)


-- jizzys
mark=createMarker(-2624.5908203125,1412.7490234375,7.09375,"corona",1.0)--drausen
table.insert(interiorMarker,{mark,-2636.662109375,1404.486328125,906.4609375,3,0,0})

mark=createMarker(-2636.6806640625,1402.46484375,906.4609375,"corona",1.0)--innen
table.insert(interiorMarker,{mark,-2624.2236328125,1411.095703125,7.09375,0,0,0})
setElementInterior(mark,3)

mark=createMarker(-2660.6259765625,1421.267578125,23.8984375,"corona",1.0)--drausen
table.insert(interiorMarker,{mark,-2660.9833984375,1415.84765625,922.1953125,3,0,0})

mark=createMarker(-2660.88671875,1417.671875,922.1953125,"corona",1.0)--innen
table.insert(interiorMarker,{mark,-2661.712890625,1424.869140625,23.8984375,0,0,0})
setElementInterior(mark,3)

--MEDIC LS
mark=createMarker(2069.4338378906,-1411.2083740234,48.526287078857,"corona",1.0)--drausen
table.insert(interiorMarker,{mark,2034.748046875,-1405.8740234375,17.222845077515,0,0,0})

mark=createMarker(2034.177734375,-1401.669921875,17.294855117798,"corona",1.0)--innen
table.insert(interiorMarker,{mark,2069.3244628906,-1414.0413818359,48.526390075684,0,0,0})


--Alkatraz
mark=createMarker(3409.6032714844,88.828102111816,17.231199264526,"corona",1.0)--drausen
table.insert(interiorMarker,{mark,3446.7119140625,98.343696594238,700.96881103516,2,0,0})

mark=createMarker(3448.4682617188,98.343696594238,700.96881103516,"corona",1.0)--innen
setElementInterior(mark,2)
table.insert(interiorMarker,{mark,3407.5417480469,88.828102111816,17.231199264526,0,0,0})

--Kino
mark=createMarker(1290.8129882813,-1160.4437255859,23.961000442505,"corona",1.0)--drausen
table.insert(interiorMarker,{mark,1318.0874023438,-1683.2891845703,1482.052734375,1,0,0})

mark=createMarker(1316.0874023438,-1683.2891845703,1482.052734375,"corona",1.0)--innen
setElementInterior(mark,1)
table.insert(interiorMarker,{mark,1290.8129882813,-1158.4437255859,23.961000442505,0,0,0})


mark=createMarker(1283.7807617188,-1160.443359375,23.961000442505,"corona",1.0)--drausen
table.insert(interiorMarker,{mark,1319.087890625,-1688.9251708984,1482.052734375,1,0,0})

mark=createMarker(1317.087890625,-1688.9251708984,1482.052734375,"corona",1.0)--innen
setElementInterior(mark,1)
table.insert(interiorMarker,{mark,1283.7807617188,-1158.443359375,23.961000442505,0,0,0})



end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createInteriorMarker)
 
 
  
function MarkerHit( hitElement, matchingDimension )
	if isElement(hitElement)and isElement(source)then
		if(getElementDimension(hitElement)==getElementDimension(source))then
			if(isElement(hitElement))then
				if( getElementType (hitElement)=="player")then
					local dim=getElementDimension(hitElement)
					if not(isPedInVehicle(hitElement))then
						for key, theMarkerTable in pairs(interiorMarker) do
							if (source==theMarkerTable[1] and matchingDimension and dim==theMarkerTable[6])then
								if(source==polizeiraus)or(source==lvpdraus)then
									if(isBeamter(hitElement))then
										setElementInterior ( hitElement, theMarkerTable[5], theMarkerTable[2], theMarkerTable[3], theMarkerTable[4]  )
										setElementPosition (hitElement, theMarkerTable[2], theMarkerTable[3], theMarkerTable[4]  )
										setElementDimension(hitElement,theMarkerTable[7])
									end
								elseif(source==ammonationmarker)then
									if(vioGetElementData(hitElement,"waffenLic")==1)then
										setElementInterior ( hitElement, theMarkerTable[5], theMarkerTable[2], theMarkerTable[3], theMarkerTable[4]  )
										setElementPosition (hitElement, theMarkerTable[2], theMarkerTable[3], theMarkerTable[4]  )
										setElementDimension(hitElement,theMarkerTable[7])
										respawnAmmoBot_Server()
									else
										showError(hitElement,"Aufseher: Sie besitzen keinen Waffenschein, daher sind sie hier unerwünscht! Bitte verpissen Sie sich!")
									end					
								else
									setElementInterior ( hitElement, theMarkerTable[5], theMarkerTable[2], theMarkerTable[3], theMarkerTable[4]  )
									setElementPosition (hitElement, theMarkerTable[2], theMarkerTable[3], theMarkerTable[4]  )
									setElementDimension(hitElement,theMarkerTable[7])
								end
								if((casinomarker==source))then
									outputChatBox("Der Innenraum und sämtliche Spiele sind überwacht, Diebstahl und Bugusing lohnt sich nicht!",hitElement,255,0,0)
								end
							end
						end	
					
					end	
				end
			end
		end
	end
end
addEventHandler( "onMarkerHit", getRootElement(), MarkerHit )








