--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 18.11.2016
-- Time: 10:19
-- To change this template use File | Settings | File Templates.
--

local longitude = 8.4559741;
local latitude = 48.9996442;
local zenith = 90.5;

--- (N)
function getDayOfYear()
    return getRealTime().yearday;
--    return 325;  -- for testing
end

--- riseOrSet  (t)
-- @param boolean riseOrSet - True = rise, false = set
function calcLongitudeToTime(riseOrSet)
    local lngHour = longitude / 15;

    if (riseOrSet) then
        return getDayOfYear() + ((6 - lngHour) / 24);
    else
        return getDayOfYear() + ((18 - lngHour) / 24);
    end
end

--- (M)
function calculateSunMeanAnomaly(riseOrSet)
    return (0.9856 * calcLongitudeToTime(riseOrSet) - 3.289);
end

--- L
function calculateSunTrueLongitude(riseOrSet)
    local M = calculateSunMeanAnomaly(riseOrSet);

    local L = M + (1.916 * math.sin(math.rad(M))) + (0.020 * math.sin(2 * math.rad(M))) + 282.634;

    while (L > 360) do
        L = L - 360;
    end

    return L;
end

--- RA
function calculateSunRightAscension(riseOrSet)
    local L = calculateSunTrueLongitude(riseOrSet);
    local RA = math.deg(math.atan(0.91764 * math.tan(math.rad(L))));

    while (RA > 360) do
        RA = RA - 360;
    end

    local Lquadrant  = (math.floor( L/90)) * 90;
    local RAquadrant = (math.floor(RA/90)) * 90;
    RA = RA + (Lquadrant - RAquadrant);
    RA = RA / 15;
    return RA;
end

--- sinDec cosDec
function calculateSunDeclination(riseOrSet)
    local L = calculateSunTrueLongitude(riseOrSet);
    local sinDec = 0.39782 * math.sin(math.rad(L));
    local cosDec = math.cos(math.asin(sinDec));

    return sinDec, cosDec;
end

--- H
function calculateSunLocalHourAngle(riseOrSet)
    local sinDec, cosDec = calculateSunDeclination(riseOrSet);
    local cosH = (math.cos(math.rad(zenith)) - (sinDec * math.sin(math.rad(latitude)))) / (cosDec * math.cos(math.rad(latitude)))
    local H;
    if (riseOrSet) then
        H = 360 - math.deg(math.acos(cosH));
    else
        H = math.deg(math.acos(cosH));
    end

    H = H / 15;
    return H;
end

function calculateLocalMeanTime(riseOrSet)
    local H = calculateSunLocalHourAngle(riseOrSet);
    local RA = calculateSunRightAscension(riseOrSet);
    local t = calcLongitudeToTime(riseOrSet);

    local T = H + RA - (0.06571 * t) - 6.622;
    return T;
end

function calcSunTime(riseOrSet)
    local lngHour = longitude / 15;
    local T = calculateLocalMeanTime(riseOrSet);
    local UT = T - lngHour;

    while (UT > 24) do
        UT = UT - 24;
    end

    while (UT < 24) do
        UT = UT + 24;
    end

    if (getRealTime().isdst) then
        UT = UT + 1;
    else
        UT = UT + 2;
    end



    return math.floor(UT);
end