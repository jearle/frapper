Jobject = require 'jobject'

class Option extends Jobject
  @regex:
    longHand: /--[A-z0-9]+/g
    shortHand: /^-[A-z0-9]+/g
    singleArg: /<[A-z0-9]+>/g
    multipleArgs: /\[[A-z0-9]+\]/g

  @type: 
    single: 0,
    multiple: 1,
    bool: 2

  @isOptionSwitch: (string)->
    !!(string.match Option.regex.shortHand) or !!(string.match Option.regex.longHand)

  constructor: (commandString, description)->
    @property 'shortHand'
    @property 'longHand'
    @property 'description'
    @property 'argType'
    @property 'name'

    shortHand = @findShortHand commandString
    longHand = @findLongHand commandString

    @setShortHand shortHand
    @setLongHand longHand
    @setDescription description

    @setArgTypeWithCommandString commandString

    @createNameFromLongHand()

  findShortHand: (commandString)->
    return commandString.match(Option.regex.shortHand)[0]

  findLongHand: (commandString)->
    return commandString.match(Option.regex.longHand)[0]

  setArgTypeWithCommandString: (commandString)->
    if commandString.match Option.regex.singleArg
      @setArgType Option.type.single 
    else if commandString.match Option.regex.multipleArgs
      @setArgType Option.type.multiple
    else
      @setArgType Option.type.bool 

  createNameFromLongHand: ()->
    longHand = @longHand()
    @setName longHand.substring 2, longHand.length

module.exports = Option