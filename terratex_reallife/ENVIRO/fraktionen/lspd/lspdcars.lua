policeVehicles = {}
frakselfcars[1] = {}
spezpoliceVehicles = {}
frakselfcars[5] = {}
frakselfcars[7] = {}
alkaHeli = false
frakselfcars[9] = {}
transportHeliArmy = false

function createpoliceVehicles()
    ----- San Andreas Police Department -----
    local vehicle = createVehicle(427, 1530.76953125, -1645.4794921875, 6.0225720405579, 0.0164794921875, 0, 178.87390136719, "SAPD")    --  lspdspez
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    vehicle = createVehicle(601, 1538.2841796875, -1646.732421875, 5.6493811607361, 0.010986328125, 0, 180.72509765625, "SAPD")    --  SAPD Spez
    table.insert(policeVehicles, vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(599, 1545.6240234375, -1667.8232421875, 6.0825362205505, 0.5108642578125, 359.99450683594, 89.467163085938, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(599, 1545.29296875, -1675.9384765625, 6.0781674385071, 0.5218505859375, 359.99450683594, 90.68115234375, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(599, 1545.1943359375, -1671.806640625, 6.0814700126648, 0.516357421875, 359.99450683594, 89.434204101562, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(596, 1595.5654296875, -1709.6142578125, 5.6130518913269, 359.6923828125, 0, 0, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(596, 1591.73046875, -1709.923828125, 5.6105623245239, 359.68688964844, 0, 359.04418945312, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(596, 1587.3896484375, -1710.56640625, 5.6125073432922, 359.6923828125, 0, 0.0054931640625, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(596, 1583.583984375, -1710.12890625, 5.6106638908386, 359.68688964844, 0, 358.05541992188, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(596, 1579.091796875, -1710.7607421875, 5.6116037368774, 359.6923828125, 0, 358.9892578125, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(596, 1574.306640625, -1710.8212890625, 5.6137871742249, 359.69787597656, 0, 358.82446289062, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(596, 1570.3681640625, -1710.8447265625, 5.6122918128967, 359.6923828125, 0, 358.74755859375, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(523, 1527.7001953125, -1688.62890625, 5.461311340332, 359.24194335938, 0, 266.62719726562, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(523, 1528.69140625, -1684.5400390625, 5.4601635932922, 359.23095703125, 359.99450683594, 268.81896972656, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(523, 1528.7666015625, -1682.3896484375, 5.4608669281006, 359.23645019531, 0, 275.52062988281, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(430, 121.8955078125, -1925.0419921875, -0.46229895949364, 1.329345703125, 1.7578125, 97.15209960937, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(430, 122.0556640625, -1919.873046875, 0.20916403830051, 0.7470703125, 1.47216796875, 89.8791503, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(523, 1527.6142578125, -1686.654296875, 5.4626760482788, 359.2529296875, 359.99450683594, 270.0439453125, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(596, 1563.892578125, -1710.0361328125, 5.6127467155457, 359.6923828125, 359.99450683594, 359.384765625, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(596, 1559.353515625, -1710.9814453125, 5.6111259460449, 359.6923828125, 0, 0.076904296875, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(497, 1551.2177734375, -1643.521484375, 28.577011108398, 0.2691650390625, 359.6923828125, 97.734375, "SAPD")    --  Police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(525, 1602.25, -1704.25, 5.7690386772156, 358.14880371094, 0, 91.021728515625, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(525, 1602.3232421875, -1700.0439453125, 5.7743692398071, 358.23669433594, 0, 89.71435546875, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(525, 1602.083984375, -1696.36328125, 5.7798552513123, 358.330078125, 0, 90.401000976562, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(525, 1602.0107421875, -1692.1064453125, 5.7696723937988, 358.15979003906, 0, 89.511108398438, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(497, 1380.3095703125, -1607.3212890625, 38.484413146973, 0.32958984375, 359.57702636719, 345.38269042969, "SAPD")    --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)

    --[[	-- Enforcer --
        vehicle = createVehicle(427, 1526.5, -1645.2001953125, 6, 0, 0, 180, "SAPD")
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        table.insert(spezpoliceVehicles, vehicle)
        vehicle = createVehicle(427, 1530.599609375, -1645.2001953125, 6, 0, 0, 180, "SAPD")
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        table.insert(spezpoliceVehicles, vehicle)
        -- FBI Truck --
        vehicle = createVehicle(528, 1534.7001953125, -1645.400390625, 5.9000000953674, 0, 0, 180, "SAPD") --  SAPD Spez
        table.insert(policeVehicles, vehicle)
        table.insert(spezpoliceVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(528, 1538.7998046875, -1645.400390625, 5.9000000953674, 0, 0, 180, "SAPD") --  SAPD Spez
        table.insert(policeVehicles, vehicle)
        table.insert(spezpoliceVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        -- S.W.A.T. (Wasserwerfer) --
        vehicle = createVehicle(601, 1528.7001953125, -1688, 5.5999999046326, 0, 0, 270, "SAPD") --  SAPD Spez
        table.insert(policeVehicles, vehicle)
        table.insert(spezpoliceVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(601, 1528.7001953125, -1683.900390625, 5.5999999046326, 0, 0, 270, "SAPD") --  SAPD Spez
        table.insert(policeVehicles, vehicle)
        table.insert(spezpoliceVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        -- Securicar (Academy) --
        vehicle = createVehicle(428, 1558.7998046875, -1710.900390625, 6, 0, 0, 0, "ACADEMY") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        -- Patriot (Academy) --
        vehicle = createVehicle(470, 1545, -1651, 5.9000000953674, 0, 0, 90, "ACADEMY") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(470, 1545, -1655, 5.9000000953674, 0, 0, 90, "ACADEMY") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(470, 1545, -1659, 5.9000000953674, 0, 0, 90, "ACADEMY") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(470, 1545, -1663, 5.9000000953674, 0, 0, 90, "ACADEMY") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        -- Stratum (Academy) --
        vehicle = createVehicle(561, 1563, -1710.599609375, 5.6999998092651, 0, 0, 0, "ACADEMY") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(561, 1566.2998046875, -1710.599609375, 5.6999998092651, 0, 0, 0, "ACADEMY") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        -- LS Police Car --
        vehicle = createVehicle(596, 1601.900390625, -1684, 5.5999999046326, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(596, 1601.900390625, -1688, 5.5999999046326, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(596, 1601.900390625, -1692, 5.5999999046326, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(596, 1601.900390625, -1696.0999755859, 5.5999999046326, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(596, 1601.900390625, -1700.2001953125, 5.5999999046326, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(596, 1601.900390625, -1704.2998046875, 5.5999999046326, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(596, 1595.5, -1710.5, 5.5999999046326, 0, 0, 0, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(596, 1591.400390625, -1710.5, 5.5999999046326, 0, 0, 0, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(596, 1587.400390625, -1710.5, 5.5999999046326, 0, 0, 0, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(596, 1583.299804687, -1710.5, 5.5999999046326, 0, 0, 0, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        -- HPV 1000 (Police-Bike) --
        vehicle = createVehicle(523, 1544.400390625, -1667.900390625, 5.5, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(523, 1544.400390625, -1672.099609375, 5.5, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(523, 1544.400390625, -1676.2001953125, 5.5, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(523, 1544.400390625, -1680.2998046875, 5.5, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(523, 1544.400390625, -1684.599609375, 5.5, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        -- Sultan --
        vehicle = createVehicle(560, 1578.599609375, -1710.5, 5.5900001525879, 0, 0, 0, "SAHP")
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        addVehicleSirens(vehicle, 2, 2, false, false, true, false)
        setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
        setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)
        vehicle = createVehicle(560, 1574.400390625, -1710.5, 5.5900001525879, 0, 0, 0, "SAHP")
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        addVehicleSirens(vehicle, 2, 2, false, false, true, false)
        setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
        setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)
        vehicle = createVehicle(560, 1570.400390625, -1710.5, 5.5900001525879, 0, 0, 0, "SAHP")
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        addVehicleSirens(vehicle, 2, 2, false, false, true, false)
        setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
        setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)
        -- Police Maverick --
        vehicle = createVehicle(497, 1551.2177734375, -1643.521484375, 28.577011108398, 0.2691650390625, 359.6923828125, 97.734375, "SAPD") --  Police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(497, 1380.3095703125, -1607.3212890625, 38.484413146973, 0.32958984375, 359.57702636719, 345.38269042969, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        --]]
    -- Alka Prison Heli --
    vehicle = createVehicle(497, 2871.3359375, 64.91015625, 19.92308807373, 355.19348144531, 359.59350585938, 327.21130371094, "STAAT")
    table.insert(policeVehicles, vehicle)
    vioSetElementData(vehicle, "alkaheli", "ja")
    table.insert(frakselfcars[1], vehicle)
    -- DFT-30 --
    vehicle = createAbschleppTruck(2456.1999511719, -2077.3999023438, 14.199999809265, 0, 0, 180) -- SAPD Abschlepptruck
    setAbschleppTruckAsPoliceTruck(vehicle)
    setVehiclePlateText(vehicle, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createAbschleppTruck(2460.7001953125, -2077.3999023438, 14.199999809265, 0, 0, 180) -- SAPD Abschlepptruck
    setAbschleppTruckAsPoliceTruck(vehicle)
    setVehiclePlateText(vehicle, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    -- Towtruck --
    vehicle = createVehicle(525, 2435.6000976563, -2078.6000976563, 13.5, 0, 0, 180, "SAPD") --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(525, 2439.8999023438, -2078.6000976563, 13.5, 0, 0, 180, "SAPD") --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(525, 2446, -2078.6000976563, 13.5, 0, 0, 180, "SAPD") --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)
    vehicle = createVehicle(525, 2450.1005859375, -2078.6000976563, 13.5, 0, 0, 180, "SAPD") --  police
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[1], vehicle)


    ----- Sondereinsatzkommando -----
    -- S.W.A.T. (Wasserwerfer) --
    vehicle = createVehicle(601, 2246.5, 2431, 3, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    -- Enforcer --
    vehicle = createVehicle(427, 2250.8999023438, 2431.3999023438, 3.4000000953674, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    vehicle = createVehicle(427, 2255.3000488281, 2431.3999023438, 3.4000000953674, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    -- F.B.I. Truck --
    vehicle = createVehicle(528, 2240.3000488281, 2442.3000488281, 3.2999999523163, 0, 0, 270, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    vehicle = createVehicle(528, 2240.3000488281, 2447.1000976563, 3.2999999523163, 0, 0, 270, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    -- Police Maverick --
    vehicle = createVehicle(497, 2271.8999023438, 2470.1000976563, 41, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    vehicle = createVehicle(497, 2285.6000976563, 2470.1999511719, 41, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    -- FBI Rancher --
    vehicle = createVehicle(490, 2259.6000976563, 2431, 3.414999961853, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    vehicle = createVehicle(490, 2264, 2431, 3.414999961853, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    vehicle = createVehicle(490, 2268.3999023438, 2431, 3.414999961853, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    vehicle = createVehicle(490, 2272.6999511719, 2431, 3.414999961853, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    vehicle = createVehicle(490, 2277.1000976563, 2431, 3.414999961853, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    -- HPV 1000 (Police-Bike) --
    vehicle = createVehicle(523, 2240.3000488281, 2451.8999023438, 2.8499999046326, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    vehicle = createVehicle(523, 2240.3000488281, 2456.6000976563, 2.8499999046326, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    vehicle = createVehicle(523, 2240.3000488281, 2461.3999023438, 2.8499999046326, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    -- Cheetah --
    vehicle = createVehicle(415, 2294.6999511719, 2430.3999023438, 3.0499999523163, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 2, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
    setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)
    vehicle = createVehicle(415, 2299.1000976563, 2430.3999023438, 3.0499999523163, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 2, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
    setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)
    -- Washington --
    vehicle = createVehicle(421, 2290.3000488281, 2430.8000488281, 3.1549999713898, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 2, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
    setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)
    vehicle = createVehicle(421, 2285.8999023438, 2430.8000488281, 3.1549999713898, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 2, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
    setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)
    -- Boxille Mission --
    vehicle = createVehicle(609, 2240.3999023438, 2437.5, 3.4000000953674, 0, 0, 270, "SA-TTx")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 2, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
    setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)

    ----- National Academy of Military Education -----
    vehicle = createVehicle(520, 279.28125, 1954.705078125, 18.367252349854, 1.8621826171875, 0, 267.60498046875, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    vehicle = createVehicle(520, 280.466796875, 1989.69921875, 18.365074157715, 1.8841552734375, 0, 271.7578125, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    vehicle = createVehicle(520, 277.3359375, 2022.5751953125, 18.368341445923, 1.856689453125, 0, 268.15979003906, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    vehicle = createVehicle(500, 244.9228515625, 1906.7353515625, 19.938255310059, 347.2998046875, 356.39099121094, 74.696044921875, "LEADER")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 6, 2, true, false, true, false)
    setVehicleSirens(vehicle, 1, -0.1, 2.2, -0.2, 255, 0, 0, 255, 255)
    setVehicleSirens(vehicle, 2, 0.1, 2.2, -0.2, 0, 0, 255, 255, 255)
    setVehicleSirens(vehicle, 3, -0.3, 0.4, 0.8, 255, 0, 0, 255, 255)
    setVehicleSirens(vehicle, 4, -0.1, 0.4, 0.8, 0, 0, 255, 255, 255)
    setVehicleSirens(vehicle, 5, 0.1, 0.4, 0.8, 255, 0, 0, 255, 255)
    setVehicleSirens(vehicle, 6, 0.3, 0.4, 0.8, 0, 0, 255, 255, 255)
    vehicle = createVehicle(500, 245.474609375, 1901.421875, 20.091682434082, 348.25012207031, 356.33056640625, 68.57666015625, "PRUEFER")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 6, 2, true, false, true, false)
    setVehicleSirens(vehicle, 1, -0.1, 2.2, -0.2, 255, 0, 0, 255, 255)
    setVehicleSirens(vehicle, 2, 0.1, 2.2, -0.2, 0, 0, 255, 255, 255)
    setVehicleSirens(vehicle, 3, -0.3, 0.4, 0.8, 255, 0, 0, 255, 255)
    setVehicleSirens(vehicle, 4, -0.1, 0.4, 0.8, 0, 0, 255, 255, 255)
    setVehicleSirens(vehicle, 5, 0.1, 0.4, 0.8, 255, 0, 0, 255, 255)
    setVehicleSirens(vehicle, 6, 0.3, 0.4, 0.8, 0, 0, 255, 255, 255)
    vehicle = createVehicle(425, 370.779296875, 1921.68359375, 18.210996627808, 6.39404296875, 359.99450683594, 113.65905761719, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    vehicle = createVehicle(425, 363.57421875, 1954.7568359375, 18.42805480957, 2.2796630859375, 359.62646484375, 111.43981933594, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    vehicle = createVehicle(425, 362.8701171875, 1995.8544921875, 18.52180480957, 359.82971191406, 356.82495117188, 97.218017578125, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    vehicle = createVehicle(432, 213.2119140625, 2006.0107421875, 17.654712677002, 0, 359.86267089844, 235.76110839844, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    setVehicleDamageProof(vehicle, false)
    vehicle = createVehicle(432, 212.4580078125, 1990.765625, 17.651035308838, 0, 0, 233.71765136719, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    setVehicleDamageProof(vehicle, false)
    vehicle = createVehicle(432, 210.302734375, 1976.8740234375, 17.650985717773, 359.99450683594, 0, 236.99157714844, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    setVehicleDamageProof(vehicle, false)
    vehicle = createVehicle(433, 271.658203125, 1833.9326171875, 18.080883026123, 359.92858886719, 0, 163.36120605469, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(433, 264.1025390625, 1833.974609375, 18.08233833313, 359.92858886719, 0, 164.21813964844, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(433, 256.7255859375, 1833.919921875, 18.076374053955, 0, 359.99450683594, 166.27807617188, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(470, 229.919921875, 1898.0537109375, 17.641073226929, 359.79675292969, 0.10986328125, 42.885131835938, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 229.9560546875, 1892.8251953125, 17.639844894409, 359.79125976562, 0.10986328125, 42.8466796875, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 229.677734375, 1888.009765625, 17.639398574829, 359.67590332031, 359.87915039062, 42.747802734375, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 229.1982421875, 1883.1572265625, 17.643228530884, 359.74731445312, 359.98352050781, 43.873901367188, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 229.0048828125, 1878.4619140625, 17.576232910156, 359.59350585938, 359.99450683594, 42.69287109375, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 199.6845703125, 1880.1279296875, 17.639669418335, 359.72534179688, 359.99450683594, 312.80822753906, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 199.0302734375, 1885.0234375, 17.657789230347, 359.76928710938, 359.99450683594, 310.79772949219, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 199.1044921875, 1889.7646484375, 17.640054702759, 359.72534179688, 359.99450683594, 313.15979003906, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 198.771484375, 1894.2099609375, 17.591640472412, 359.55505371094, 0.098876953125, 314.01672363281, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 198.578125, 1898.890625, 17.592487335205, 359.50012207031, 359.98352050781, 314.79675292969, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(430, -525.0595703125, 1636.501953125, -0.10072334855795, 1.9061279296875, 1.0711669921875, 182.757568359369, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(430, -519.0771484375, 1601.8369140625, -0.36475536227226, 0.933837890625, 359.08813476563, 199.17114257869, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(597, 220.484375, 1918.630859375, 17.633609771729, 359.73083496094, 359.99450683594, 180.20324707031, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(597, 211.1572265625, 1919.115234375, 17.633695602417, 359.73083496094, 359.99450683594, 180.37353515625, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(597, 202.2734375, 1918.4345703125, 17.635377883911, 359.73083496094, 359.99450683594, 179.32434082031, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(597, 193.259765625, 1919.2685546875, 17.632621765137, 359.72534179688, 359.99450683594, 179.80773925781, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    --
    vehicle = createVehicle(470, 1584.716796875, -1667.8271484375, 5.8866939544678, 359.68688964844, 359.99450683594, 269.94506835938, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 1584.8603515625, -1671.8251953125, 5.8880019187927, 359.71435546875, 359.95056152344, 269.63195800781, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(598, 172.93359375, 1930.3798828125, 18.00831413269, 0.472412109375, 357.86865234375, 154.61059570312, "SAPD") --  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(598, 178.6298828125, 1930.7548828125, 17.799856185913, 0.50537109375, 357.81921386719, 157.51098632812, "SAPD") --  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(598, 183.77734375, 1930.8603515625, 17.592277526855, 0.4559326171875, 357.81372070312, 158.21960449219, "SAPD") --  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(497, 166.7001953125, 1905.9697265625, 18.686168670654, 359.88464355469, 2.1038818359375, 15.595092773438, "SAPD") --  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(497, 181.3525390625, 1902.4921875, 18.041513442993, 1.944580078125, 2.9058837890625, 6.7510986328125, "SAPD") --  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(563, 363.4619140625, 1894.033203125, 18.349649429321, 3.350830078125, 359.99450683594, 115.48278808594, "SAPD") --  transportheli
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    transportHeliArmy = vehicle

    ----- Las Venturas Police Department (closed) -----
    -- LV Police Car --
    vehicle = createVehicle(598, 2251.8000488281, 2476.6999511719, 10.574999809265, 0, 0, 180, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2256.1000976563, 2476.6999511719, 10.574999809265, 0, 0, 180, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2260.5, 2476.6999511719, 10.574999809265, 0, 0, 180, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2269.1000976563, 2476.6999511719, 10.574999809265, 0, 0, 180, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2273.5, 2476.6999511719, 10.574999809265, 0, 0, 180, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2277.8999023438, 2476.6999511719, 10.574999809265, 0, 0, 180, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2282.3000488281, 2476.6999511719, 10.574999809265, 0, 0, 180, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)

    vehicle = createVehicle(598, 2251.8000488281, 2459.3999023438, 10.574999809265, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2256.1000976563, 2459.3999023438, 10.574999809265, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2260.5, 2459.3999023438, 10.574999809265, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    -- Predator --
    vehicle = createVehicle(430, 2291.9931640625, 514.3828125, 0.23248034715652, 0.406494140625, 356.37451171875, 179.29138183595, "SAPD") --  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(430, 2296.4228515625, 514.3642578125, 0.18538917601109, 2.6641845703125, 0.999755859375, 181.5380859375, "SAPD") --  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    -- HPV 1000 (Police-Bike) --
    vehicle = createVehicle(523, 2269.1000976563, 2459.6000976563, 10.39999961853, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(523, 2273.5, 2459.6000976563, 10.39999961853, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(523, 2277.8000488281, 2459.6000976563, 10.39999961853, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(523, 2282.1999511719, 2459.6000976563, 10.39999961853, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    -- Police Ranger --
    vehicle = createVehicle(599, 2251.6999511719, 2442.8999023438, 11, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(599, 2256.1000976563, 2430.5, 3.4621651172638, 11, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(599, 2260.5, 2431.44921875, 3.4613847732544, 11, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    -- Towtruck --
    vehicle = createVehicle(525, 2295.3000488281, 2443.1000976563, 10.75, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(525, 2290.8999023438, 2443.1000976563, 10.75, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    -- S.W.A.T. (Wasserwerfer) --
    vehicle = createVehicle(601, 2282.1999511719, 2443, 10.60000038147, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    -- F.B.I. Truck --
    vehicle = createVehicle(528, 2277.8000488281, 2443, 10.845000267029, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    -- Enforcer --
    vehicle = createVehicle(427, 2273.3999023438, 2443.3999023438, 10.944999694824, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    vehicle = createVehicle(427, 2269.1000976563, 2443.3999023438, 10.944999694824, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    table.insert(spezpoliceVehicles, vehicle)

    for key, theVehicle in pairs(policeVehicles) do
        vioSetElementData(theVehicle, "Beamtenvehicle", 110);
        vioSetElementData(theVehicle, "tank", 100);
        vioSetElementData(theVehicle, "police-car-id", key);
        table.insert(frakcars, theVehicle)
    end
    for key, theVehicle in pairs(frakselfcars[7]) do
        prepare(theVehicle, 7)
        setVehicleColor(theVehicle, 57, 57, 57, 57)
    end
    for key, theVehicle in pairs(frakselfcars[5]) do
        setVehicleColor(theVehicle, 0, 0, 0, 0)
        prepare(theVehicle, 5)
    end
    for key, theVehicle in pairs(frakselfcars[1]) do
        prepare(theVehicle, 1)
        setVehicleColor(theVehicle, 0, 0, 0, 255, 255, 255)
    end
    for key, theVehicle in pairs(frakselfcars[9]) do
        setVehicleColor(theVehicle, 15, 15, 80, 147, 149, 171)
        prepare(theVehicle, 9)
    end
end
addEventHandler("factionLoadingReady", getResourceRootElement(getThisResource()), createpoliceVehicles)

function isPoliceCar(source)
    local ruck = false
    for theKey, theVehicle in pairs(policeVehicles) do
        if (source == theVehicle) then
            ruck = true
        end
    end
    return ruck
end

function notinPoliceCarEnter(thePlayer, seat, jacked, door)
    if (seat == 0) then
        for theKey, theVehicle in pairs(policeVehicles) do
            if (source == theVehicle) then
                if not (isBeamter(thePlayer)) then
                    showError(thePlayer, "Du kannst das nicht benutzen. Du bist kein Polizist!")
                    cancelEvent()
                end
            end
        end
        if (isBeamter(thePlayer)) then
            for theKey, theVehicle in pairs(spezpoliceVehicles) do
                if (source == theVehicle) then
                    if (vioGetElementData(thePlayer, "fraktionsrang") < 3) then
                        showError(thePlayer, "Du kannst das nicht benutzen. Du hast nicht den nötigen Rang 4 oder höher!")
                        cancelEvent()
                    end
                    for theCarKey, theCarVehicle in pairs(frakselfcars[5]) do
                        if (source == theCarKey) then
                            if (vioGetElementData(thePlayer, "fraktion") ~= 5) then
                                showError(thePlayer, "Du kannst kein SEK Fahrzeug fahren.")
                                cancelEvent()
                            end
                        end
                    end
                end
            end
        end
    end
end

addEventHandler("onVehicleStartEnter", getRootElement(), notinPoliceCarEnter)
