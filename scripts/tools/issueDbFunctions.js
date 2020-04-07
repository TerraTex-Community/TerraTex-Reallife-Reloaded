// globals: db, issues
//

/**
 *
 * @param {{
  message: string,
  line: number,
  time: number,
  user: string,
  stacktrace: string,
  additionalData: string,
  level: string,
  logType: string,
  file: string}} issueData
 * @returns {Promise<boolean>}
 */
exports.doesIssueExist = async (issueData) => {
    const rows = await db.query(`
SELECT * 
FROM log_errors_to_github 
WHERE 
  message = ? AND 
  line = ? AND 
  file = ? AND 
  logType = ?            
    `, [issueData.message, issueData.line, issueData.file, issueData.logType]);

    const entry = rows[0];
    return !!entry;
};

/**
 *
 * @param  {{
  message: string,
  line: number,
  time: number,
  user: string,
  stacktrace: string,
  additionalData: string,
  level: string,
  logType: string,
  file: string}} issueData
 * @returns {Promise<{ID, github_id}>}
 */
exports.getIssueFromDB = async (issueData) => {
    const rows = await db.query(`
SELECT * 
FROM log_errors_to_github 
WHERE 
  message = ? AND 
  line = ? AND 
  file = ? AND 
  logType = ?            
    `, [issueData.message, issueData.line, issueData.file, issueData.logType]);

    const entry = rows[0];
    if (entry)
        return entry;
    else
        return false;
};

/**
 *
 * @param  {{
  message: string,
  line: number,
  time: number,
  user: string,
  stacktrace: string,
  additionalData: string,
  level: string,
  logType: string,
  file: string}} issueData
 * @returns {Promise<void>}
 */
exports.writeIssueToDatabase = async (issueData) => {
    const rows = await db.query(`
INSERT INTO log_errors_to_github (
    message, line, time, user, stacktrace, level, logType, file, additionalData
)
VALUES (?,?,?,?,?,?,?,?,?);         
    `, [
        issueData.message, issueData.line, (issueData.time /1000),
        issueData.user, issueData.stacktrace, issueData.level, issueData.logType,
        issueData.file, JSON.stringify(issueData.additionalData, null,4)
    ]);


    return rows.insertId;
};

/**
 *
 * @param issueId
 * @param countUp
 * @param githubId
 * @returns {Promise<void>}
 */
exports.updateIssueToDatabase = async (issueId, countUp = false, githubId = null) => {
    // if countUp = true counted + 1
    // if githubId !== null update it
    let updateCounted = "";
    let updategithub = "";
    let updateComma = "";
    let updateValues = [];

    if (countUp) {
        updateCounted = "counted = counted + 1";
        if (githubId) {
            updateComma = ",";
        }
    }
    if (githubId) {
        updategithub = "github_id = ?";
        updateValues = [githubId];
    }
    updateValues.push(issueId);

    const rows = await db.query(`
UPDATE log_errors_to_github SET    
${updateCounted}${updateComma}${updategithub}
WHERE ID = ?
    `, updateValues);
};

/**
 *
 * @param dbId
 * @param githubId
 * @param  {{
  message: string,
  line: number,
  time: number,
  user: string,
  stacktrace: string,
  level: string,
  additionalData: string,
  logType: string,
  file: string}} issueData
 */
exports.updateGitHubIssue = async (dbId, githubId = null, issueData) => {
    let oldGithubText = "";
    if (githubId) {
        const data = issues.getIssue(githubId);
        if (data.state === "open" ||
                getDaysBetween(new Date(data.closed_at), new Date()) <= 30) {
            return githubId;
        }
        oldGithubText = `Old Github Ticket to this Issue: #${githubId}`
    }

    const stackmark = "```";

    const newIssueData = await issues.createIssue({
        title: "From Error log: " + issueData.message,
        body: `
- Database Id: ${dbId}
- Message: ${issueData.message}
- Stacktrace: 
${stackmark}
${issueData.stacktrace}
${stackmark}
- Level: ${issueData.level}
- Source: ${issueData.file}:${issueData.line}
- LogType: ${issueData.logType}
- Appeared at User: ${issueData.user} 
- Stacktrace: 
${stackmark}
${JSON.stringify(issueData.additionalData, null,4)}
${stackmark}

${oldGithubText}       
        `,
        labels: ["bug", "generated"]
    });

    return newIssueData.data.number;
};

function getDaysBetween(date1, date2) {
    if (isNaN(date1.getTime())) return 0;
    let diff = date2.getTime() - date1.getTime();
    diff = diff / 1000 / 3600 / 24;
    return diff;
}
