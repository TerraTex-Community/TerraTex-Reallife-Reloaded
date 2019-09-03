module.exports = function(grunt) {
    const deployPath = grunt.option('path') || 'dev';

    grunt.initConfig({
        'copy': {
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

    grunt.registerTask('default', ['clean:deploy', 'copy:terratex', 'copy:scoreboard']);

};
