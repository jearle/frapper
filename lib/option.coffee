class Option
  @regex:
    longHand: /--[A-z0-9]+/g
    shortHand: /^-[A-z0-9]+/g

  _shortHand: ''
  _longHand: ''
  _description: ''
  _name: ''
  _variable: null

  constructor: (commandString, description)->
    shortHand = @findShortHand commandString
    longHand = @findLongHand commandString

    @setShortHand shortHand
    @setLongHand longHand
    @setDescription description

    @createNameFromLongHand()

  findShortHand: (commandString)->
    return commandString.match(Option.regex.shortHand)[0]

  findLongHand: (commandString)->
    return commandString.match(Option.regex.longHand)[0]

  shortHand: ()->
    return @_shortHand

  setShortHand: (shortHand)->
    @_shortHand = shortHand

  longHand: ()->
    return @_longHand

  setLongHand: (longHand)->
    @_longHand = longHand

  description: ()->
    return @_description

  setDescription: (description)->
    @_description = description

  createNameFromLongHand: ()->
    longHand = @longHand()
    @_name = longHand.substring 2, longHand.length

  name: ()->
    return @_name

  setVariable: (variable)->
    @_variable = variable

  variable: ()->
    return @_variable

module.exports = Option