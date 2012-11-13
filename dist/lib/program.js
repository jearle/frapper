// Generated by CoffeeScript 1.4.0
(function() {
  var CLIWriter, Command, Jobject, Program,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Jobject = require('jobject');

  Command = require('./command');

  CLIWriter = require('./cliwriter');

  Program = (function(_super) {

    __extends(Program, _super);

    function Program(commandProperties) {
      this.property('commandProperties');
      this.property('commands');
      this.setCommandProperties(commandProperties);
      this.setCommandsFromCommandProperties();
    }

    Program.prototype.run = function() {
      var command, commandArgs, commandName;
      commandName = this.getCommandNameFromArgv();
      commandArgs = this.getCommandArgs();
      command = this.commands()[commandName];
      return command.run(commandArgs);
    };

    Program.prototype.setCommandsFromCommandProperties = function() {
      var command, commands, properties, rawCommand, _ref;
      commands = {};
      _ref = this.commandProperties();
      for (rawCommand in _ref) {
        properties = _ref[rawCommand];
        command = new Command(rawCommand, properties);
        commands[command.name()] = command;
      }
      return this.setCommands(commands);
    };

    Program.prototype.getCommandNameFromArgv = function() {
      var commandArgs, commandName;
      commandArgs = process.argv.slice(2);
      commandName = commandArgs[0];
      return commandName;
    };

    Program.prototype.getCommandArgs = function() {
      return process.argv.slice(3);
    };

    return Program;

  })(Jobject);

  module.exports = Program;

}).call(this);