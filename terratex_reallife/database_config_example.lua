--passwort Hash Algo ...
--Options:
--   -> md5    (old System... not recommend)
--   -> osha256   (Sha256 before MTA:SA 1.4.1)
--   -> sha256    (Sha256 // avaible after MTA:SA 1.4.1)
--   -> sha512    (Sha512 // avaible after MTA:SA 1.4.1  -- recommend)
config["password_hash"]="sha512"

--MYSQL CONFIG:
config["mysqlhost"]="localhost"
config["mysqluser"]=""
config["mysqlpassword"]=""
config["mysqldb"]=""

-- This Optional enables the database Update and Install system
-- You should only used it, if you want a clean new install or you want to use all updates from git without own changes
-- It is highly recommend to disable this option if you change any code that is related to the database or if you change things in the database structure
-- In this case: Import & Modify SQL Files manualy
-- @info Not Implemented Yet!
config["database_updater"] = true;