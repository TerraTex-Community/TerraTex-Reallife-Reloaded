####16.06.2016
------
* [ADDED] #16 Added all Teleport Markers to Database / SQL
* [REMOVED] #16 Old Interior Script

####16.06.2016
------
* [ADDED] Sql Update 1.0.0 File
* [ADDED] #16 Table Creation for Teleportmarkers
* [ADDED] #16 New Teleportmarkers Script
* [FIXED] #17 Fixed Ruhezonen Bugs
* [FIXED] #20 /hkasse was working everywhere
* [FIXED] #19 Fixed Afk Bug of the job "Meeresreiniger"
* [FIXED] #18 Hotdogsellers can now set a prices that is smaller or equal then the money of the receiver
* [CHANGED] #17 Rename Commands of restareas to /setRZoneCorner and /delRZone
* [MOVED] #17 Moved rest area command functions to file "ruhezone_server.lua"

####15.06.2016
------
* [FIXED] some Issues related to the latest mysql changes
* [REMOVED] Senseless Admincommands like /lollol and /lollol2
* [GENERAL] Some restructuring and formating of some files

####14.06.2016
------
* [GENERAL] Restructured all database tables

####13.06.2016
------
* [GENERAL] Refactored all mysql_querys in bansys.lua
* [GENERAL] Refactored all mysql_querys in punishchecker.lua
* [GENERAL] Refactored all mysql_querys in accept.lua
* [GENERAL] Refactored all mysql_querys in bsn_server.lua
* [GENERAL] Refactored all mysql_querys in sprunk.lua
* [GENERAL] Refactored all mysql_querys in fraktion.lua
* [GENERAL] Refactored all mysql_querys in abschleppen.lua
* [GENERAL] Refactored all mysql_querys in arrest.lua
* [GENERAL] Refactored all mysql_querys in ruhezone_server.lua
* [GENERAL] Refactored all mysql_querys in kill.lua
* [GENERAL] Refactored all mysql_querys in friendlist_server.lua
* [GENERAL] Refactored all mysql_querys in OnlineBanking_Server.lua
* [GENERAL] Refactored all mysql_querys in tictactoe_server.lua
* [GENERAL] Refactored all mysql_querys in tombupot_server.lua
* [GENERAL] Refactored all mysql_querys in geschenke_geben.lua
* [GENERAL] Refactored all mysql_querys in halloween_server.lua
* [GENERAL] Refactored all mysql_querys in ostern_server.lua
* [GENERAL] Refactored all mysql_querys in faq/server.lua
* [GENERAL] Refactored all mysql_querys in loggingsys.lua
* [GENERAL] Refactored all mysql_querys in anti_ping_server.lua
* [GENERAL] Refactored all mysql_querys in anti_spam_server.lua
* [GENERAL] Refactored all mysql_querys in data.lua
* [GENERAL] Refactored all mysql_querys in prestige_load.lua
* [GENERAL] Refactored all mysql_querys in autohaus_motel.lua
* [GENERAL] Refactored all mysql_querys in start_veh.lua
* [GENERAL] Refactored all mysql_querys in vehicle_house.lua
* [GENERAL] Refactored all mysql_querys in privCarCommands.lua
* [GENERAL] Refactored all mysql_querys in loadprivcars.lua
* [CHANGED] #6 Hiddenadmins are now shown on /admins for Admins with minimum rank "Moderator"
* [CHANGED] The sellprice will be transfered to the bank account on /sellprestige
* [FIXED] #7 The Value set by /fsteuer will be rounded to disallow decimals
* [FIXED] #11 /buyprestige should be paid from the bank account of the player
* [FIXED] #12 Medics have to be in Duty and must not to be in a vehicle to heal a player
* [REMOVED] Dutycounter removed
* [REMOVED] removed never used command /aktping
* [REMOVED] old mysql_start.lua

####12.06.2016
------
* [GENERAL] Refactored all mysql_querys in d_uv_scripted.lua
* [GENERAL] Refactored all mysql_querys in player_connect.lua
* [GENERAL] Refactored all mysql_querys in loggingsys.lua
* [GENERAL] Refactored all mysql_querys in bank_func_server.lua
* [GENERAL] Refactored all mysql_querys in loadBiz.lua
* [GENERAL] Refactored all mysql_querys in haus_class.lua
* [GENERAL] Refactored all mysql_querys in hwunsch.lua
* [GENERAL] Refactored all mysql_querys in system.lua
* [ADDED] Readded /tunekmh (was requested by an Admin)
* [FIXED] Added restoreAllWorldModels to GMX Process to prevent Map Issues
* [REMOVED] AdminGUI removed because it is too outdated
* [REMOVED] Removed /multiacc
* [REMOVED] Removed multiaccountcheck function 

####11.06.2016
------
* [ADDED] MySql.helper.getSync()
* [ADDED] MySql.helper.insert()
* [ADDED] MySql.helper.insertSync()
* [REMOVED] mysql.getFirstTableRow()
* [REMOVED] Rubbellose werden bei Zügen nicht mehr gespawned
* [FIXED] Adminlist /admins was not working
* [CHANGED] Trains are now spawning on different positions
* [GENERAL] Reworked all mysql_querys in email_server.lua
* [GENERAL] Reworked all mysql_querys in loadserversettings.lua

####10.06.2016
------
* [ADDED] New Helperfunction table.concat
* [ADDED] MySql.helper.update()
* [ADDED] MySql.helper.delete()
* [ADDED] MySql.helper.getCountSync()
* [ADDED] MySql.helper.existSync()
* [REMOVED] Senseless Admincommands
* [REMOVED] Old Function MySQL_GetString removed
* [REMOVED] Old Function MySQL_SetVar removed
* [REMOVED] Old Function MySQL_SetString removed
* [REMOVED] Old Function MySQL_DelRow removed
* [REMOVED] Old Function MySQL_GetResultsCount removed
* [REMOVED] Old Function MySQL_DatasetExist removed
* [REMOVED] MySql.helper.getColumn doesn't make any sense
* [CHANGED] Rename MySql.helper.getFieldValueSync to MySql.helper.getValueSync
* [CHANGED] Function MySql.helper.getFieldValueSync supports now other compare options then "=" (set a table {comparer, value} instead of value in this case)
* [CHANGED] Some Commandhandlers from addCommandHandler with anonym functions to named functions (for autogeneration of docs)

####09.06.2016
------
* [INFO] In Github Wiki are now automatic generated docs about things like Commands.
* [ADDED] New native MySQL Connection (not used yet + no functions yet)
* [ADDED] MySql.helper.getFieldValueSync Function
* [ADDED] MySql.helper.getColumn Function
* [REMOVED] Old mysql_insert_actual.lua file which copied all players in new tables if a new table was created. In the future that should be done on the login function of the user.
* [REMOVED] Seperate Database / -connection for logging. All Tables will be renamed and stored in one database.
* [REMOVED] The tables test_log and nickchange_log are removed
* [REMOVED] Old Function MySQL_GetVar removed
* [GENERAL] All log tables are now renamed to log_*

> <b>No seperate Logdatabase supported anymore, please copy your logging tables to the same database like the data tables.</b>

####08.06.2016
------
* [ADDED] Config Vars to enable, disable or changing limitation of different vehicles
* [ADDED] Config Var "feature.stardard_of_living" to disable standard of living feature (Means you need a specific house value to buy expensive cars)
* [ADDED] Helperfunction getPlayerByDataValue(dataTag, dataValue) - It returns a table with all players that have a specific value in their elementData
* [ADDED] Helperfunction table.copy(table) - a better way to create real copys of tables
* [FIXED] Trash respawns now after finishing Trashmasterjob 
* [FIXED] Missing Tables and Entries are added to the Update SQL Files
* [FIXED] Compass: sometimes the Speed could not calculated. In that case the script spammed a lot of errors. From now on the speed is set to 0 instead.
* [REMOVED] Admincommand /spzw (one hit kill)
* [REMOVED] Injuries in accidents
* [REMOVED] Command /rws to read Weaponstats
* [REMOVED] Admincommand /killfrak
* [REMOVED] Admincommand /tunekmh
* [REMOVED] Admincommand /grav - to change gravity
* [REMOVED] Admincommand /explode - to let players explode
* [MOVED] Admincommand /fixveh to the adminfiles
* [GENERAL] Removed senseless functions and code
* [GENERAL] Changed Filenames config.lua and config_client.lua to example files to prevent issues on updates
* [GENERAL] Update Bugtracker URL in config.lua and config_client.lua
* [CHANGED] The two fastest trains are now slower to prevent desync with the client
* [CHANGED] All Trains have now 6 trailers
* [CHANGED] /adminlist shows now Admins ordered by their adminlvl
* [CHANGED] Admins with a higher Adminlvl then 4 are now completely hidden on /adminlist