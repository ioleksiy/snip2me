/*global module:false*/
module.exports = function(grunt) {
  grunt.loadNpmTasks('grunt-shell');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-watch');
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
	        command: 'rm -rf ./dist'
        }
    },
    coffeelintOptions: {
      "camel_case_classes": {
        "level": "ignore"
      }
    },
    coffeelint: {
      app: ['lib/*.coffee']
    },
    uglify: {
      options: {
        banner: '<%= meta.banner %>\n'
      },
      dist: {
        files: {
          'dist/s2m.min.js': ['dist/s2m.js']
        }
      }
    },
    watch: {
      files: '<%= files %>',
      tasks: ['default']
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
  });

  grunt.registerTask('default', ['coffeelint', 'shell:rmf', 'shell:coffee', 'uglify']);
};
