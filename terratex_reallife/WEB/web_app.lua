--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 02.09.2014
-- Time: 12:22
-- To change this template use File | Settings | File Templates.
--

function web_getVehicleShopData()
    local prepareVehicletable={}
    for theKey,theTable in ipairs(autohausVehicles)do

        local model=getElementModel(theTable[1])
        local vehTable={
            ["model"]=model,
            ["autohaus"]=theTable[3],
            ["name"]=theTable[2],
            ["preis"]=theTable[4]
        }
        table.insert(prepareVehicletable,vehTable)
    end


    return prepareVehicletable
end

function web_getWeatherData()
    local WeatherTable={
        ["nextWeather"]=0,
        ["rainlevel"]=0,
        ["wetterEvent"]=0,
        ["wetterEventName"]="",
        ["wetterWolken"]=false,
        ["wellenHoehe"]=0,
        ["wind"]=0,
        ["nebel"]=0,
        ["sichtweite"]=0,
    }

    --nächster Wetterwechsel
    if(isTimer(weatherchangeTimer))then
        local remaining, executesRemaining, totalExecutes=getTimerDetails ( weatherchangeTimer )
        WeatherTable["nextWeather"]=remaining
        WeatherTable["rainlevel"]=oldrainlevel
    else
        local remaining, executesRemaining, totalExecutes=getTimerDetails ( weatheraktualTimer )
        WeatherTable["nextWeather"]=remaining+10*60*1000
        WeatherTable["rainlevel"]=rainlevel
    end

    WeatherTable["wetterEvent"]=isWetterEventID
    WeatherTable["wetterEventName"]=sondermeldungstext[isWetterEventID]
    WeatherTable["wetterWolken"]=getCloudsEnabled ()
    WeatherTable["wellenHoehe"]=getWaveHeight()
    local x,y,z=getWindVelocity ( )
    WeatherTable["wind"]=math.sqrt(x*x+y*y+z*z)
    WeatherTable["nebel"]=getFogDistance()
    WeatherTable["sichtweite"]=getFarClipDistance()

    return WeatherTable
end








