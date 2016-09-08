local food = 100
local foodtimer = false
addEvent("playSound", true)
addEventHandler("playSound", getRootElement(), playSound)
local waittimer = 0
local abhierHeilenTimer = 0

function getFood()
    return food;
end

function setFood(foodLvl)
    food = tonumber(foodLvl);
end
addEvent("setFoodLvl", true);
addEventHandler("setFoodLvl", getRootElement(), setFood)

addEvent("StopHealingTimer", true)
function StopHealingTimer_func()
    local time = getRealTime()
    abhierHeilenTimer = time.timestamp
    --outputChatBox(tostring(abhierHeilenTimer))
end
addEventHandler("StopHealingTimer", getRootElement(), StopHealingTimer_func)

function startFood()
    food = 100
    setTimer(reduceFood, 1000, 1)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), startFood)

addEvent("stopFoodTimerForSeconds_Event", true)
function stopFoodTimerForSeconds(seconds)
    waittimer = waittimer + seconds
end
addEventHandler("stopFoodTimerForSeconds_Event", getRootElement(), stopFoodTimerForSeconds)

addEvent("krankheitsreduce", true)
function krankheitsreduce_func()
    if (food > 25) then
        food = 25
    end
end

addEventHandler("krankheitsreduce", getRootElement(), krankheitsreduce_func)

--atomkatastrophe
local janeinvllt = true
function reduceFood()
    if (isPlayerLoggedIn(getLocalPlayer())) then
        if not (waittimer > 0) then
            if (tonumber(getElementData(getLocalPlayer(), "afk_status")) == 0) then
                local foodreduce = 0
                if (isGoldBoosterActive(getLocalPlayer(), "FoodBooster")) then
                    foodreduce = 0.0225
                else
                    foodreduce = 0.045
                end
                if (atomkatastrophe) then
                    if (tonumber(getElementData(getLocalPlayer(), "fraktion")) == 10) then
                        foodreduce = foodreduce * 3
                    else
                        foodreduce = foodreduce * 5
                    end
                end
                food = food - foodreduce
            end

        else
            waittimer = waittimer - 1
        end
        setElementData(getLocalPlayer(), "lastFood", food);
    end
    foodtimer = setTimer(reduceFood, 1000, 1)
end
addEvent("addFood", true)

function addFoodLevel(menge)

    food = food + menge
    triggerServerEvent("FoodLevelIs", getLocalPlayer(), food)


    if (food > 100) then
        local he = food - 100
        food = 100
    end
    if (food < 0) then food = 0 end

    triggerServerEvent("giveFoodPokal", getLocalPlayer())
end
addEventHandler("addFood", getRootElement(), addFoodLevel)
addEvent("setHalfFoodLevel", true)

function foodreset()
    food = 50
end
addEventHandler("setHalfFoodLevel", getRootElement(), foodreset)


function showFood()
    if (food < 0) then
        triggerServerEvent("FoodLevelIs", getLocalPlayer(), food)
        if (food < 0) then food = 0 end
    end
end
addEventHandler("onClientRender", getRootElement(), showFood)
