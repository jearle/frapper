Jobject = require 'jobject'
Option = require './option'

class Command extends Jobject

  @regex:
    command: /^[A-z0-9]+/g
    singleArg: /<[A-z0-9]+>/g
    multipleArgs: /\[[A-z0-9]+]/g

  @type:
    multiple: 0
    single: 1

  constructor: (properties)->
    @property 'name'
    @property 'argType'
    @property 'options'
    @property 'func'
    @property 'description'
    @property 'properties'
    @property 'rawCommand'

    @setProperties properties
    @setRawCommand properties

    commandName = @findCommandName @rawCommand()
    @setName commandName

    description = @findDescriptionInProperties @properties()

    @setDescription description

    argType = @determineArgType @rawCommand()
    @setArgType argType

    commandOptions = @findCommandOptionsInProperties @properties()
    options = @createOptions commandOptions
    @setOptions options

  setProperties: (properties)->
    for key, val of properties
      @_properties = val
      break

  setRawCommand: (properties)->
    for key, val of properties
      @_rawCommand = key
      break

  findCommandName: (command)->
    return command.match(Command.regex.command)[0]

  findDescriptionInProperties: (properties)->
    return properties['description']

  findCommandOptionsInProperties: (properties)->
    return properties['options']

  findSingleArg: (command)->
    matches = command.match(Command.regex.singleArg)
    if matches
      return matches[0]

  findMultipleArg: (command)->
    matches = command.match(Command.regex.multipleArgs)
    if matches
      return matches[0]

  determineArgType: (command)->
    if @findSingleArg command
      argType = Command.type.single
    else
      argType = Command.type.multiple
    return argType

  createOptions: (options)->
    createdOptions = []
    for optionCommand, description of options
      createdOptions.push new Option optionCommand, description
    return createdOptions

  func: ()->
    @_func.apply @, arguments

module.exports = Command