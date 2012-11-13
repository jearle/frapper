// Generated by CoffeeScript 1.4.0
(function() {
  var Command, Program, exec, path, should, sys;

  should = require('should');

  Program = require('../').Program;

  Command = require('../').Command;

  sys = require('sys');

  exec = require('child_process').exec;

  path = require('path');

  describe('Program', function() {
    var program, testProps;
    testProps = {
      'test <name> [args]': {
        description: 'A test with multiple attributes.',
        options: {
          '-b --boolean': 'A boolean test option.',
          '-v --variable <arg>': 'A single variable test option.',
          '-a --array [args]': 'An array variable test option.'
        },
        action: function(name, args) {
          console.log(name);
          return console.log(args);
        }
      },
      'model <name> [attrs]': {
        description: 'A test command to generate models',
        action: function(name, attrs) {
          console.log(name);
          return console.log(attrs);
        }
      }
    };
    program = new Program(testProps);
    it('should have a commandProperties getter that returns a value equal to testProps', function() {
      return program.commandProperties().should.eql(testProps);
    });
    return it('should have a commands getter that return an object with properties test and model that point to Command objects', function() {
      program.commands().test.should.be.an["instanceof"](Command);
      return program.commands().model.should.be.an["instanceof"](Command);
    });
  });

}).call(this);
