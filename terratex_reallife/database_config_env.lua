-- This File is for using in a build pipeline
-- To replace all variables in this file with enviromentvariables use the node terratex.env.js (nodejs is required)
-- be sure that all variables are set in the build enviroment
config["password_hash"]="${PASSWORD_HASH}"
config["mysqlhost"]="${DB_HOST}"
config["mysqluser"]="${DB_USER}"
config["mysqlpassword"]="${DB_PASSWORD}"
config["mysqldb"]="${DB_DB}"
