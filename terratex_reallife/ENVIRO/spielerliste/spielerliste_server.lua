--
-- Created by IntelliJ IDEA.
-- User: Geramy
-- Date: 23.02.2015
-- Time: 19:56
-- To change this template use File | Settings | File Templates.
--

function changeScoreBoard()
    exports.scoreboard_custom_terratex:scoreboardAddColumn ( "playTime_formated" , getRootElement(), 70, "Spielzeit", 20, "right")
--    exports.scoreboard:scoreboardForceTeamsHidden(true)
    --exports.scoreboard:scoreboardForceTeamsVisible(true)
end
addEventHandler("onResourceStart", resourceRoot, changeScoreBoard)

