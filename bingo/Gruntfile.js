module.exports = function(grunt) {

  grunt.initConfig({
    elm: {
      compile: {
        files: {
          "bingo.js": ["Bingo.elm"]
        }
      }
    },
    watch: {
      elm: {
        files: ["Bingo.elm", "BingoUtils.elm"],
        tasks: ["elm"]
      }
    },
    clean: ["elm-stuff/build-artifacts"]
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-elm');

  grunt.registerTask('default', ['elm']);

};
