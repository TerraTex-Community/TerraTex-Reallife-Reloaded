function changeScoreBoard()
    exports.scoreboard_custom_terratex:scoreboardAddColumn ( "playTime_formated" , getRootElement(), 70, "Spielzeit", 20, "right")
    exports.scoreboard_custom_terratex:scoreboardAddColumn ( "inJail" , getRootElement(), 35, "Jail?", 1, "right")
--    exports.scoreboard:scoreboardForceTeamsHidden(true)
    --exports.scoreboard:scoreboardForceTeamsVisible(true)
end
addEventHandler("onResourceStart", resourceRoot, changeScoreBoard)

