Jobject = require 'jobject'
Option = require './option'

class Command extends Jobject

  @regex:
    command: /^[A-Za-z0-9]+/g
    singleArg: /<[A-z0-9]+>/g
    multipleArgs: /\[[A-z0-9]+\]/g
    args: /(<[A-z0-9]+>|\[[A-z0-9]+\])/g

  @property 'name'
  @property 'options'
  @property 'action'
  @property 'description'
  @property 'properties'
  @property 'rawCommand'

  constructor: (rawCommand, properties)->

    @properties = properties
    @rawCommand = rawCommand

    @description = @properties['description']
    @action = @properties['action']
   
    @setNameWithRawCommand()
    @setOptionsWithProperties()

  setNameWithRawCommand: ()->
    @name = @extractNameFromRawCommand()

  setOptionsWithProperties: ()->
    @options = @createOptionsFromProperties()

  getOptionWithSwitch: (optionSwitch)->
    for option in @options
      return option if option.shortHand is optionSwitch
      return option if option.longHand is optionSwitch

  extractNameFromRawCommand: ()->
    return @rawCommand.match(Command.regex.command)[0]

  createOptionsFromProperties: ()->
    createdOptions = []

    for optionCommand, description of @properties['options']
      option = new Option optionCommand, description
      createdOptions.push option
    
    return createdOptions

  isMultipleArgs: (commandArg)->
    !!commandArg.match Command.regex.multipleArgs

  isSingleArg: (commandArg)->
    !!commandArg.match Command.regex.singleArg

  run: (args)->
    action = @action
    commandArgs = @rawCommand.match(Command.regex.args)

    applyArgs = @extractSingleArgs commandArgs, args
    multipleArgs = @extractMultipleArgs commandArgs, args
    options = @extractOptionValues args
   
    applyArgs.push multipleArgs

    action.apply options, applyArgs

  # TODO: Refactor
  extractOptionValues: (args)->
    optionObj = {}
    for option in @options
      if option.argType is Option.type.bool
        optionObj[option.name] = false

    for i in [0..args.length - 1]
      arg = args[i]
      if Option.isOptionSwitch arg
        option = @getOptionWithSwitch arg
        if option.argType is Option.type.bool
          optionObj[option.name] = true
        else if option.argType is Option.type.single
          optionObj[option.name] = args[i + 1]
        else if option.argType is Option.type.multiple
          initialI = i
          i++
          optionArgArray = []
          while not (Option.isOptionSwitch args[i])
            optionArgArray.push args[i]
            i++
          optionObj[option.name] = optionArgArray

    return optionObj

  extractSingleArgs: (commandArgs, args)->
    applyArgs = []
    for i in [0..commandArgs.length - 1]

      commandArg = commandArgs[i]
      
      if @isSingleArg commandArg
        applyArgs.push args[i]
      else if @isMultipleArgs commandArg
        break
    return applyArgs

  extractMultipleArgs: (commandArgs, args)->
    multipleArgs = []
    for i in [0..commandArgs.length - 1]

      commandArg = commandArgs[i]
      if @isMultipleArgs commandArg
        for j in [i..args.length - 1]
          break if Option.isOptionSwitch args[j]
          multipleArgs.push args[j]
        break
    return multipleArgs


module.exports = Command