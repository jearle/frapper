class Command
  
  @regex:
    command: /^[A-z0-9]+/g
    singleArg: /<[A-z0-9]+>/g
    multipleArgs: /\[[A-z0-9]+]/g

  @type:
    multiple: 0
    single: 1

  _name: ''
  _argType: null
  _func: null

  constructor: (command, func)->
    argType = @determineArgType command
    @setArgType argType

    name = @findCommandName command
    @setName name

    @setFunc func

  findCommandName: (command)->
    return command.match(Command.regex.command)[0]

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

  setArgType: (type)->
    @_argType = type

  argType: ()->
    return @_argType

  setName: (name)->
    @_name = name

  name: ()->
    return @_name

  setFunc: (func)->
    @_func = func

  func: ()->
    @_func.apply @, arguments

module.exports = Command