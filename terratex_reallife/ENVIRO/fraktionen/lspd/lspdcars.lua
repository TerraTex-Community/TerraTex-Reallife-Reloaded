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
        local vehicle = createVehicle(427, 1534.6999511719, -1645.4000244141, 6, 0, 0, 180, "SAPD")
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        table.insert(spezpoliceVehicles, vehicle)
        vehicle = createVehicle(427, 1538.8000488281, -1645.4000244141, 6, 0, 0, 180, "SAPD")
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        table.insert(spezpoliceVehicles, vehicle)
        -- S.W.A.T. (Wasserwerfer) --
        vehicle = createVehicle(601, 1558.8000488281, -1710.1999511719, 5.6999998092651, 0, 0, 0, "SAPD") --  SAPD Spez
        table.insert(policeVehicles, vehicle)
        table.insert(spezpoliceVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        -- LS Police Car --
        vehicle = createVehicle(596, 1595.5, -1710, 5.5999999046326, 0, 0, 0, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(596, 1591.5, -1710, 5.5999999046326, 0, 0, 0, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(596, 1587.4000244141, -1710, 5.5999999046326, 0, 0, 0, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(596, 1583.4000244141, -1710, 5.5999999046326, 0, 0, 0, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(596, 1578.5999755859, -1710, 5.5999999046326, 0, 0, 0, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(596, 1574.4000244141, -1710, 5.5999999046326, 0, 0, 0, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(596, 1570.3000488281, -1710, 5.5999999046326, 0, 0, 0, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        -- HPV 1000 (Police-Bike) --
        vehicle = createVehicle(523, 1544.5, -1651, 5.5, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(523, 1544.5, -1655.0999755859, 5.5, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(523, 1544.5, -1659.0999755859, 5.5, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(523, 1544.5, -1663.1999511719, 5.5, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        -- Police Maverick --
        vehicle = createVehicle(497, 1551.2177734375, -1643.521484375, 28.577011108398, 0.2691650390625, 359.6923828125, 97.734375, "SAPD")
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(497, 1380.3095703125, -1607.3212890625, 38.484413146973, 0.32958984375, 359.57702636719, 345.38269042969, "SAPD")
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        -- Police Rancher --
        vehicle = createVehicle(599, 1601.0999755859, -1704.1999511719, 6.0999999046326, 0, 0, 90, "SAPD")
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(599, 1601.0999755859, -1700.0999755859, 6.0999999046326, 0, 0, 90, "SAPD")
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(599, 1601.0999755859, -1696.0999755859, 6.0999999046326, 0, 0, 90, "SAPD")
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(599, 1601.0999755859, -1692, 6.0999999046326, 0, 0, 90, "SAPD")
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        -- Towtruck --
        vehicle = createVehicle(525, 1601.4000244141, -1688, 5.8000001907349, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)
        vehicle = createVehicle(525, 1601.4000244141, -1683.9000244141, 5.8000001907349, 0, 0, 90, "SAPD") --  police
        table.insert(policeVehicles, vehicle)
        table.insert(frakselfcars[1], vehicle)

    ----- Abschlepphof -----
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
    -- Hydra --
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
    -- Mesa --
    vehicle = createVehicle(500, 282.10000610352, 1882.6999511719, 17.729999542236, 0, 0, 90, "LEADER")
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
    vehicle = createVehicle(500, 282.10000610352, 1877.6999511719, 17.729999542236, 0, 0, 90, "PRUEFER")
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
    vehicle = createVehicle(500, 282.10000610352, 1872.5, 17.729999542236, 0, 0, 90, "PRUEFER")
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
    -- Hunter --
    vehicle = createVehicle(425, 333.5, 1983.7001953125, 18.39999961853, 0, 0, 90, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    vehicle = createVehicle(425, 333.5, 1965.099609375, 18.39999961853, 0, 0, 90, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    table.insert(spezpoliceVehicles, vehicle)
    -- Rhino --
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
    -- Barracks --
    vehicle = createVehicle(433, 131.5, 1835.099609375, 18.10000038147, 0, 0, 90, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(433, 131.5, 1840.7998046875, 18.10000038147, 0, 0, 90, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(433, 131.5, 1846.400390625, 18.10000038147, 0, 0, 90, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    -- Enforcer --
    vehicle = createVehicle(427, 131.7001953125, 1852.5, 17.799999237061, 0, 0, 90, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(427, 131.7001953125, 1857.2001953125, 17.799999237061, 0, 0, 90, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    -- Patriot // Area 51 --
    vehicle = createVehicle(470, 191.400390625, 1919.5, 17.635000228882, 0, 0, 180, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 195.400390625, 1919.5, 17.635000228882, 0, 0, 180, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 200.2998046875, 1919.5, 17.635000228882, 0, 0, 180, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 204.400390625, 1919.5, 17.635000228882, 0, 0, 180, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 209.2998046875, 1919.5, 17.635000228882, 0, 0, 180, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 213.5, 1919.5, 17.635000228882, 0, 0, 180, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 218.2998046875, 1919.5, 17.635000228882, 0, 0, 180, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 222.400390625, 1919.5, 17.635000228882, 0, 0, 180, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    -- Predator --
    vehicle = createVehicle(430, -525.0595703125, 1636.501953125, -0.10072334855795, 1.9061279296875, 1.0711669921875, 182.757568359369, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(430, -519.0771484375, 1601.8369140625, -0.36475536227226, 0.933837890625, 359.08813476563, 199.17114257869, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    -- Police SF --
    vehicle = createVehicle(597, 204.60000610352, 1860.0999755859, 12.89999961853, 0, 0, 270, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(597, 204.60000610352, 1864.1999511719, 12.89999961853, 0, 0, 270, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    -- Police Ranger --
    vehicle = createVehicle(599, 281.29998779297, 1862.6999511719, 17.799999237061, 0, 0, 90, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(599, 281.29998779297, 1857.5999755859, 17.799999237061, 0, 0, 90, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(599, 281.29998779297, 1852.5999755859, 17.799999237061, 0, 0, 90, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    -- Police Maverick --
    vehicle = createVehicle(497, 225.5, 1881.2998046875, 17.655000686646, 0, 0, 0, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    vehicle = createVehicle(497, 202.2001953125, 1881.2998046875, 17.655000686646, 0, 0, 0, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    -- Raindance
    vehicle = createVehicle(563, 361.7001953125, 1944.2001953125, 18.454999923706, 0, 0, 90, "NAME") --  transportheli
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    transportHeliArmy = vehicle
    vehicle = createVehicle(563, 361.7001953125, 1931.2001953125, 18.454999923706, 0, 0, 90, "NAME") --  transportheli
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    transportHeliArmy = vehicle
    -- Cargobob --
    vehicle = createVehicle(548, 365.400390625, 1983.5, 22.375, 0, 0, 90, "NAME") --  transportheli
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    transportHeliArmy = vehicle
    vehicle = createVehicle(548, 365.400390625, 1964.7998046875, 22.375, 0, 0, 90, "NAME") --  transportheli
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    transportHeliArmy = vehicle
    -- Patriot // LVPD --
    vehicle = createVehicle(470, 2320.6000976563, 2459.1999511719, 10.800000190735, 0, 0, 90, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 2320.6000976563, 2455, 10.800000190735, 0, 0, 90, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    -- Patriot // LSPD --
    vehicle = createVehicle(470, 1604.0999755859, -1627, 13.5, 0, 0, 90, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)
    vehicle = createVehicle(470, 1604.0999755859, -1630.9000244141, 13.5, 0, 0, 90, "NAME")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[7], vehicle)
    removeVehicleSirens(vehicle)
    addVehicleSirens(vehicle, 4, 2, false, false, true, false)
    setVehicleSirens(vehicle, 1, 0, 2.2, 0, 255, 0, 0, 255, 198.9)
    setVehicleSirens(vehicle, 2, 0, 2.2, 0, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 3, 0, 0.8, 0.4, 0, 0, 255, 255, 200)
    setVehicleSirens(vehicle, 4, 0, 0.8, 0.4, 255, 0, 0, 255, 200)

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
    vehicle = createVehicle(599, 2256.1000976563, 2442.8999023438, 11, 0, 0, 0, "SAPD")
    table.insert(policeVehicles, vehicle)
    table.insert(frakselfcars[9], vehicle)
    vehicle = createVehicle(599, 2260.5, 2442.8999023438, 11, 0, 0, 0, "SAPD")
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
