const fs = require("fs");
const path = require("path");

const files = [];

exports.copyLuaFile = (filePath) => {
    let luaFile = fs.readFileSync(filePath).toString();
    luaFile = luaFile.replace(/--.*\n/ig, "");
    files.push(path.basename(filePath) + ".js");

    fs.writeFileSync( path.basename(filePath) + ".js", luaFile);
};

exports.cleanLuaFiles = () => {
    for (const file of files) {
        fs.unlinkSync(file);
    }
};
