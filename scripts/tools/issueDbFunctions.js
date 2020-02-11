// globals: db, issues
//

/**
 *
 * @param issueData
 * @returns {Promise<boolean>}
 */
exports.doesIssueExist = async (issueData) => {
    // check for .message .line .file .logType
};

/**
 *
 * @param issueData
 * @returns {Promise<{ID, github_id}>}
 */
exports.getIssueFromDB = async (issueData) => {
    // check for .message .line .file .logType
};

/**
 *
 * @param issueData
 * @returns {Promise<void>}
 */
exports.writeIssueToDatabase = async (issueData) => {
    // check for {
    //   "message": "loaded 110 vehicles for shops",
    //   "line": 82,
    //   "time": 1581349761000,
    //   "user": "server",
    //   "stacktrace": "stack traceback:\n\t...atex_reallife\\SYSTEM\\logging\\logging_server_func.lua:16: in function <...atex_reallife\\SYSTEM\\logging\\logging_server_func.lua:15>\n\t[C]: in function 'outputDebugString'\n\t..._reallife\\SYSTEM\\vehsys\\shop\\vehicle_shop_server.lua:82: in function 'generateVehicleShopList'\n\t..._reallife\\SYSTEM\\vehsys\\shop\\vehicle_shop_server.lua:48: in function <..._reallife\\SYSTEM\\vehsys\\shop\\vehicle_shop_server.lua:39>",
    //   "level": "INFO",
    //   "logType": "server",
    //   "file": "terratex_reallife\\SYSTEM\\vehsys\\shop\\vehicle_shop_server.lua"
    // }
};

exports.updateIssueToDatabase = async (issueId, countUp = false, githubId = null) => {
    // if countUp = true counted + 1
    // if githubId !== null update it
};

/**
 *
 * @param dbId
 * @param issueData
 */
exports.updateGitHubIssue = async (dbId, githubId = null, issueData) => {
    // create github Issue - if older then 30 days recreate
    //    @see http://github-tools.github.io/github/docs/3.2.3/Issue.html
};
