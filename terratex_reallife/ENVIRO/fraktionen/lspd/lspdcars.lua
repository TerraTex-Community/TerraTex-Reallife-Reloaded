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
    -- Enforcer --
    local vehicle = createVehicle(427, 1526.5, -1645.2001953125, 6, 0, 0, 180, "SAPD")
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
    vehicle = createVehicle(601, 1985, 2128, 10.585, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    -- Enforcer --
    vehicle = createVehicle(427, 1988.9000244141, 2128.1999511719, 10.935000419617, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    vehicle = createVehicle(427, 1992.6999511719, 2128.1999511719, 10.935000419617, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    -- FBI Truck --
    vehicle = createVehicle(528, 1996.5, 2128.1000976563, 10.835000038147, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    vehicle = createVehicle(528, 2000.1999511719, 2128.1000976563, 10.835000038147, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    -- Police Maverick --
    vehicle = createVehicle(497, 1948.9000244141, 2186.75, 24.700000762939, 0, 0, 270, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    vehicle = createVehicle(497, 1948.9000244141, 2169.05, 24.700000762939, 0, 0, 270, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    -- FBI Rancher // LV --
    vehicle = createVehicle(490, 2003.9000244141, 2128.3000488281, 10.965000152588, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    vehicle = createVehicle(490, 2007.6999511719, 2128.3000488281, 10.965000152588, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    vehicle = createVehicle(490, 2011.4000244141, 2128.3000488281, 10.965000152588, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    vehicle = createVehicle(490, 2015.0999755859, 2128.3000488281, 10.965000152588, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    vehicle = createVehicle(490, 2018.6999511719, 2128.3000488281, 10.965000152588, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    -- FBI Rancher // LS --
    --vehicle = createVehicle(490, 1585.3000488281, -1667.5, 6.03, 0, 0, 270, "SEK")
    --table.insert(policeVehicles, vehicle)
    --table.insert(frakselfcars[5], vehicle)
    -- Cheetah --
    vehicle = createVehicle(415, 1977.1999511719, 2126.8000488281, 10.60000038147, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 2, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
    setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)
    vehicle = createVehicle(415, 1980.4000244141, 2126.8000488281, 10.60000038147, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 2, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
    setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)
    -- Washington // LV --
    vehicle = createVehicle(421, 1972.9000244141, 1972.9000244141, 10.710000038147, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 2, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
    setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)
    vehicle = createVehicle(421, 1969.6999511719, 1972.9000244141, 10.710000038147, 0, 0, 0, "SEK")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[5], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 2, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
    setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)
    -- Washington // LS --
    --vehicle = createVehicle(421, 1585.3000488281, -1671.6999511719, 5.7750000953674, 0, 0, 270, "SEK")
    --table.insert(policeVehicles, vehicle)
    --table.insert(frakselfcars[5], vehicle)
    --removeVehicleSirens(vehicle)
    --addVehicleSirens(vehicle, 2, 2, false, false, true, false)
    --setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
    --setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)
    -- Boxille Mission --
    vehicle = createVehicle(609, 1973.0999755859, 2152.3999023438, 10.935000419617, 0, 0, 240, "SA-TTx")
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
    vehicle = createVehicle(598, 2277.2509765625, 2431.3212890625, 3.0171566009521, 359.6044921875, 359.99450683594, 359.53857421875, "SAPD") --  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2272.7119140625, 2430.9736328125, 3.0196599960327, 359.60998535156, 0, 0.010986328125, "SAPD") -- lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2268.232421875, 2430.5927734375, 3.0190379619598, 359.60998535156, 359.99450683594, 0.4229736328125, "SAPD") --  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2264.0107421875, 2430.9755859375, 3.0165886878967, 359.6044921875, 0, 0.010986328125, "SAPD") --  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(430, 2291.9931640625, 514.3828125, 0.23248034715652, 0.406494140625, 356.37451171875, 179.29138183595, "SAPD") --  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(430, 2296.4228515625, 514.3642578125, 0.18538917601109, 2.6641845703125, 0.999755859375, 181.5380859375, "SAPD") --  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2259.5087890625, 2430.4755859375, 3.0190734863281, 359.60998535156, 0, 0.615234375, "SAPD") --  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2255.2705078125, 2430.427734375, 3.0203061103821, 359.61547851563, 0, 359.22546386719, "SAPD") --  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2250.755859375, 2431.0771484375, 3.0218994617462, 359.62097167969, 359.99450683594, 359.43420410156, "SAPD") -- lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2246.49609375, 2430.927734375, 3.0186352729797, 359.60998535156, 359.99450683594, 359.80224609375, "SAPD") -- lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2240.177734375, 2437.2255859375, 3.0224223136902, 359.62097167969, 0, 271.0546875, "SAPD") --lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(598, 2240.060546875, 2442.1884765625, 3.0242650508881, 359.62646484375, 0, 268.61022949219, "SAPD") -- lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(523, 2284.8349609375, 2430.544921875, 2.8411757946014, 359.62646484375, 0, 359.97253417969, "SAPD") -- lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(523, 2287.2001953125, 2431.79296875, 2.8401181697845, 359.59350585938, 0, 2.92236328125, "SAPD") -- lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(523, 2289.326171875, 2431.875, 2.8439378738403, 359.63745117188, 0, 359.6044921875, "SAPD") -- lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(523, 2291.4423828125, 2432.41796875, 2.8435256481171, 359.63195800781, 0, 358.53332519531, "SAPD") --d
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(599, 2294.75390625, 2431.314453125, 3.4566819667816, 0.538330078125, 359.99450683594, 359.6923828125, "SAPD") --
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(599, 2299.07421875, 2430.5, 3.4621651172638, 0.5218505859375, 359.99450683594, 1.0107421875, "SAPD") --
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(599, 2303.6171875, 2431.44921875, 3.4613847732544, 0.5218505859375, 359.99450683594, 359.736328125, "SAPD") -- lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(599, 2307.7216796875, 2430.5224609375, 3.4625604152679, 0.516357421875, 0.0054931640625, 359.92309570313, "SAPD") -- lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(599, 2312.16015625, 2430.1796875, 3.4580566883087, 0.5328369140625, 359.99450683594, 358.92333984375, "SAPD") --//  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(497, 2271.8999023438, 2470.1000976563, 41, 0, 0, 0, "SAPD") --//  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(497, 2285.6000976563, 2470.1999511719, 41, 0, 0, 0, "SAPD") --//  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(525, 2239.419921875, 2447.1123046875, 3.145247220993, 358.03894042969, 0, 269.89562988281, "SAPD") --//  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(525, 2240.44921875, 2451.865234375, 3.1482298374176, 358.08837890625, 0, 269.93957519531, "SAPD") --//  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(525, 2240.1005859375, 2456.49609375, 3.1592817306519, 358.26965332031, 0, 270.03295898438, "SAPD") --//  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(525, 2240.1904296875, 2461.3251953125, 3.1484417915344, 358.09387207031, 0, 268.84094238281, "SAPD") --//  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(525, 2240.1748046875, 2466.240234375, 3.1644797325134, 358.35754394531, 0, 268.60473632813, "SAPD") --//  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(601, 2297.60546875, 2460.4267578125, 3.032190322876, 0.010986328125, 0, 269.93408203125, "SAPD") --//  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    vehicle = createVehicle(427, 2297.75390625, 2455.951171875, 3.4052803516388, 0.0164794921875, 0, 270.97229003906, "SAPD") --//  lvpd
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    for key, theVehicle in pairs(policeVehicles) do
        vioSetElementData(theVehicle, "Beamtenvehicle", 110);
        vioSetElementData(theVehicle, "tank", 100);
        vioSetElementData(theVehicle, "police-car-id", key);
        table.insert(frakcars, theVehicle)
        setVehiclePlateText(theVehicle, getVehiclePlateText(theVehicle) .. "-" .. key);
    end
    for key, theVehicle in pairs(frakselfcars[7]) do
        setVehicleColor(theVehicle, 57, 57, 57, 57)
        prepare(theVehicle, 7)
    end
    for key, theVehicle in pairs(frakselfcars[5]) do
        setVehicleColor(theVehicle, 0, 0, 0, 0)
        prepare(theVehicle, 5)
    end
    for key, theVehicle in pairs(frakselfcars[1]) do
        prepare(theVehicle, 1)
    end
    for key, theVehicle in pairs(frakselfcars[9]) do
        --setVehicleColor (theVehicle,35,35,90,147,149,171)
        setVehicleColor(theVehicle, 15, 15, 80, 147, 149, 171)
        prepare(theVehicle, 9)
    end
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createpoliceVehicles)

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
