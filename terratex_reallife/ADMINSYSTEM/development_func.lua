function testIntDim(thePlayer)
    outputChatBox("Interior: " .. getElementInterior(thePlayer) .. " Dimension: " .. getElementDimension(thePlayer))
end
addCommandHandler("tid", testIntDim)

function savesm_func(thePlayer, command)
    if (isAdminLevel(thePlayer, 4)) then
        local x, y, z = getElementPosition(thePlayer)

        createMarker(x, y, z, "checkpoint", 2.0, 255, 0, 0)
        createBlip(x, y, z)
        message = "{" .. x .. "," .. y .. "," .. z .. "},"
        save_log("save_m", message)
    end
end
addCommandHandler("sm", savesm_func, false, false)

local presets = {}
function loadDevInt()
    table.insert(presets, { "LV Meat Factory", 965.38, 2159.33, 1010.02, 1 })
    table.insert(presets, { "Ammu-Nation 1", 286.15, -41.54, 1000.57, 1 })
    table.insert(presets, { "Ammu-Nation 2", 285.8, -85.45, 1000.54, 4 })
    table.insert(presets, { "Ammu-Nation 3", 296.92, -111.97, 1000.57, 6 })
    table.insert(presets, { "Ammu-Nation 4", 316.53, -169.61, 998.66, 6 })
    table.insert(presets, { "Ammu-Nation 5 (2 floors)", 309.38, -136.3, 999.60, 7 })
    table.insert(presets, { "Atrium lobby entrance", 1726.19, -1638.01, 19.27, 18 })
    table.insert(presets, { "Atrium lobby exit", 1700.74, -1668.48, 19.22, 18 })
    table.insert(presets, { "Bar 1 (Gaydar Station)", 493.39, -24.92, 999.69, 17 })
    table.insert(presets, { "Bar 2 (Ten Green Bottles)", 501.98, -67.75, 997.84, 11 })
    table.insert(presets, { "Gay Gordo's Barbershop", 418.65, -84.14, 1000.96, 3 })
    table.insert(presets, { "Macisla's Barbershop", 412.02, -54.55, 1000.96, 12 })
    table.insert(presets, { "Reece's Barbershop", 411.63, -23.33, 1000.8, 2 })
    table.insert(presets, { "LS Tattoo Parlour", -204.44, -27.15, 1001.3, 16 })
    table.insert(presets, { "Hemlock Tattoo", -204.44, -9.17, 1001.3, 17 })
    table.insert(presets, { "LV Tattoo Parlour", -204.44, -44.35, 1001.3, 3 })
    table.insert(presets, { "Zip", 161.39, -96.69, 1000.81, 18 })
    table.insert(presets, { "Binco", 207.74, -111.42, 1004.27, 15 })
    table.insert(presets, { "Victim", 227.29, -7.43, 1001.26, 5 })
    table.insert(presets, { "Didier Sachs", 204.33, -168.7, 999.58, 14 })
    table.insert(presets, { "Sub Urban", 203.78, -49.89, 1000.8, 1 })
    table.insert(presets, { "Train Hard", 207.06, -139.81, 1002.52, 3 })
    table.insert(presets, { "RC Zero's Shop", -2241.07, 128.52, 1034.42, 6 })
    table.insert(presets, { "RC Zero's Battlefield", -975.57, 1061.13, 1345.67, 10 })
    table.insert(presets, { "Colonel Fuhrberger's House", 2807.62, -1174.1, 1024.58, 8 })
    table.insert(presets, { "Johnson House", 2496.05, -1692.73, 1013.75, 3 })
    table.insert(presets, { "Big Smoke's Crack Palace", 2541.7, -1304.01, 1024.07, 2 })
    table.insert(presets, { "The Crack Den", 318.57, 1115.21, 1082.98, 5 })
    table.insert(presets, { "Burning Desire House", 2352.34, -1181.25, 1027, 5 })
    table.insert(presets, { "The Casino", 1133.07, -12.77, 999.75, 12 })
    table.insert(presets, { "The Four Dragons Casino", 2018.95, 1017.09, 995.88, 10 })
    table.insert(presets, { "The Caligulas Casino", 2233.91, 1714.73, 1011.38, 1 })
    table.insert(presets, { "Caligulas Casino (Roof access)", 2264.49, 1619.58, 1089.5, 1 })
    table.insert(presets, { "Driving School", -2029.72, -119.55, 1034.17, 3 })
    table.insert(presets, { "Abandoned AC Tower (safehouse)", 422.16, 2536.52, 9.01, 10 })
    table.insert(presets, { "Diner 1", 460.1, -88.43, 998.62, 4 })
    table.insert(presets, { "Diner 2", 459.35, -111.01, 998.72, 5 })
    table.insert(presets, { "Restaurant 1", 452.89, -18.18, 1000.18, 1 })
    table.insert(presets, { "Restaurant 2", 441.98, -49.92, 998.69, 6 })
    table.insert(presets, { "Cafe shop (Catalina)", 681.58, -473.42, 15.59, 1 })
    table.insert(presets, { "Lil Probe Inn (UFO Bar)", -229.03, 1401.23, 26.77, 18 })
    table.insert(presets, { "Liberty City", -750.80, 491.00, 1371.70, 1 })
    table.insert(presets, { "Stadium 1", -1400.21, 106.89, 1032.27, 1 })
    table.insert(presets, { "Stadium 2 (Bloodbowl)", -1394.20, 987.62, 1023.96, 15 })
    table.insert(presets, { "Stadium 3 (Kickstart)", -1410.72, 1591.16, 1052.53, 14 })
    table.insert(presets, { "San Fierro Chunk (cutscene place)", -2015.66, 147.20, 29.31, 14 })
    table.insert(presets, { "Andromada", 315.48, 984.13, 1959.11, 9 })
    table.insert(presets, { "Shamal", 1.61, 34.74, 1199.0, 1 })
    table.insert(presets, { "Inside Track Betting (Chinatown SF)", -2166.01, 643.05, 1057.59, 1 })
    table.insert(presets, { "The Four Dragons Casino (office)", 2004.01, 1027.42, 33.53, 11 })
    table.insert(presets, { "Millie's Bedroom", 347.52, 306.77, 999.15, 6 })
    table.insert(presets, { "Warehouse", 1401.3, -15.5, 1002.9, 1 })
    table.insert(presets, { "Big Bear's apartment", 1527.38, -11.02, 1002.1, 3 })
    table.insert(presets, { "Record Label Hallway", 1037.9, 5.35, 1001.28, 3 })
    table.insert(presets, { "Brothel", 944.8, 1.96, 1000.93, 3 })
    table.insert(presets, { "Brothel 2", 963.0, -47.2, 1001.12, 3 })
    table.insert(presets, { "The Sherman's Dam Generator Hall", -956.6, 1862.23, 9.01, 17 })
    table.insert(presets, { "Budget Inn Motel Room", 447.52, 511.49, 1001.4, 12 })
    table.insert(presets, { "Rusty Brown's - Ring Donuts", 378.29, -188.9, 1000.61, 17 })
    table.insert(presets, { "Francis Int. Airport (Baggage Claim)", -1860.82, 59.74, 1062.14, 14 })
    table.insert(presets, { "Burger Shot", 363.11, -74.88, 1000.55, 10 })
    table.insert(presets, { "Cluckin' Bell", 365.67, -11.61, 1000.87, 9 })
    table.insert(presets, { "Well Stacked Pizza Co.", 372.35, -133.55, 1000.45, 5 })
    table.insert(presets, { "Inside Track Betting", 834.82, 7.42, 1003.18, 3 })
    table.insert(presets, { "Los Santos Gym", 772.11, -5, 999.69, 5 })
    table.insert(presets, { "San Fierro Gym", 774.21, -50.02, 999.69, 6 })
    table.insert(presets, { "Las Venturas Gym", 773.58, -78.2, 999.69, 7 })
    table.insert(presets, { "Madd Dogg's Mansion 1", 1260.58, -785.31, 1090.96, 5 })
    table.insert(presets, { "Madd Dogg's Mansion 2", 1299.08, -796.83, 1083.03, 5 })
    table.insert(presets, { "Jefferson Motel", 2214.34, -1150.51, 1024.8, 15 })
    table.insert(presets, { "Las Venturas Planning Dep.", 390.87, 173.81, 1007.39, 3 })
    table.insert(presets, { "LSPD HQ", 246.78, 62.2, 1002.64, 6 })
    table.insert(presets, { "SFPD HQ", 246.62, 112.1, 1003.2, 10 })
    table.insert(presets, { "LVPD HQ", 238.66, 139.35, 1002.05, 3 })
    table.insert(presets, { "Police Station 1", 322.72, 306.4, 999.11, 5 })
    table.insert(presets, { "Sex Shop", -100.33, -24.92, 999.74, 3 })
    table.insert(presets, { "Big Spread Ranch", 1212.02, -25.86, 1000.09, 3 })
    table.insert(presets, { "The Pig Pen", 1204.81, -12.79, 1000.09, 2 })
    table.insert(presets, { "Jizzy's Pleasure Domes", -2661.01, 1417.74, 921.31, 3 })
    table.insert(presets, { "Safe House 1", 223.04, 1287.26, 1081.2, 1 })
    table.insert(presets, { "Safe House 2", 260.98, 1284.55, 1079.3, 4 })
    table.insert(presets, { "Safe House 3", 140.18, 1366.58, 1082.97, 5 })
    table.insert(presets, { "Safe House 4", 82.95, 1322.44, 1082.89, 9 })
    table.insert(presets, { "Safe House 5", -283.55, 1470.98, 1083.45, 15 })
    table.insert(presets, { "Safe House 6", -260.6, 1456.62, 1083.45, 4 })
    table.insert(presets, { "Safe House 7", -42.58, 1405.61, 1083.45, 8 })
    table.insert(presets, { "Safe House 8", -68.69, 1351.97, 1079.28, 6 })
    table.insert(presets, { "Safe House 9", 2333.11, -1077.1, 1048.04, 6 })
    table.insert(presets, { "Safe House 10", 2233.8, -1115.36, 1049.91, 5 })
    table.insert(presets, { "Safe House 11", 2365.3, -1134.92, 1049.91, 8 })
    table.insert(presets, { "Safe House 12", 2282.91, -1140.29, 1049.91, 11 })
    table.insert(presets, { "Safe House 13", 2196.79, -1204.35, 1048.05, 6 })
    table.insert(presets, { "Safe House 14", 2270.39, -1210.45, 1046.57, 10 })
    table.insert(presets, { "Safe House 15", 2308.79, -1212.88, 1048.03, 6 })
    table.insert(presets, { "Safe House 16", 2217.54, -1076.29, 1049.52, 1 })
    table.insert(presets, { "Safe House 17", 2237.59, -1080.87, 1048.07, 2 })
    table.insert(presets, { "Safe House 18", 2317.82, -1026.75, 1049.21, 9 })
    table.insert(presets, { "24/7 shop 1", -30.95, -91.71, 1002.55, 18 })
    table.insert(presets, { "24/7 shop 2", -26.69, -57.81, 1002.55, 6 })
    table.insert(presets, { "24/7 shop 3", -27.31, -31.38, 1002.55, 4 })
end
addEventHandler("onResourceStart", resourceRoot, loadDevInt)

function devin_func(thePlayer, command, nr)
    if (isAdminLevel(thePlayer, 4)) then
        local nrr = tonumber(nr)
        setElementDimension(thePlayer, 1)
        setElementInterior(thePlayer, presets[nrr][5], presets[nrr][2], presets[nrr][3], presets[nrr][4])
        setElementPosition(thePlayer, presets[nrr][2], presets[nrr][3], presets[nrr][4] + 1)
        outputChatBox(presets[nrr][1], thePlayer)
    end
end
addCommandHandler("devin", devin_func, false, false)

function savein_func(thePlayer, Command, ...)
    if (isAdminLevel(thePlayer, 4)) then
        local besch = table.concat({ ... }, " ")
        local message = ""
        local px, py, pz = getElementPosition(thePlayer)
        local int = getElementInterior(thePlayer)
        local rx, ry, rz = getElementRotation(thePlayer)
        message = "INSERT INTO IraumDB (Beschreibung,CoordX,CoordY,CoordZ,CoordRZ,Interior) VALUES ('" .. besch .. "','" .. px .. "','" .. py .. "','" .. pz .. "','" .. rz .. "','" .. int .. "');\n"
        save_log("save_ir", message)
    end
end
addCommandHandler("irs", savein_func, false, false)

function save_func(thePlayer, command, ...)
    if (isAdminLevel(thePlayer, 4)) then
        local kommentar = table.concat({ ... }, " ")
        local message = ""
        if not (isPedInVehicle(thePlayer)) then
            local x, y, z = getElementPosition(thePlayer)
            local rx = getPedRotation(thePlayer)
            message = "ped: " .. x .. "," .. y .. "," .. z .. "," .. rx .. " // " .. kommentar

        else
            local vehid = getPedOccupiedVehicle(thePlayer)
            local vehmod = getElementModel(vehid)
            local x, y, z = getElementPosition(vehid)
            local rx, ry, rz = getVehicleRotation(vehid)
            message = "vehicle: createVehicle(" .. vehmod .. "," .. x .. "," .. y .. "," .. z .. "," .. rx .. "," .. ry .. "," .. rz .. ")    //  " .. kommentar
        end

        save_log("save", message)
    end
end
addCommandHandler("save", save_func, false, false)


function goto_coord_func(thePlayer, command, posx, posy, posz, int)
    if (isAdminLevel(thePlayer, 3)) then
        if (posx and not (posz)) then
            local ergebnis = getStringComponentsDelimited(posx, ",")
            if (posy) then
                int = posy
            end
            posx = ergebnis[1]
            posy = ergebnis[2]
            posz = ergebnis[3]
        end
        setElementInterior(thePlayer, int)
        setElementPosition(thePlayer, posx, posy, posz)
    end
end
addCommandHandler("gotocoord", goto_coord_func, false, false)

function dim_func(thePlayer, cmd, int)
    if (isAdminLevel(thePlayer, 0)) then
        setElementDimension(thePlayer, tonumber(int))
    end
end
addCommandHandler("dim", dim_func, false, false)











