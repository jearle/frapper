Jobject = require 'jobject'

# Option = require './option'
Command = require './command'
CLIWriter = require './cliwriter'

class Program extends Jobject
  
  @property 'commandProperties'
  @property 'commands'
  
  constructor: (commandProperties)->
    @commandProperties = commandProperties

    @setCommandsFromCommandProperties()

  run: ()->
    commandName = @getCommandNameFromArgv()
    commandArgs = @getCommandArgs()

    command = @commands[commandName]
    command.run commandArgs

  setCommandsFromCommandProperties: ->
    commands = {}
    for rawCommand, properties of @commandProperties
      command = new Command rawCommand, properties
      commands[command.name] = command
    @commands = commands

  getCommandNameFromArgv: ()->
    commandArgs = process.argv.slice 2
    commandName = commandArgs[0]
    return commandName

  getCommandArgs: ()->
    return process.argv.slice 3

module.exports = Program