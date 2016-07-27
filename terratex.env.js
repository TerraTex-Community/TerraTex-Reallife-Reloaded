var fs = require("fs");
var contentConfig = fs.readFileSync("terratex_reallife/config_env.lua").toString();
var contentDatabaseConfig = fs.readFileSync("terratex_reallife/database_config_env.lua").toString();
for(theKey in process.env) {
    contentConfig = contentConfig.replace(new RegExp("\\$\\{" + theKey + "\\}", "ig"), process.env[theKey]);
    contentDatabaseConfig = contentDatabaseConfig.replace(new RegExp("\\$\\{" + theKey + "\\}", "ig"), process.env[theKey]);
    console.info("SET ENV VAR " + theKey + " WITH VALUE " +  process.env[theKey]);
}
fs.writeFileSync("terratex_reallife/config.lua", contentConfig);
fs.writeFileSync("terratex_reallife/database_config.lua", contentDatabaseConfig);