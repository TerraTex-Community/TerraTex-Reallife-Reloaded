
####10.06.2016
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