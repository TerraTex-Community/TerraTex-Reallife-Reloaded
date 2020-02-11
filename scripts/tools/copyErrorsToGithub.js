/**
 In order to use this script you have to import to your MTA:SA database the following sql:

 CREATE TABLE `mta_terratex_reallife`.`log_errors_to_github` (
 `ID` INT NOT NULL AUTO_INCREMENT ,
 `message` TEXT NOT NULL ,
 `line` INT NOT NULL ,
 `time` INT NOT NULL ,
 `user` VARCHAR(255) NOT NULL ,
 `stacktrace` TEXT NOT NULL ,
 `level` VARCHAR(50) NOT NULL ,
 `logType` VARCHAR(15) NOT NULL ,
 `file` TEXT NOT NULL ,
 `github_id` INT NULL DEFAULT NULL ,
 `counted` INT NOT NULL DEFAULT '1' ,
 PRIMARY KEY (`ID`)) ENGINE = InnoDB;


 usage of script: node copyErrorsToGithub.js githubOAuthKey
 **/

const mariadb = require('mariadb');
const fs = require('fs');
const readline = require('readline');
const glob = require("glob");
const {copyLuaFile, cleanLuaFiles} = require("./loadLuaConfigFile");

copyLuaFile("../../terratex_reallife/database_config.lua");

global.config = {};
require("./database_config.lua.js");
const {writeIssueToDatabase, updateIssueToDatabase, getIssueFromDB, updateGitHubIssue, doesIssueExist} = require("./issueDbFunctions");

async function run() {
    global.db = await mariadb.createConnection(
            {
                host: config.mysqlhost,
                user: config.mysqluser,
                password: config.mysqlpassword,
                database: config.mysqldb
            }
    );

    const oauthkey = process.argv[2];
    if (!oauthkey || oauthkey.length === 0) {
        console.error("usage: node copyErrorsToGithub.js [OAuthKey]");
        return;
    }

    const GitHub = require('github-api');
    const github = new GitHub({
        token: oauthkey
    });
    global.issues = github.getIssues("TerraTex-Community", "TerraTex-Reallife-Reloaded");

    const files = glob.sync("../../**/debug_json.log.log");
    console.log(files);

    for (const file of files) {
        fs.renameSync(file, file + ".copied.log");

        const fileStream = fs.createReadStream(file + ".copied.log");

        const rl = readline.createInterface({
            input: fileStream,
            crlfDelay: Infinity
        });

        for await (const line of rl) {
            // Each line in input.txt will be successively available here as `line`.
            const issueData = JSON.parse(line)[0];
            if (issueData.level.toLocaleLowerCase() !== "warning"
                    && issueData.level.toLocaleLowerCase() !== "error") {
                continue;
            }

            if ( await doesIssueExist(issueData)) {
                const issue = await getIssueFromDB(issueData);
                const githubId = await updateGitHubIssue(issue.ID, issue.github_id, issueData);
                await updateIssueToDatabase(issue.ID, true, githubId);
            } else {
                const dbId = await writeIssueToDatabase(issueData);
                const githubId = await updateGitHubIssue(dbId, null, issueData);
                await updateIssueToDatabase(dbId, false, githubId);
            }
        }
    }

    cleanLuaFiles();
    process.exit(0);
}

run();
