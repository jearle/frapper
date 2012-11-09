Jobject = require 'jobject'

class Option extends Jobject
  @regex:
    longHand: /--[A-z0-9]+/g
    shortHand: /^-[A-z0-9]+/g

  constructor: (commandString, description)->
    @property 'shortHand'
    @property 'longHand'
    @property 'description'
    @property 'variable'
    @property 'name'

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

  createNameFromLongHand: ()->
    longHand = @longHand()
    @setName longHand.substring 2, longHand.length

module.exports = Option