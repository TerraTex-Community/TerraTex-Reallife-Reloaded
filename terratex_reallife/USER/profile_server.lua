--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 15.07.2016
-- Time: 17:18
-- To change this template use File | Settings | File Templates.
--

function getProfileData_func()
    local playerName = getPlayerName(source);
    local userdata = MySql.helper.getSync("user", {"EMail", "Geb_T", "Geb_M", "Geb_Y", "Urlaub_Until"}, {Nickname = playerName});
    userdata = userdata[1];
    local polishedData = {};

    local email = userdata.EMail;
    local start,ends  = string.find(email, "@");

    if (start) then
        local endPart = string.sub(email, start);
        local startPart = string.sub(email, 0, start - 1);
        local middle = string.sub(email, 4, start - 1);
        print(endPart);
        print(startPart);
        print(middle);

        middle = string.gsub(middle, ".", "*");

        email = string.sub(startPart, 0, 3) .. middle .. endPart;
    else
        email = "invalid";
    end

    polishedData.email = email;
    polishedData.birthday = userdata.Geb_T .. "." .. userdata.Geb_M .. "." .. userdata.Geb_Y;

    local time = getRealTime();
    if (time.timestamp < userdata.Urlaub_Until) then
        polishedData.vacation = (time.timestamp - userdata.Urlaub_Until) / 60 / 60 / 24;
    else
        polishedData.vacation = false;
    end

    triggerClientEvent(source, "sendProfileData", source, polishedData);
end
addEvent("getProfileData", true);
addEventHandler("getProfileData", getRootElement(), getProfileData_func);