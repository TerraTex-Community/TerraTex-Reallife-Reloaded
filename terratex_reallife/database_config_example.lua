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
