module.exports = function(grunt) {
    const deployPath = grunt.option('path') || 'dev';
    const moment = require("moment");

    grunt.initConfig({
        'copy': {
            saveLogs: {
                expand: true,
                src: '**/*',
                dest: `${deployPath}/oldLogs/${moment().format('YYYYMMDDHHmmss')}`,
                cwd: deployPath + "/terratex_reallife/LOGS",
                dot: true
            },
            terratex: {
                expand: true,
                src: '**/*',
                dest: deployPath + "/terratex_reallife",
                cwd: './terratex_reallife',
                dot: true
            },
            scoreboard: {
                expand: true,
                src: '**/*',
                dest: deployPath + "/scoreboard_custom_terratex",
                cwd: './scoreboard_custom_terratex',
                dot: true
            },
            backup: {
                expand: true,
                src: '*config.lua',
                dest: deployPath,
                cwd: deployPath + "/terratex_reallife",
                dot: true
            },
            restoreBackup: {
                expand: true,
                src: '*config.lua',
                dest: deployPath + "/terratex_reallife",
                cwd: deployPath,
                dot: true
            }
        },
        'clean': {
            'deploy': {
                options: {
                    force: true,
                },
                src: [deployPath + '/scoreboard_custom_terratex', deployPath + '/terratex_reallife']
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-clean');

    grunt.registerTask('default', ['copy:backup', 'clean:deploy', 'copy:terratex', 'copy:scoreboard', 'copy:restoreBackup']);
    grunt.registerTask('logs', ['copy:saveLogs']);

};
