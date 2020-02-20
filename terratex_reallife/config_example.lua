-- not used in all files... will be set later
--- @field isDevServer boolean
config={}

--- Is Development Server = Enable Whitelisting and Disable some Functions that
--- could cause issues if a dev server and a live server are running on same database
--- @type boolean
config["isDevServer"]=false

-- Name of Owner
config["owner"]="[TTeam]Geramy92"

--Supportemail
config["supportmail"]="support@terratex.eu"

-- array with all domains which should not found in Anti-Advertise-Functions
config["domains"]={"terratex.eu"}

-- Main Domain / will later be set in credits or info guis
config["maindomain"]="http://terratex.eu"

--Bugtracker URL
config["bugdomain"]="https://github.com/TerraTex-Community/TerraTex-Reallife-Reloaded/issues";

--IP or Domain to Teamspeak3
config["teamspeak"]="terratex.eu"

--Clantag: will protect Register with this tag or names of Clanmembers without this tag (Will set that [ABC]DEF is the same like DEF in checkups)
config["clantag"]="[TTeam]"

--Community Name - The Name of the Community, which should be written f.e. in credits
config["communityname"]="TerraTex"

--Mappername
config["mappername"]="[TTeam]Blizard"

--Scriptername
config["scriptername"]="[TTeam]Geramy92"

--24h Restart type
-- Options:
-- GMX - Gamemoderestart at 3/4 o'clock
-- SHUTDOWN  - complete Shutdown of the server at 3/4 o'clock  (recommend but you have to setup a automatic restart Script on your host)
-- NONE - No Restart at 3/4 o'clock (not recommend)
config["dailyrestarttype"]="GMX"


-- What should be done, if a user is afk but does not use /afk
-- Options: "kick" - will kick the player or "afk" - will set player in afk mode automatically
config["afk.punish"] = "kick"
-- The play time of a player will not count up after afk kick for xxx minutes
config["afk.stop_play_time"] = 25

config["gold.price"] = 10000

-- ################  FEATURE SETTINGS  #################
-- After going online where to spawn:
-- always = You always spawn, where you went offline
-- gmx = You always spawn, where you went offline as long as there was no GMX
-- hour = You always spawn, where you went offline for one hour
-- never = you always spawn where you selected to spawn - not where went offline
config["feature.spawnWhereOffline"] = "always"

-- Enable or Disable Spawn Position of Vehicles. If this is disabled after a server restart vehicles will always spawn at
-- their park position
config["feature.spawnVehiclesToLastPosition"] = true

-- Enable or Disable Standard of Living (Means you need a specific house value to buy expensive cars)
config["feature.stardard_of_living"] = true

-- Pizzaroller Limitierung false = aus | zahlenwert = max km/h Default Roller:
config["feature.limiter.pizza"] = 50

-- Rookieroller / Faggio Limitierung false = aus | zahlenwert = max km/h Default Roller:
config["feature.limiter.faggio"] = 50

-- Quad false = aus | zahlenwert = max km/h Default Roller:
config["feature.limiter.quad"] = 90

-- Waffentruck Limitierung false = aus | zahlenwert = max km/h Default Roller:
config["feature.limiter.muntruck"] = 100


-- #################### Web API ####################
config["api.user"] = "user"
config["api.password"] = "password"

