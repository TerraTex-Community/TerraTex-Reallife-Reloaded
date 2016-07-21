--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 21.07.2016
-- Time: 16:16
-- To change this template use File | Settings | File Templates.
--

function getCrimePercentage(thePlayer)
    local query = "SELECT sum(CrimePercentage) as CrimeLevel FROM user_crimes WHERE Nickname = ?";
    local executedQuery = dbQuery(MySql._connection, query, getPlayerName(thePlayer));

    local result = dbPoll(executedQuery, -1);

    if (result and result[1]) then
        local crimeLevel = tonumber(result[1].CrimeLevel);
        if (crimeLevel > 100) then
            return 100;
        else
            return crimeLevel;
        end
    else
        return 0;
    end
end

