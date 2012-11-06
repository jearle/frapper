assert = require 'assert'
frap = require '../../frapper'

describe 'frap.Program', ()->
  testVersion = '1.0.0'
  testOptions = 
    '-o, --option1 <variable>': 'test description'
  testCommands = 
    'model <arg>': ()->
      console.log 'hey'

  testProgram = new frap.Program
    version: testVersion
    options: testOptions
    commands: testCommands

  describe '#version()', ()->
    it 'should return ' + testVersion, ()->
      assert.equal testVersion, testProgram.version()

  describe '#options().[optionName]', ()->
    it 'should return an option object with name option1', ()->
      option = testProgram.options().option1
      assert.equal 'option1', option.name()

    it 'should have a pointer to option object named option1 when using shortHand as key', ()->
      option = testProgram.options().option1
      optionFromShortHandPointer = testProgram.options()['-o']
      assert.equal option, optionFromShortHandPointer

  describe '#commands().[commandName]', ()->
    it 'should return a command object with the name model', ()->
      command = testProgram.commands().model
      assert.equal 'model', command.name()

  testProgram.exec()