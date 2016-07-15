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

function profileChangePassword_func(oldPassword, newPassword)
    local playerName = getPlayerName(source);
    local data = MySql.helper.getSync("user", {"Passwort", "Salt"}, {Nickname = playerName});
    data = data[1];


    local pw = data.Salt .. oldPassword
    if (config["password_hash"] == "md5") then
        pw = md5(pw)
    elseif (config["password_hash"] == "osha256") then
        pw = sha256(pw)
    elseif (config["password_hash"] == "sha256") then
        pw = hash("sha256", pw)
    else
        pw = hash("sha512", pw)
    end

    if (pw == data.Passwort) then
        local newpw = data.Salt .. newPassword
        if (config["password_hash"] == "md5") then
            newpw = md5(newpw)
        elseif (config["password_hash"] == "osha256") then
            newpw = sha256(newpw)
        elseif (config["password_hash"] == "sha256") then
            newpw = hash("sha256", newpw)
        else
            newpw = hash("sha512", newpw)
        end

        MySql.helper.update("user", {Passwort = newpw}, {Nickname = playerName});
        showError(source, "Das Passwort wurde erfolgreich geändert!");
        triggerClientEvent(source, "cleanPasswordFields", source);
    else
        showError(source, "Das Passwort ist falsch.");
    end
end
addEvent("profileChangePassword", true);
addEventHandler("profileChangePassword", getRootElement(), profileChangePassword_func);

