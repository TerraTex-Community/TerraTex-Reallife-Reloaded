####13.07.2016
--------------
* [FIXED] #73 Bug with old Drug and Mats GUI
* [CODE-CHANGE] #15 Split bansys.lua in multiple files

####11.07.2016
--------------
* [ADDED] #67 If a married couple get a child it will have a real name and will cost money on paydays (random years => one year = one PayDay)
* [ADDED] #67 #66 Add some food to sex effect
* [CHANGED] #63 Loan and needed Skillpoints of sea cleaner
* [REMOVED] #67 You don't get unrealistic one second childs anymore.
* [FIXED] #61 You can't fill more fuel in vehicle as the capacity of vehicles anymore.
* [FIXED] #62 Informations about changes on Players that are online were send to everyone
* [FIXED] #62 giverank in manage ui was not working correctly
* [CODE-ADD] Added Handler Function addAcceptEvent(acceptName, function)
* [CODE-CHANGE] Complete rework of /accept with new Handler function and separation in different functions

####07.07.2016
--------------
* [CHANGED] New Login UI
* [CHANGED] New Register UI
* [FIXED] #60 Fixed a Bug with the bus job
* [FIXED] #60 Wrong Points Calculation in Weapon test of the N.A.M.E.
* [FIXED] #60 An Issue with the mechanic command

####06.07.2016
--------------
* [ADDED] Factionmanagement UI and command /fmanage
* [FIXED] A Bug related to isConsole changes
* [FIXED] Some Issues with the pizza job

####05.07.2016
--------------
* [ADDED] New Gold Item: SkillBooster
* [ADDED] New Console Command: /listplayers
* [ADDED] Helperfunction isConsole(element)
* [FIXED] #51 Some Fixes for Pizzajob

####04.07.2016
--------------
* [REMOVED] old Housemaps
* [ADDED] #50 Overview in new Command /fmanage

####30.06.2016
--------------
* [CHANGED] #40 New Fuel calculation

####29.06.2016
------
* [CODE-CHANGE] Changes CSS Files for Bootstrap and Custom to SCSS. SCSS Source Files are delivered additional to the generated CSS Files.

Release 1.1.0
=============
####24.06.2016
------
* [ADDED] #36 Implement complete new HUD (Weapon, Ammo, Clock, ...)
* [REMOVED] EgoMode

####23.06.2016
------
* [ADDED] #31 Functionallity of HufeisenBooster, FuelBooster and FoodBooster
* [ADDED] #31 Closebutton to Gold Shop
* [CHANGED] #35 New Fuel Calculation
* [REMOVED] #32 removed Premium Tables from SQL Files
* [CHANGED] #33 add a Fueltank to all Jobvehicles

####22.06.2016
------
* [ADDED] #31 Gold Items are now buyable
* [FIXED] Do not save Biz on Dev Server

####21.06.2016
------
* [ADDED] Some basic files for Browser-Based-UI
* [FIXED] Issue on User Creating with user_gold table
* [FIXED] Some Exceptions on Meeresreiniger - again
* [CHANGED] /pcolor is now usable by everyone (costs: vehicle color - 7500$ ; light colors - 2500$)

####20.06.2016
------
* [ADDED] #31 Basic Gold Table Creation
* [REMOVED] #32 removed Premium exclusive Vehicles
* [REMOVED] #32 /spawnchange job
* [REMOVED] #32 /accept premium
* [REMOVED] #32 /buypremium
* [REMOVED] #32 /premium and Premium Info GUI
* [REMOVED] #32 Debug from Pizzajob
* [REMOVED] #32 removed Premium from Social stuff
* [REMOVED] #32 Removed Premium from Presents for Christmas
* [REMOVED] #32 Removed Premium from Insurances
* [FIXED] Next try to fix clicksystem
* [CHANGED] #32 renamed /spawnchange premium to /spawnchange vehicle (can now be used without premium)
* [CHANGED] #32 /healme can now used by everyone who own a house with a room and is in this house
* [CHANGED] Moved Admincommand /setcolor to the adminsection of the script (fun.lua)
* [CHANGED] #32 To fish on all boats it is required to own an advanced (idustrial) fishing license instead of premium
* [CHANGED] #32 All old Premium Vehicles are now normales Vehicles with the old price multiplied with 10

Release 1.0.0
=============
####20.06.2016
------
* [ADDED] #5 Afk-config option afk.punish
* [REMOVED] Duplicated math.round function on client
* [FIXED] #28 Exception in flug_gui.lua
* [FIXED] #30 Show a message instead of getting an exception
* [FIXED] #29 Fixed Exceptions in Meeresreiniger
* [REMOVED] removed some debug that are not needed anymore

####18.06.2016
------
* [REMOVED] #26 Old RookieGuide (/snt) because it is too old and outdated

####17.06.2016
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