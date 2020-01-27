const {copyLuaFile, cleanLuaFiles} = require("./loadLuaConfigFile.js");

const mariadb = require('mariadb');
const uid = require('uuid/v4');
const crypto = require('crypto');
const randomString = require("randomstring");
copyLuaFile("../../terratex_reallife/database_config.lua");

global.config = {};
require("./database_config.lua.js");

async function run() {
    const conn = await mariadb.createConnection(
            {
                host: config.mysqlhost,
                user: config.mysqluser,
                password: config.mysqlpassword,
                database: config.mysqldb
            }
    );

    const nickname = process.argv[2];
    if (nickname) {
        const rows = await conn.query("SELECT * FROM user WHERE Nickname = ?", [nickname]);
        const user = rows[0];

        if (user) {
            const salt = uid();
            const password = randomString.generate(7);

            const crypt = salt + password;
            const hash = crypto.createHash('sha512')
                    .update(crypt)
                    .digest('hex');

            await conn.query("UPDATE user SET Salt = ?, Passwort = ? WHERE Nickname = ?",
                    [salt, hash, nickname]);

            console.info("New Password is: " + password);
        } else {
            console.error("User doesn't exist.");
        }
    } else {
        console.error("usage: node setNewPassword.js [nickname]");
    }

    cleanLuaFiles();
    process.exit(0);
}

run();
