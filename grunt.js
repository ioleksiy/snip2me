/*global module:false*/
module.exports = function(grunt) {
  grunt.loadNpmTasks('grunt-shell');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.initConfig({
    meta: {
      version: '0.1.0',
      banner: '/*! snip2me - v<%= meta.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
        '* http://snip2.me/\n' +
        '* Copyright (c) 2011-<%= grunt.template.today("yyyy") %> ' +
        'Oleksii Glib; Licensed MIT */'
    },
    files: ['grunt.js', 'lib/*coffee'],
    shell: {
        coffee: {
            command: 'coffee -c -j s2m.js -o dist/ lib/'
        },
        rmf: {
        	command: 'rm -r ./dist'
        }
    },
    lint: {
      files: ['grunt.js', 'dist/s2m.js']
    },
    coffeelintOptions: {
      "camel_case_classes": {
        "level": "ignore"
      }
    },
    coffeelint: {
      app: ['lib/*.coffee']
    },
    min: {
      dist: {
        src: ['<banner:meta.banner>', 'dist/s2m.js'],
        dest: 'dist/s2m.min.js'
      }
    },
    watch: {
      files: '<config:files>',
      tasks: 'default'
    },
    jshint: {
      options: {
        curly: true,
        eqeqeq: true,
        immed: true,
        latedef: true,
        newcap: true,
        noarg: true,
        sub: true,
        undef: true,
        boss: true,
        eqnull: true
      },
      globals: {}
    },
    uglify: {}
  });

  grunt.registerTask('default', 'coffeelint shell:rmf shell:coffee min');
};
