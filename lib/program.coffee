Option = require './option'
Command = require './command'
CLIWriter = require './cliwriter'

class Program
  
  @cliwriter: new CLIWriter()

  _version: null
  _options: {}
  _commands: {}

  constructor: (options)->
    @setVersion options.version
    @setOptions options.options
    @setCommands options.commands

  version: ()->
    return @_version

  setVersion: (version)->
    @_version = version

  options: ()->
    return @_options

  setOptions: (options)->
    @addOption command, description for command, description of options

  addOption: (command, description)->
    option = new Option command, description 
    @_options[option.shortHand()] = option
    @_options[option.name()] = option

  commands: ()->
    return @_commands

  setCommands: (commands)->
    @addCommands command, func for command, func of commands
    
  addCommands: (commandString, func)->
    command = new Command commandString, func
    @_commands[command.name()] = command

  processCommandName: ()->
    commandName = process.argv[2]
    return commandName

  processCommandArguments: ()->
    args = []
    if process.argv.length == 3
      return args

    for i in [3..process.argv.length - 1]
      args.push process.argv[i]
    return args

  exec: ()->
    commandName = @processCommandName()

    if commandName is undefined
      Program.cliwriter.noCommandSupplied()
      process.exit 1

    command = @commands()[commandName]
    if command is undefined
      Program.cliwriter.commandNotFoundWithName commandName
      process.exit 1
    
    args = @processCommandArguments()
    
    command.func args

module.exports = Program