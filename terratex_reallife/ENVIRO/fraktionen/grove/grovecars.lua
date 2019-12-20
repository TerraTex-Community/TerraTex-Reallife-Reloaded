frakselfcars[2] = {}

function creategrovecars()
    -- Mr. Whoopee
    local vehicle = createVehicle(423, 2514, -1709.6999511719, 13.5, 0, 0, 270, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    -- Savanna
    vehicle = createVehicle(567, 2526.1000976563, -1717.8000488281, 13.39999961853, 0, 0, 0, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    vehicle = createVehicle(567, 2530.1000976563, -1717.8000488281, 13.39999961853, 0, 0, 0, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    -- Sabre
    vehicle = createVehicle(567, 2534.3000488281, -1718.0999755859, 13.300000190735, 0, 0, 0, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    vehicle = createVehicle(567, 2537.6999511719, -1718.0999755859, 13.300000190735, 0, 0, 0, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    -- Greenwood
    vehicle = createVehicle(492, 2510.3999023438, -1687.4000244141, 13.345000267029, 0, 0, 48, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    vehicle = createVehicle(492, 2506.8000488281, -1650.9000244141, 13.5, 356.75, 0, 136, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    vehicle = createVehicle(492, 2496.5, -1647.5999755859, 13.300000190735, 0, 0, 250, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    -- Voodoo
    vehicle = createVehicle(412, 2485.6999511719, -1655.5, 13.14999961853, 0, 0, 90, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    vehicle = createVehicle(412, 2477.1999511719, -1655.5, 13.14999961853, 0, 0, 90, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    -- Landstalker
    vehicle = createVehicle(400, 2470.3000488281, -1671, 13.39999961853, 0, 0, 10, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    -- Blade
    vehicle = createVehicle(536, 2491.1000976563, -1682.5999755859, 13.10000038147, 0, 0, 270, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    vehicle = createVehicle(536, 2508.3999023438, -1666.5, 13.125, 0, 0, 11.75, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    -- FCR 900
    vehicle = createVehicle(521, 2506, -1677.3000488281, 12.89999961853, 0, 0, 0, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    vehicle = createVehicle(521, 2507.3999023438, -1675.3000488281, 12.89999961853, 0, 0, 0, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    -- Uranus
    vehicle = createVehicle(558, 2462.3999023438, -1683.3000488281, 13.10000038147, 0, 0, 230, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    -- Picador
    vehicle = createVehicle(600, 2473.3000488281, -1697.0999755859, 13.199999809265, 0, 0, 0, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    vehicle = createVehicle(600, 2473.3000488281, -1704.3000488281, 13.199999809265, 0, 0, 0, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    -- Maverick
    vehicle = createVehicle(487, 2510.5, -1718.3000488281, 18.700000762939, 0, 0, 270, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    -- Rumpo
    vehicle = createVehicle(440, 2443, -1635.9000244141, 13.60000038147, 0, 0, 180, "GROVE")
    table.insert(frakselfcars[2], vehicle)
    -- Pony
    vehicle = createVehicle(413, 2443, -1644, 13.60000038147, 0, 0, 180, "GROVE")
    table.insert(frakselfcars[2], vehicle)

    for key, theVehicle in pairs(frakselfcars[2]) do
        prepare(theVehicle, 2)
        setVehicleColor(theVehicle, 86, 86, 86, 86)
        vioSetElementData(theVehicle, "tank", 100)
        table.insert(frakcars, theVehicle)
    end

    local console = getElementsByType("console")
    vioSetElementData(console[1], "adminlvl", 4)
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), creategrovecars)

addEvent("triggerMeGroveCar", true)
function sendGroveEiswagenPosition()
    --outputChatBox(tostring(frakselfcars[2][1]))
    triggerClientEvent(source, "sendGroveEiswagen", source, frakselfcars[2][1])
end

addEventHandler("triggerMeGroveCar", getRootElement(), sendGroveEiswagenPosition)

function notingroveCarEnter(thePlayer, seat, jacked, door)
    if (seat == 0) then
        for theKey, theVehicle in pairs(frakselfcars[2]) do
            if (source == theVehicle) then
                if not (vioGetElementData(thePlayer, "fraktion") == 2) then
                    showError(thePlayer, "Du kannst das nicht benutzen. Du bist kein Member der GroveStreet!")
                    cancelEvent()
                end
            end
        end
    end
end

addEventHandler("onVehicleStartEnter", getRootElement(), notingroveCarEnter)


 








