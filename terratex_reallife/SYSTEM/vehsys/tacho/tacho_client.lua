local lastseat = false
local lastspeed = false

local speedertype = 0
local speedername = { [0] = "Sie haben den Tempomat abgeschaltet!", "Sie haben den Tempomat in den LimiterModus gestellt!", "Sie haben den Tempomat vollständig aktiviert!" }
local maxspeed = 0
local txo = 0
local tyo = 0

local maxwheelspeed = { (1 / 180 * 85), (1 / 180 * 45), (1 / 180 * 25), (1 / 180 * 15) }
local maxmotorspeed = 1 / 180 * 80

local digiduschnitt = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }

function addNewSpeedToDigi(value)
    digiduschnitt[1] = digiduschnitt[2]
    digiduschnitt[2] = digiduschnitt[3]
    digiduschnitt[3] = digiduschnitt[4]
    digiduschnitt[4] = digiduschnitt[5]
    digiduschnitt[5] = digiduschnitt[6]
    digiduschnitt[6] = digiduschnitt[7]
    digiduschnitt[7] = digiduschnitt[8]
    digiduschnitt[8] = digiduschnitt[9]
    digiduschnitt[9] = digiduschnitt[10]
    digiduschnitt[10] = value
end

function setLimiterSpeedcmd_func(cmd, speed)
    setSpeedo("tmp", 1)
    maxspeed = tonumber(speed) / 180
end

addCommandHandler("setlimit", setLimiterSpeedcmd_func, false, false)

function setTempoSpeedCMD_func(cmd, speed)
    setSpeedo("tmp", 2)
    maxspeed = tonumber(speed) / 180
end

addCommandHandler("settempo", setTempoSpeedCMD_func, false, false)

local wasBremseSet = false
function enterVehicle()
    if (isPedInVehicle(getLocalPlayer())) then
        if (lastseat == 0) then
            local xs, ys = guiGetScreenSize()

            if (getPedOccupiedVehicle(getLocalPlayer())) then
                benzin = 69
                if (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "tank")) then
                    benzin = math.round(getElementData(getPedOccupiedVehicle(getLocalPlayer()), "tank") * 0.69)
                end
                local kmtext = "000000.0"
                if (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "kmstand")) then
                    local km = tostring(math.round(getElementData(getPedOccupiedVehicle(getLocalPlayer()), "kmstand"), 1))
                    if (math.round(getElementData(getPedOccupiedVehicle(getLocalPlayer()), "kmstand"), 1) == math.round(getElementData(getPedOccupiedVehicle(getLocalPlayer()), "kmstand"), 0)) then
                        km = km .. ".0"
                    end
                    if (string.len(km) == 8) then
                        kmtext = km
                    end
                    if (string.len(km) > 8) then
                        kmtext = "_" .. string.sub(km, string.len(km) - 7)
                    end
                    if (string.len(km) < 8) then
                        local newkm = ""
                        for i = 0, (8 - string.len(km)), 1 do
                            newkm = newkm .. "0"
                        end
                        kmtext = newkm .. km
                    end
                end
                local tx, ty, tz = getElementVelocity(getPedOccupiedVehicle(getLocalPlayer()))
                local speed = 180 * math.sqrt(tx * tx + ty * ty + tz * tz)
                local messpeed = math.sqrt(tx * tx + ty * ty + tz * tz)
                txo = tx
                tyo = ty
                if (tx) then
                    lastspeed = speed
                else
                    speed = lastspeed
                end
                addNewSpeedToDigi(math.round(speed, 1))
                local digi = 0
                for theKey, theSpeed in ipairs(digiduschnitt) do
                    digi = digi + theSpeed
                end
                digi = math.round(digi / 10, 1)
                --outputChatBox(tostring(math.round(speed,1)))
                if (not isPlayerMapVisible()) then
                    dxDrawRectangle(xs - 205, ys - 29, benzin, 14, tocolor(255, 0, 0, 255))
                    dxDrawImage(xs - 275, ys - 275, 274, 274, "FILES/IMAGES/tacho/tacho.png")
                    dxDrawText(kmtext, xs - 113, ys - 30, xs - 43, ys - 17, tocolor(255, 255, 255, 255), 1, "default", "left")
                    if (tonumber(getElementData(getLocalPlayer(), "tachodig_addon")) == 1) then
                        dxDrawText(tostring(digi), xs - 171, ys - 110, xs - 86, ys - 190, tocolor(255, 255, 255, 255), 2, "default", "left")
                    end
                    if (speedertype == 1) then
                        dxDrawImage(xs - 275, ys - 250, 275, 275, "FILES/IMAGES/tacho/needle_blue.png", (maxspeed * 180))
                    elseif (speedertype == 2) then
                        dxDrawImage(xs - 275, ys - 250, 275, 275, "FILES/IMAGES/tacho/needle_green.png", (maxspeed * 180))
                    end
                    dxDrawImage(xs - 275, ys - 250, 275, 275, "FILES/IMAGES/tacho/needle.png", speed)
                end

                local stopspeed = maxspeed - messpeed
                --[[if(stopspeed>0.2)then
                    if(speedertype==2)then
                        speedertype=0
                        setControlState("accelerate",false)
                    end
                end ]]
                --outputChatBox(speedertype)
                if (tx) then
                    if (speedertype ~= 0) then
                        --outputChatBox(tostring((maxspeed/(messpeed/100))/100))
                        if (wasBremseSet) then
                            --setControlState("handbrake",false)
                            setControlState("brake_reverse", false)
                            setControlState("accelerate", false)
                            wasBremseSet = false
                        end
                        if (messpeed > maxspeed) then

                            if (messpeed > (maxspeed + (5 / 180))) then
                                --setControlState("handbrake",true)
                                setControlState("brake_reverse", true)
                                setControlState("accelerate", false)
                                wasBremseSet = true
                            else
                                local mult = (maxspeed / (messpeed / 100)) / 100
                                setElementVelocity(getPedOccupiedVehicle(getLocalPlayer()), tx * mult, ty * mult, tz * mult)
                            end
                        end

                        if (speedertype == 2) then
                            --wasBremseSet=true
                            if not ((messpeed + 4 * (1 / 180)) < maxspeed) then
                                if (getKeyState("num_add")) then
                                    maxspeed = maxspeed + (1 / 1000)
                                end
                            end
                            if (getKeyState("num_sub")) then
                                maxspeed = maxspeed - (1 / 1000)
                                if (maxspeed < 5 * (1 / 180)) then
                                    maxspeed = 5 * (1 / 180)
                                end
                            end
                            if (messpeed < maxspeed) then
                                setControlState("accelerate", true)
                            else
                                setControlState("accelerate", false)
                            end
                        end
                    end

                    local whA, whB, whC, whD = getVehicleWheelStates(getPedOccupiedVehicle(getLocalPlayer()))
                    local futsch = 0
                    if (whA == 1) then
                        futsch = futsch + 1
                    end
                    if (whB == 1) then
                        futsch = futsch + 1
                    end
                    if (whC == 1) then
                        futsch = futsch + 1
                    end
                    if (whD == 1) then
                        futsch = futsch + 1
                    end
                    if (futsch > 0) then

                        if (messpeed > maxwheelspeed[futsch]) then
                            local mult = (maxwheelspeed[futsch] / (messpeed / 100)) / 100
                            setElementVelocity(getPedOccupiedVehicle(getLocalPlayer()), tx * mult, ty * mult, tz * mult)
                        end
                        if (speedertype == 2) then
                            speedertype = 0
                            setControlState("accelerate", false)
                        end
                    end

                    if not (tonumber(getElementData(getLocalPlayer(), "inArena")) ~= 0) then
                        if (getElementHealth(getPedOccupiedVehicle(getLocalPlayer())) < 500) then
                            if (messpeed > maxmotorspeed) then

                                local mult = (maxmotorspeed / (messpeed / 100)) / 100
                                setElementVelocity(getPedOccupiedVehicle(getLocalPlayer()), tx * mult, ty * mult, tz * mult)
                                maxspeed = maxmotorspeed
                            end
                        end

                        if (getElementHealth(getPedOccupiedVehicle(getLocalPlayer())) < 350) then
                            if (getVehicleEngineState(getPedOccupiedVehicle(getLocalPlayer()))) then
                                triggerServerEvent("shutdownMotor", getPedOccupiedVehicle(getLocalPlayer()))
                            end
                        end
                    end
                    --wtruck
                    local vehicle = getPedOccupiedVehicle(getLocalPlayer())
                    if (config["feature.limiter.muntruck"]) then
                        if (getElementData(vehicle, "muntruck") or getElementData(vehicle, "atomveh") or getElementData(vehicle, "isGTruck")) then
                            if (messpeed > (1 / 180 * tonumber(config["feature.limiter.muntruck"]))) then
                                local mult = ((1 / 180 * tonumber(config["feature.limiter.muntruck"])) / (messpeed / 100)) / 100
                                setElementVelocity(getPedOccupiedVehicle(getLocalPlayer()), tx * mult, ty * mult, tz * mult)
                                maxspeed = (1 / 180 * tonumber(config["feature.limiter.muntruck"]))
                            end
                        end
                    end
                    --faggio
                    if config["feature.limiter.faggio"] then
                        if (getElementModel(getPedOccupiedVehicle(getLocalPlayer())) == 462) then
                            if (messpeed > (1 / 180 * tonumber(config["feature.limiter.faggio"]))) then
                                local mult = ((1 / 180 * tonumber(config["feature.limiter.faggio"])) / (messpeed / 100)) / 100
                                setElementVelocity(getPedOccupiedVehicle(getLocalPlayer()), tx * mult, ty * mult, tz * mult)
                                maxspeed = (1 / 180 * tonumber(config["feature.limiter.faggio"]))
                            end
                        end
                    end
                    --Pizza
                    if config["feature.limiter.pizza"] then
                        if (getElementModel(getPedOccupiedVehicle(getLocalPlayer())) == 448) then
                            if (messpeed > (1 / 180 * tonumber(config["feature.limiter.pizza"]))) then
                                local mult = ((1 / 180 * tonumber(config["feature.limiter.pizza"])) / (messpeed / 100)) / 100
                                setElementVelocity(getPedOccupiedVehicle(getLocalPlayer()), tx * mult, ty * mult, tz * mult)
                                maxspeed = (1 / 180 * tonumber(config["feature.limiter.pizza"]))
                            end
                        end
                    end

                    --quad
                    if config["feature.limiter.pizza"] then
                        if (getElementModel(getPedOccupiedVehicle(getLocalPlayer())) == 471) then
                            if (messpeed > (1 / 180 * tonumber(config["feature.limiter.pizza"]))) then
                                local mult = ((1 / 180 * tonumber(config["feature.limiter.quad"])) / (messpeed / 100)) / 100
                                setElementVelocity(getPedOccupiedVehicle(getLocalPlayer()), tx * mult, ty * mult, tz * mult)
                                maxspeed = (1 / 180 * tonumber(config["feature.limiter.quad"]))
                            end
                        end
                    end


                    if not (isPlane(getPedOccupiedVehicle(getLocalPlayer()))) then
                        local isnotFrakcar = false
                        if (tonumber(getElementData(getPedOccupiedVehicle(getLocalPlayer()), "frakid"))) then
                            if (tonumber(getElementData(getPedOccupiedVehicle(getLocalPlayer()), "frakid")) ~= 0) then
                                isnotFrakcar = false
                            else
                                isnotFrakcar = true
                            end
                        else
                            isnotFrakcar = true
                        end
                        if (isInRuheZone and (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "besitzer") or isnotFrakcar)) then
                            if (messpeed > (1 / 180 * 30)) then
                                local mult = ((1 / 180 * 30) / (messpeed / 100)) / 100
                                setElementVelocity(getPedOccupiedVehicle(getLocalPlayer()), tx * mult, ty * mult, tz * mult)
                                maxspeed = (1 / 180 * 30)
                            end
                        end
                    end
                end
            end
        end

    else
        digiduschnitt = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    end
end

addEventHandler("onClientRender", getRootElement(), enterVehicle)

function enterVehicleSeat(thePlayer, seat)
    if (thePlayer == getLocalPlayer()) then
        lastseat = seat
    end
end

addEventHandler("onClientVehicleEnter", getRootElement(), enterVehicleSeat)

function exitVehicleSeat(thePlayer)
    if (thePlayer == getLocalPlayer()) then
        lastseat = false
    end
end

addEventHandler("onClientVehicleExit", getRootElement(), exitVehicleSeat)

function setSpeedo(command, types)
    if (isPedInVehicle(getLocalPlayer())) then
        if (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "motornum")) then
            if (tonumber(getElementData(getPedOccupiedVehicle(getLocalPlayer()), "motornum")) == 1) then
                if (types) then
                    local typer = tonumber(types)
                    if (typer > 0 and typer < 3) then

                        setControlState("accelerate", false)
                        speedertype = typer
                        outputChatBox(speedername[typer])
                        if (typer == 2) then
                            outputChatBox("Er wird automatisch deaktiviert, sobald Du beschleunigst oder bremst.")
                            --	toggleControl("accelerate",false)
                        end
                        local tx, ty, tz = getElementVelocity(getPedOccupiedVehicle(getLocalPlayer()))
                        maxspeed = math.sqrt(tx * tx + ty * ty + tz * tz)
                        bindKey("arrow_u", "down", stopspeedo)
                        bindKey("arrow_d", "down", stopspeedo)
                        bindKey("w", "down", stopspeedo)
                        bindKey("s", "down", stopspeedo)
                        bindKey("space", "down", stopspeedo)
                        bindKey("x", "down", stopspeedo)
                    end
                else
                    speedertype = 0
                    setControlState("accelerate", false)
                end
            end
        end
    end
end

addCommandHandler("tmp", setSpeedo, false, false)

function stopspeedo()
    if (speedertype == 2) then
        speedertype = 0
        setControlState("accelerate", false)
    end
end

function setspeedoA()
    setSpeedo("tmp", 0)
    stopspeedo()
    speedertype = 0
    setControlState("accelerate", false)
end

function setspeedoB()
    setSpeedo("tmp", 1)
end

function setspeedoC()
    setSpeedo("tmp", 2)
end

function firstTempStart()
    bindKey(",", "down", setspeedoA)
    bindKey(".", "down", setspeedoB)
    bindKey("-", "down", setspeedoC)
end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), firstTempStart)

function disbaleTeme(player)
    if (player == getLocalPlayer()) then
        speedertype = 0
        setControlState("accelerate", false)
    end
end

addEventHandler("onClientVehicleEnter", getRootElement(), disbaleTeme)









