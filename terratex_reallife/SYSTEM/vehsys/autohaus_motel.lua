autohausVehicles = {}
autohaustimer = {}
autohausspawns = {
    { 2126.619140625, -1140.4541015625, 24.910829544067, 4.7955322265625, 358.32458496094, 358.62121582031 },
    { 438.169921875, -1339.1220703125, 14.766979217529, 0.2471923828125, 354.27062988281, 303.62365722656 },
    { 1714.029296875, 1299.4951171875, 10.553471565247, 0.0604248046875, 0.1153564453125, 269.90661621094 },
    { 1086.232421875, 2396.1416015625, 10.464502334595, 359.57153320313, 359.97802734375, 87.379760742188 },
    { 1945.5, -2316.3, 16.7, 0, 0, 184 },
    { 802.79998779297, -2077.1999511719, 1.7999999523163, 0, 0, 183 },
    { 2811.6999511719, -1578.6999511719, 10.89999961853, 0, 0, 268 },
    { 552, -1276.3000488281, 17.10000038147, 0, 0, 320 }
}

rabattCars = {}
rabattCarsReduce = {}

function createBuyCars()
    autohaustimer = { 0, 0, 0, 0, 0, 0 }
    -- Billigautohändler
    --PreisÄndern: table.insert Zeile letzter Wert
    local vehicle = createVehicle(418, 2122.2900390625, -1157.87109375, 24.226362228394, 357.15454101562, 2.2576904296875, 0.3076171875)
    table.insert(autohausVehicles, { vehicle, "Moonbeam", 1, 4160.00 }) --E
    vehicle = createVehicle(401, 2118.19140625, -1157.03515625, 24.036399841309, 356.02844238281, 0.9942626953125, 322.80578613281)
    table.insert(autohausVehicles, { vehicle, "Bravura", 1, 2400.00 }) --E
    vehicle = createVehicle(404, 2118.5439453125, -1152.3671875, 23.88849067688, 356.4404296875, 5.8721923828125, 320.74035644531)
    table.insert(autohausVehicles, { vehicle, "Perenniel", 1, 1500.00 }) --E
    vehicle = createVehicle(445, 2118.6103515625, -1148.3916015625, 24.247434616089, 1.285400390625, 5.174560546875, 322.67395019531)
    table.insert(autohausVehicles, { vehicle, "Admiral", 1, 2200.00 }) --E
    vehicle = createVehicle(458, 2118.4677734375, -1144.7822265625, 24.522994995117, 1.34033203125, 5.0592041015625, 322.31140136719)
    table.insert(autohausVehicles, { vehicle, "Solair", 1, 2600.00 }) --E
    vehicle = createVehicle(475, 2118.7080078125, -1140.796875, 24.735038757324, 1.043701171875, 4.9713134765625, 320.42175292969)
    table.insert(autohausVehicles, { vehicle, "Sabre", 1, 2700.00 }) --E
    vehicle = createVehicle(436, 2118.857421875, -1136.9931640625, 24.987487792969, 2.054443359375, 2.0489501953125, 320.91613769531)
    table.insert(autohausVehicles, { vehicle, "Previon", 1, 3000.00 }) --E
    vehicle = createVehicle(549, 2118.7109375, -1133.6298828125, 24.952672958374, 2.515869140625, 358.03894042969, 319.15832519531)
    table.insert(autohausVehicles, { vehicle, "Tampa", 1, 975.00 }) --E
    vehicle = createVehicle(410, 2134.95703125, -1126.18359375, 25.344995498657, 359.92309570312, 2.4224853515625, 81.842651367188)
    table.insert(autohausVehicles, { vehicle, "Manana", 1, 3250.00 }) --E
    vehicle = createVehicle(419, 2135.5634765625, -1129.0029296875, 25.415901184082, 359.91760253906, 2.4114990234375, 83.040161132812)
    table.insert(autohausVehicles, { vehicle, "Esperanto", 1, 1800.00 }) --E
    vehicle = createVehicle(492, 2135.697265625, -1131.58203125, 25.462408065796, 359.736328125, 0.2911376953125, 83.534545898438)
    table.insert(autohausVehicles, { vehicle, "Greenwood", 1, 3200.00 }) --E
    vehicle = createVehicle(546, 2135.77734375, -1134.0810546875, 25.43408203125, 359.76928710938, 0.274658203125, 83.688354492188)
    table.insert(autohausVehicles, { vehicle, "Intruder", 1, 5000.00 }) --E
    vehicle = createVehicle(547, 2135.701171875, -1136.6962890625, 25.503540039062, 359.72534179688, 356.59973144531, 83.754272460938)
    table.insert(autohausVehicles, { vehicle, "Primo", 1, 3900.00 }) --E
    vehicle = createVehicle(426, 2135.662109375, -1139.1611328125, 25.103664398193, 359.61547851562, 353.44116210938, 84.446411132812)
    table.insert(autohausVehicles, { vehicle, "Premier", 1, 4800.00 }) --E
    vehicle = createVehicle(585, 2135.7021484375, -1141.685546875, 24.885721206665, 0.17578125, 353.57849121094, 84.803466796875)
    table.insert(autohausVehicles, { vehicle, "Emperor", 1, 4200.00 }) --E
    vehicle = createVehicle(516, 2135.4833984375, -1144.1767578125, 24.651636123657, 359.48364257812, 353.56201171875, 86.204223632812)
    table.insert(autohausVehicles, { vehicle, "Nebula", 1, 10500.00 }) --E
    vehicle = createVehicle(529, 2135.2529296875, -1146.82421875, 24.466346740723, 0.5712890625, 353.41918945312, 83.133544921875)
    table.insert(autohausVehicles, { vehicle, "Willard", 1, 4300.00 }) -- E
    vehicle = createVehicle(540, 2135.1318359375, -1149.73046875, 24.074016571045, 0.252685546875, 353.40270996094, 81.820678710938)
    table.insert(autohausVehicles, { vehicle, "Vincent", 1, 6700.00 }) --E
    vehicle = createVehicle(526, 2119.10546875, -1129.1201171875, 25.039896011353, 1.4447021484375, 358.25866699219, 317.37854003906)
    table.insert(autohausVehicles, { vehicle, "Fortune", 1, 3750.00 }) --E
    vehicle = createVehicle(542, 2119.138671875, -1125.2734375, 25.103847503662, 2.3291015625, 358.6376953125, 317.58728027344)
    table.insert(autohausVehicles, { vehicle, "Clover", 1, 800.00 }) -- E
    vehicle = createVehicle(491, 2126.76171875, -1152.7236328125, 23.775543212891, 0.68115234375, 1.373291015625, 313.37951660156)
    table.insert(autohausVehicles, { vehicle, "Virgo", 1, 7200.00 }) --E
    vehicle = createVehicle(527, 2119.1435546875, -1122.166015625, 25.080596923828, 0.6646728515625, 358.49487304688, 314.59899902344)
    table.insert(autohausVehicles, { vehicle, "Cadrona", 1, 3500.00 }) --E



    --Autohaus Nummer 4
    -- Sportautohändler
    vehicle = createVehicle(560, 1110.10546875, 2390.1123046875, 16.812082290649, 340.36193847656, 1.3787841796875, 117.78442382813)
    table.insert(autohausVehicles, { vehicle, "Sultan", 4, 148000.00 })
    vehicle = createVehicle(562, 1105.0703125, 2356.7822265625, 10.658887863159, 359.65942382813, 359.99450683594, 36.1669921875)
    table.insert(autohausVehicles, { vehicle, "Elegy", 4, 90000.00 })
    vehicle = createVehicle(559, 1113.7529296875, 2358.90625, 10.653014183044, 359.93408203125, 359.912109375, 96.465454101563)
    table.insert(autohausVehicles, { vehicle, "Jester", 4, 96000.00 })
    vehicle = createVehicle(541, 1108.0927734375, 2377.701171875, 10.628761291504, 359.51110839844, 359.99450683594, 63.989868164063)
    table.insert(autohausVehicles, { vehicle, "Bullet", 4, 165550.00 })
    vehicle = createVehicle(496, 1107.8994140625, 2398.7998046875, 10.732326507568, 0.0274658203125, 359.99450683594, 135.99426269531)
    table.insert(autohausVehicles, { vehicle, "Blista Compact", 4, 7500.00 })
    vehicle = createVehicle(477, 1110.0966796875, 2398.697265625, 16.343437194824, 359.73083496094, 0.0164794921875, 131.99523925781)
    table.insert(autohausVehicles, { vehicle, "ZR-350", 4, 95000.00 })
    vehicle = createVehicle(587, 1103.2294921875, 2398.46484375, 10.728410720825, 359.66491699219, 0, 181.36779785156)
    table.insert(autohausVehicles, { vehicle, "Euros", 4, 78993.00 })
    vehicle = createVehicle(429, 1109.80078125, 2352.796875, 16.264942169189, 359.99450683594, 359.99450683594, 305.96374511719)
    table.insert(autohausVehicles, { vehicle, "Banshee", 4, 195000.00 })
    vehicle = createVehicle(603, 1113.2734375, 2366.61328125, 11.599946022034, 340.3125, 359.296875, 60.106201171875)
    table.insert(autohausVehicles, { vehicle, "Phoenix", 4, 87500.00 })
    vehicle = createVehicle(558, 1115.1962890625, 2353.69921875, 10.808901786804, 359.79125976563, 359.98901367188, 109.98962402344)
    table.insert(autohausVehicles, { vehicle, "Uranus", 4, 125000.00 })
    vehicle = createVehicle(602, 1109.1396484375, 2394.447265625, 10.809054374695, 0.10986328125, 0.0384521484375, 143.40454101563)
    table.insert(autohausVehicles, { vehicle, "Alpha", 4, 85000.00 })
    vehicle = createVehicle(451, 1118.9970703125, 2360.7998046875, 16.324230194092, 359.50012207031, 359.90661621094, 81.996459960938)
    table.insert(autohausVehicles, { vehicle, "Turismo", 4, 310000.00 })
    vehicle = createVehicle(415, 1116.0986328125, 2367.298828125, 16.373405456543, 0.17578125, 359.89013671875, 31.9921875)
    table.insert(autohausVehicles, { vehicle, "Cheetah", 4, 260000.00 })
    vehicle = createVehicle(402, 1104.501953125, 2366.6728515625, 10.826894760132, 359.96154785156, 359.99450683594, 37.139282226563)
    table.insert(autohausVehicles, { vehicle, "Buffalo", 4, 110000.00 })
    vehicle = createVehicle(411, 1117.8486328125, 2353.4345703125, 17.150241851807, 340.70251464844, 0.6317138671875, 63.775634765625)
    table.insert(autohausVehicles, { vehicle, "Infernus", 4, 465000.00 })
    vehicle = createVehicle(480, 1111.076171875, 2384.4208984375, 16.356704711914, 359.77478027344, 0, 149.4580078125)
    table.insert(autohausVehicles, { vehicle, "Comet", 4, 150000.00 })
    vehicle = createVehicle(506, 1109.4130859375, 2388.6728515625, 10.695421218872, 359.94506835938, 359.99450683594, 148.48571777344)
    table.insert(autohausVehicles, { vehicle, "Super GT", 4, 140000.00 })

    -- Flugzeughaus
    vehicle = createVehicle(513, 2797.1000976563, -1542.6999511719, 11.5, 0, 0, 216)
    table.insert(autohausVehicles, { vehicle, "Stuntplane", 5, 590000.00 })
    vehicle = createVehicle(469, 1906.4, -2321.8, 13.6, 0, 0, 270); --Sparrow
    table.insert(autohausVehicles, { vehicle, "Sparrow", 5, 120000.00 })
    vehicle = createVehicle(487, 1900.7, -2313.2, 13.8, 0, 0, 272); --Maverick
    table.insert(autohausVehicles, { vehicle, "Maverick", 5, 620000.00 })
    vehicle = createVehicle(511, 1934.3, -2257.7, 15.1, 0, 0, 180); --Beagle
    table.insert(autohausVehicles, { vehicle, "Beagle", 5, 700000.00 })
    vehicle = createVehicle(519, 1908.3, -2259.7, 14.5, 0, 0, 212); --Shamal
    table.insert(autohausVehicles, { vehicle, "Shamal", 5, 2000000.00 })
    vehicle = createVehicle(553, 1978, -2286.3999, 15.8, 0, 0, 118); --Nevada
    table.insert(autohausVehicles, { vehicle, "Nevada", 5, 600000.00 })
    vehicle = createVehicle(593, 1951.7, -2264.8, 14.1, 0, 0, 154); --Dodo
    table.insert(autohausVehicles, { vehicle, "Dodo", 5, 211000.00 })
    vehicle = createVehicle(592, 1897.2, -2291.8999, 14.7, 0, 0, 248); --Andromada
    table.insert(autohausVehicles, { vehicle, "Andromada", 5, 7500000.00 })

    -- Bootsautohaus
    vehicle = createVehicle(460, 890.2998046875, -2127.099609375, 1.7999999523163, 0, 0, 201.99462890625)
    table.insert(autohausVehicles, { vehicle, "Skimmer", 6, 700000.00 })
    vehicle = createVehicle(484, 857.70001220703, -2110.8000488281, 0.10000000149012, 0, 0, 211.24987792969)
    table.insert(autohausVehicles, { vehicle, "Marquis", 6, 800000.00 })
    vehicle = createVehicle(446, 791.59997558594, -2140.6000976563, 0, 0, 0, 200.49987792969)
    table.insert(autohausVehicles, { vehicle, "Squallo", 6, 700000.00 })
    vehicle = createVehicle(452, 870.79998779297, -2143.1000976563, 0.10000000149012, 0, 0, 236.99987792969)
    table.insert(autohausVehicles, { vehicle, "Speeder", 6, 180000.00 })
    vehicle = createVehicle(454, 812.90002441406, -2107.1999511719, 0, 0, 0, 141.5)
    table.insert(autohausVehicles, { vehicle, "Tropic", 6, 1250000.00 })
    vehicle = createVehicle(473, 816.70001220703, -2140.8999023438, 0, 0, 0, 152)
    table.insert(autohausVehicles, { vehicle, "Dinghy", 6, 35000.00 })

    --AUTOHAUS 2
    -- Motorradhändler
    vehicle = createVehicle(457, 445.1396484375, -1342.6279296875, 14.773164749146, 359.84619140625, 357.11608886719, 123.93127441406)
    table.insert(autohausVehicles, { vehicle, "Caddy", 2, 2400.00 })
    vehicle = createVehicle(424, 446.97265625, -1345.2509765625, 14.775791168213, 358.84094238281, 357.34680175781, 119.08630371094)
    table.insert(autohausVehicles, { vehicle, "BF-Injection", 2, 64000.00 })
    vehicle = createVehicle(522, 448.9033203125, -1351.0205078125, 14.384108543396, 358.53881835938, 359.92309570312, 29.514770507812)
    table.insert(autohausVehicles, { vehicle, "NRG-500", 2, 210000.00 })
    vehicle = createVehicle(461, 447.62890625, -1351.7333984375, 14.410902023315, 358.64868164062, 359.92858886719, 30.41015625)
    table.insert(autohausVehicles, { vehicle, "PCJ-600", 2, 5800.00 })
    vehicle = createVehicle(521, 445.79296875, -1353.2841796875, 14.389989852905, 358.99475097656, 359.91760253906, 25.702514648438)
    table.insert(autohausVehicles, { vehicle, "FCR-900", 2, 3800.00 })
    vehicle = createVehicle(581, 444.484375, -1353.8857421875, 14.423919677734, 359.21997070312, 359.912109375, 22.74169921875)
    table.insert(autohausVehicles, { vehicle, "BF-400", 2, 3300.00 })
    vehicle = createVehicle(586, 442.1904296875, -1355.431640625, 14.3401222229, 359.73083496094, 359.93408203125, 32.23388671875)
    table.insert(autohausVehicles, { vehicle, "Wayfarer", 2, 2400.00 })
    vehicle = createVehicle(463, 441.056640625, -1356.4921875, 14.349678993225, 359.83520507812, 359.93408203125, 39.830932617188)
    table.insert(autohausVehicles, { vehicle, "Freeway", 2, 21000.00 })
    vehicle = createVehicle(568, 437.7763671875, -1359.1865234375, 14.681805610657, 359.91760253906, 359.90661621094, 29.64111328125)
    table.insert(autohausVehicles, { vehicle, "Bandito", 2, 40000.00 })
    vehicle = createVehicle(434, 434.1513671875, -1361.658203125, 14.781834602356, 359.5166015625, 359.87915039062, 31.591186523438)
    table.insert(autohausVehicles, { vehicle, "Hotknife", 2, 333000.00 })
    vehicle = createVehicle(468, 429.4755859375, -1364.0087890625, 14.463199615479, 359.75830078125, 359.90661621094, 32.376708984375)
    table.insert(autohausVehicles, { vehicle, "Sanchez", 2, 7700.00 })
    vehicle = createVehicle(471, 430.5625, -1362.8876953125, 14.291126251221, 359.21447753906, 359.90661621094, 32.536010742188)
    table.insert(autohausVehicles, { vehicle, "Quadbike", 2, 25000.00 })
    vehicle = createVehicle(462, 449.390625, -1347.30859375, 14.470463752747, 359.6923828125, 357.48413085938, 117.96569824219)
    table.insert(autohausVehicles, { vehicle, "Faggio", 2, 650.00 }) --hier

    for theKey, theKoords in ipairs(autohausspawns) do
        createBlip(theKoords[1], theKoords[2], theKoords[3], 55, 0.5, 255, 0, 0, 255, 0, 255, getRootElement()) --Autohaus
    end

    --temp transform code to generate preview vehicles
    local newCarTableForJson = {}
    for theKey, thevehicle in ipairs(autohausVehicles) do
        local comment = "";
        if (thevehicle[3] == 1) then
            comment = "billighändler"
        elseif (thevehicle[3] == 2) then
            comment = "bikehändler"
        elseif (thevehicle[3] == 4) then
            comment = "Sportautohändler"
        elseif (thevehicle[3] == 5) then
            comment = "flugzeughändler"
        elseif (thevehicle[3] == 6) then
            comment = "bootshändler"
        end

        local x, y, z = getElementPosition(thevehicle[1])
        local rx, ry, rz = getElementRotation(thevehicle[1])
        table.insert(newCarTableForJson, {
            modelId = getElementModel(thevehicle[1]),
            position = { x, y, z },
            rotation = { rx, ry, rz },
            dealerComment = comment
        });
    end

    local jsonCode = toJSON(newCarTableForJson, false, "spaces");
    save_log("vehicle_shop.json", jsonCode);
    --temp transform code end

    --[[ 2 name - 3 autohaus - 4 Preis - 5 Standartpreis wenn varianz aktiviert (mom deaktiviert --> verlangt MDB)]]
    outputDebugString(tostring(table.getn(autohausVehicles)) .. " Cars loaded in Carhouse!")
    for theKey, thevehicle in ipairs(autohausVehicles) do
        vioSetElementData(thevehicle[1], "isAutohausVehicle", true)
        setVehicleDamageProof(thevehicle[1], true)
        setElementFrozen(thevehicle[1], true)

        --RabattCars
    end

    local i = 1;
    for i = 1, 7, 1 do
        local rand = math.random(1, table.getSize(autohausVehicles))
        if (not table.hasValue(rabattCars, rand)) then
            local rabatt = (math.random(20, 80) / 100);
            autohausVehicles[rand][4] = autohausVehicles[rand][4] * rabatt;

            table.insert(rabattCars, rand)
            table.insert(rabattCarsReduce, rabatt)
        end
    end
    local pick = createPickup(427.771484375, -1353.470703125, 15.021891593933, 3, 1239)
    addEventHandler("onPickupHit", pick, shoeAutohausInfoIcon)

    pick = createPickup(2130.6787109375, -1149.76171875, 24.216320037842, 3, 1239)
    addEventHandler("onPickupHit", pick, shoeAutohausInfoIcon)

    local rabattPickup = createPickup(1051.06640625, 1007.8193359375, 11, 3, 1239, 5000)
    addEventHandler("onPickupHit", rabattPickup, sendRabattCarMessage, false)
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createBuyCars)

function shoeAutohausInfoIcon(thePlayer)
    showError(thePlayer, "Zum Kaufen eines Fahrzeugs klicke es einfach an!")
end

function showRabbatCars_func(thePlayer)
    if (vioGetElementData(thePlayer, "fraktion") == 3) then
        outputChatBox("Folgende Fahrzeuge sind heute rabattiert: ", thePlayer)
        for m, z in ipairs(rabattCars) do
            local percentage = 100 - (rabattCarsReduce[m] * 100);
            outputChatBox(autohausVehicles[z][2] .. ": " .. toprice(autohausVehicles[z][4]) .. " (" .. percentage .. " %)", thePlayer)
        end
    end
end
addCommandHandler("rabattcars", showRabbatCars_func, false, false)

function sendRabattCarMessage(player)
    outputChatBox("Folgende Fahrzeuge sind heute rabattiert: ", player)
    for m, z in ipairs(rabattCars) do
        local percentage = 100 - (rabattCarsReduce[m] * 100);
        outputChatBox(autohausVehicles[z][2] .. ": " .. toprice(autohausVehicles[z][4]) .. " (" .. percentage .. " %)", player)
    end
end

function startEnterBuyVehicle_func()
    for theKey, thevehicle in ipairs(autohausVehicles) do
        if (source == thevehicle[1]) then
            cancelEvent()
        end
    end
end

addEventHandler("onVehicleStartEnter", getRootElement(), startEnterBuyVehicle_func)

function clickOnBuyVehicle(button, state, element)
    if (isPlayerLoggedIn(source)) then
        if (button == "left" and state == "down") then
            for theKey, thevehicle in ipairs(autohausVehicles) do
                if (element == thevehicle[1]) then
                    triggerClientEvent(source, "closeAutohausFahrzeugGuiagain", source)
                    triggerClientEvent(source, "showAutohausGui_Event", source, getElementModel(thevehicle[1]), thevehicle[4], thevehicle[2], thevehicle[1])
                end
            end
        end
    end
end

addEventHandler("onPlayerClick", getRootElement(), clickOnBuyVehicle)

function autohaustimer_func(timerid)
    autohaustimer[timerid] = 0
end

function buyCar(thevehicle)
    local freeslots = 0
    local firstfreeslot = 0
    for zah = vioGetElementData(source, "maxslots"), 1, -1 do
        if tonumber(vioGetElementData(source, "slot" .. zah)) == -1 then
            freeslots = freeslots + 1
            firstfreeslot = zah
        end
    end
    if (freeslots == 0) then
        showError(source, "Du hast keinen freien Slot mehr!")
    else
        for theKey, vehicle in ipairs(autohausVehicles) do
            if (vehicle[1] == thevehicle) then
                if (canPlayerHaveVehicle(source, vehicle[4])) then
                    if (hasTheLicenseFor(source, thevehicle)) then
                        if (getPlayerMoney(source) < vehicle[4]) then
                            showError(source, "Du hast nicht genügend Geld!")
                            outputChatBox("Du hast nicht genügend Geld!", source, 255, 0, 0)
                        else
                            changePlayerMoney(source, -vehicle[4], "fahrzeug", "Fahrzeugkauf")
                            local spawnVeh = createVehicle(getElementModel(vehicle[1]), autohausspawns[vehicle[3]][1], autohausspawns[vehicle[3]][2], autohausspawns[vehicle[3]][3], autohausspawns[vehicle[3]][4], autohausspawns[vehicle[3]][5], autohausspawns[vehicle[3]][6])
                            vioSetElementData(source, "slot" .. firstfreeslot, spawnVeh)
                            vioSetElementData(spawnVeh, "besitzer", getPlayerName(source))
                            vioSetElementData(spawnVeh, "slotid", firstfreeslot)
                            vioSetElementData(spawnVeh, "spawnx", 0)
                            vioSetElementData(spawnVeh, "spawny", 0)
                            vioSetElementData(spawnVeh, "spawnz", 0)
                            vioSetElementData(spawnVeh, "spawnrx", 0)
                            vioSetElementData(spawnVeh, "spawnry", 0)
                            vioSetElementData(spawnVeh, "spawnrz", 0)
                            vioSetElementData(spawnVeh, "motor", false)
                            vioSetElementData(spawnVeh, "colors", "0|0|0|0")
                            vioSetElementData(spawnVeh, "locked", true)
                            vioSetElementData(spawnVeh, "tuning", "0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0")
                            vioSetElementData(spawnVeh, "paintjob", 3)
                            vioSetElementData(spawnVeh, "model", getElementModel(vehicle[1]))
                            vioSetElementData(spawnVeh, "tank", 100)
                            vioSetElementData(spawnVeh, "kmstand", 0)
                            vioSetElementData(spawnVeh, "falter", 0)
                            vioSetElementData(spawnVeh, "abgeschleppt", 0)
                            vioSetElementData(spawnVeh, "kaufpreis", vehicle[4])
                            vioSetElementData(spawnVeh, "Lichterfarbe", "255|255|255")
                            vioSetElementData(spawnVeh, "premColor", "-1")
                            fixVehicle(spawnVeh)

                            table.insert(privVeh, { getPlayerName(source), firstfreeslot, spawnVeh })
                            privCars[spawnVeh] = true

                            local dbid = MySql.helper.insertSync("user_vehicles", {
                                SlotID = firstfreeslot,
                                Besitzer = getPlayerName(source),
                                Model = getElementModel(spawnVeh),
                                SpawnX = 0,
                                SpawnY = 0,
                                SpawnZ = 0,
                                SpawnRX = 0,
                                SpawnRY = 0,
                                SpawnRZ = 0,
                                Colors = "0|0|0|0",
                                kaufpreis = vehicle[4]
                            });

                            --                            outputDebugString("Buyed Car dbid:" .. tostring(dbid))
                            vioSetElementData(spawnVeh, "dbid", dbid)
                            warpPedIntoVehicle(source, spawnVeh)
                            showError(source, "Du hast dieses Fahrzeug erfolgreich gekauft! Bitte parke es auf einen PARKPLATZ Reallife mäßig mit /park. Parkst du es nicht wird es an den Koordinaten 0 0 0 spawnen und eventuell gelöscht!")
                            outputChatBox("Du hast dieses Fahrzeug erfolgreich gekauft! Bitte parke es auf einen PARKPLATZ Reallife mäßig mit /park.", source, 255, 0, 0)
                            outputChatBox("Parkst du es nicht wird es an den Koordinaten 0 0 0 spawnen und eventuell gelöscht!", source, 255, 0, 0)
                            if (vioGetElementData(source, "Erfolg_Autoeinsteiger") ~= 1) then
                                vioSetElementData(source, "Erfolg_Autoeinsteiger", 1)
                                triggerClientEvent(source, "onClientCreatePokalGUI", source, "Autoeinsteiger", "Kaufe ein Auto!")
                            end
                        end
                    else
                        showError(source, "Du hast nicht die nötigen Lizensen!")
                    end
                else
                    showError(source, "Dieses Fahrzeug kostet mehr als dein Lebensstandard hergibt.")
                end
            end
        end
    end

    local freeslots = 0
    local firstfreeslot = 0
    for zah = vioGetElementData(source, "maxslots"), 1, -1 do
        if tonumber(vioGetElementData(source, "slot" .. zah)) == -1 then
            freeslots = freeslots + 1
            firstfreeslot = zah
        end
    end
    if ((vioGetElementData(source, "maxslots") - (freeslots - 1)) > 10) then
        if (vioGetElementData(source, "Erfolg_10erFahrzeugrausch") ~= 1) then
            vioSetElementData(source, "Erfolg_10erFahrzeugrausch", 1)
            triggerClientEvent(source, "onClientCreatePokalGUI", source, "10er Fahrzeugrausch", "Besitze 10 Fahrzeuge!")
        end
    end
    if ((vioGetElementData(source, "maxslots") - (freeslots - 1)) > 15) then
        if (vioGetElementData(source, "Erfolg_20erFahrzeugrausch") ~= 1) then
            vioSetElementData(source, "Erfolg_20erFahrzeugrausch", 1)
            triggerClientEvent(source, "onClientCreatePokalGUI", source, "15er Fahrzeugrausch", "Besitze 15 Fahrzeuge!")
        end
    end
    if ((vioGetElementData(source, "maxslots") - (freeslots - 1)) > 20) then
        if (vioGetElementData(source, "Erfolg_50erFahrzeugrausch") ~= 1) then
            vioSetElementData(source, "Erfolg_50erFahrzeugrausch", 1)
            triggerClientEvent(source, "onClientCreatePokalGUI", source, "20er Fahrzeugrausch", "Besitze 20 Fahrzeuge!")
        end
    end
end

addEvent("buyCar_Event", true)
addEventHandler("buyCar_Event", getRootElement(), buyCar)

function buyCarSlot()
    local maxslot = vioGetElementData(source, "maxslots")
    slotprice = math.pow(2, (tonumber(getElementData(source, "maxslots")) - 1)) * 1000
    if (tonumber(getElementData(source, "maxslots")) > 9) then
        slotprice = math.pow(2, 9) * 1000 + math.pow(2, (tonumber(getElementData(source, "maxslots")) - 5)) * 300
    end
    if (tonumber(getElementData(source, "maxslots")) > 14) then
        slotprice = math.pow(2, 9) * 1000 + math.pow(2, 9) * 300 + math.pow(2, (tonumber(getElementData(source, "maxslots")) - 10)) * 300
    end
    if (tonumber(getElementData(source, "maxslots")) > 20) then
        slotprice = math.pow(2, 9) * 1000 + math.pow(2, 9) * 300 + math.pow(2, 10) * 300 + math.pow(1.3, (tonumber(getElementData(source, "maxslots")) - 1)) * 300
    end
    if (getPlayerMoney(source) < slotprice) then
        showError(source, "Du hast nicht genuegend Geld!")
    else
        vioSetElementData(source, "maxslots", (maxslot + 1))
        vioSetElementData(source, "slot" .. (maxslot + 1), -1)
        changePlayerMoney(source, -slotprice, "fahrzeug", "Fahrzeugslotkauf")
        showError(source, "Du hast erfolgreich einen weiteren Slot gekauft!")
        outputChatBox("Du hast erfolgreich einen weiteren Slot gekauft!", source, 255, 0, 0)
    end
end

addEvent("buyCarSlot_Event", true)
addEventHandler("buyCarSlot_Event", getRootElement(), buyCarSlot)
