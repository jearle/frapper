Jobject = require 'jobject'

# Option = require './option'
Command = require './command'
CLIWriter = require './cliwriter'

class Program extends Jobject

  constructor: (commandProperties)->
    @property 'commandProperties'
    @property 'commands'

    @setCommandProperties commandProperties

    @setCommandsFromCommandProperties()

  run: ()->
    commandName = @getCommandNameFromArgv()
    commandArgs = @getCommandArgs()

    command = @commands()[commandName]
    command.run commandArgs

  setCommandsFromCommandProperties: ->
    commands = {}
    for rawCommand, properties of @commandProperties()
      command = new Command rawCommand, properties
      commands[command.name()] = command
    @setCommands commands

  getCommandNameFromArgv: ()->
    commandArgs = process.argv.slice 2
    commandName = commandArgs[0]
    return commandName

  getCommandArgs: ()->
    return process.argv.slice 3

# class Program extends Jobject
  
#   @cliwriter: new CLIWriter()

#   constructor: (options)->
#     @property 'version'
#     @property 'options'
#     @property 'commands'

#     @setVersion options.version
#     @setOptions options.options
#     @setCommands options.commands

#   setOptions: (options)->
#     @_options = {} if @_options is null

#     @addOption command, description for command, description of options

#   setCommands: (commands)->
#     @_commands = {} if @_commands is null
    
#     @addCommand command, func for command, func of commands

#   addOption: (command, description)->
#     option = new Option command, description 
#     @_options[option.shortHand()] = option
#     @_options[option.name()] = option

#   addCommand: (commandString, func)->
#     command = new Command commandString, func
#     @_commands[command.name()] = command

#   processCommandName: ()->
#     commandName = process.argv[2]
#     return commandName

#   processCommandArguments: ()->
#     args = []
#     if process.argv.length == 3
#       return args

#     for i in [3..process.argv.length - 1]
#       args.push process.argv[i]
#     return args

#   shouldDisplayHelp: (commandName)->
#     shouldDisplayHelp = no
#     if commandName is '-h' or commandName is '--help'
#       shouldDisplayHelp = yes
#     return shouldDisplayHelp

#   shouldDisplayVersion: (commandName)->
#     shouldDisplayVersion = no
#     if commandName is '-v' or commandName is '--version'
#       shouldDisplayVersion = yes
#     return shouldDisplayVersion

#   displayVersion: ()->
#     Program.cliwriter.displayVersion @version()

#   exec: ()->
#     commandName = @processCommandName()

#     if @shouldDisplayVersion commandName
#       @displayVersion()
#       process.exit 1

#     # if @shouldDisplayHelp(commandName)
#     #   @displayHelp()

#     if commandName is undefined
#       Program.cliwriter.noCommandSupplied()
#       process.exit 1

#     command = @commands()[commandName]
#     if command is undefined
#       Program.cliwriter.commandNotFoundWithName commandName
#       process.exit 1
    
#     args = @processCommandArguments()
    
#     command.func args

module.exports = Program