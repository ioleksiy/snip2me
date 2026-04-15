/*global module:false*/
module.exports = function(grunt) {
  grunt.loadNpmTasks('grunt-shell');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-contrib-watch');

  var bundleSources = [
    'lib/_Utils.coffee',

    'lib/SyntaxToken.coffee',
    'lib/SyntaxTokens.coffee',
    'lib/SyntaxTokens.CSharp.coffee',

    'lib/Description.coffee',
    'lib/Factory.coffee',
    'lib/CodeReader.coffee',

    'lib/Analyzer.coffee',
    'lib/Analyzer.NewLine.coffee',
    'lib/Analyzer.Space.coffee',
    'lib/Analyzer.Padding.coffee',
    'lib/Analyzer.String.coffee',
    'lib/Analyzer.Delimiter.coffee',
    'lib/Analyzer.CppComments.coffee',
    'lib/Analyzer.UnixComments.coffee',

    'lib/SyntaxParser.coffee',
    'lib/ParserFactory.coffee',
    'lib/SyntaxParsers.CSharp.coffee',
    'lib/SyntaxParsers.CoffeeScript.coffee',
    'lib/SyntaxParsers.Java.coffee',
    'lib/SyntaxParsers.Ruby.coffee',

    'lib/Scheme.coffee',
    'lib/SchemeFactory.coffee',
    'lib/Schemes.VS2010.coffee',
    'lib/Schemes.Aptana.coffee',

    'lib/Painter.coffee',
    'lib/Painters.Base.coffee',
    'lib/PainterFactory.coffee',
    'lib/Painters.Bases.Border.coffee',
    'lib/Painters.Code.coffee',

    'lib/xWrapper.coffee'
  ];

  grunt.initConfig({
    meta: {
      version: '0.1.0',
      banner: '/*! snip2me - v<%= meta.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
        '* http://snip2.me/\n' +
        '* Copyright (c) 2011-<%= grunt.template.today("yyyy") %> ' +
        'Oleksii Glib; Licensed MIT */'
    },
    files: ['grunt.js'].concat(bundleSources),
    bundleSources: bundleSources,
    shell: {
        coffee: {
        command: function() {
         return 'for f in ' + grunt.config.get('bundleSources').join(' ') +
           '; do cat "$f"; echo; done | coffee --compile --stdio > dist/s2m.js';
        }
        },
        minify: {
          command: './node_modules/.bin/terser dist/s2m.js -o dist/s2m.min.js --compress --mangle'
        },
        rmf: {
	        command: 'rm -rf ./dist && mkdir -p ./dist'
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

  grunt.registerTask('default', ['coffeelint', 'shell:rmf', 'shell:coffee', 'shell:minify']);
};
