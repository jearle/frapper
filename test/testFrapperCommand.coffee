assert = require 'assert'
frap = require '../../frapper'

describe 'frap.Command', ()->

  testCommand = new frap.Command
    'test [args]':
      description: 'A test with multiple attributes.'
      options:
        '-b --boolean': 'A boolean test option.'
        '-v --variable <arg>': 'A single variable test option.'
        '-a --array [args]': 'An array variable test option.'
      action: (args)->
        console.log args

  testCommandMultiple = new frap.Command
    'test <arg>':
      description: 'A test with a single attribute.'

  describe '#findCommandName()', ()->
    it 'should return test.  Asserts that the findCommandName logic is correct.', ()->
      assert.equal 'test', testCommand.findCommandName 'test [args]'

  describe '#findDescriptionInProperties()', ()->
    it 'should equal "A test with multiple attributes."', ()->
      assert.equal 'A test with multiple attributes.', testCommand.findDescriptionInProperties {
        description: 'A test with multiple attributes.'
      }

  describe '#findCommandOptionsInProperties()', ()->
    testOptions = 
      '-b --boolean': 'A boolean test options.'

    it 'should match testOptions', ()->
      assert.equal testOptions, testCommand.findCommandOptionsInProperties {
        options: testOptions
      }

  describe '#createOptions()', ()->
    testOptions = 
      '-t --test': 'A test option.'
      '-a --another': 'Another test option'

    it 'should have options with name test and another', ()->
      options = testCommand.createOptions testOptions
      assert.equal 'test', options[0].name()
      assert.equal 'another', options[1].name()

  describe '#determineArgType()', ()->
    single = 'test <arg>'
    multiple = 'test [args]'

    it 'should equal Command.argType.single', ()->
      assert.equal frap.Command.type.single, testCommand.determineArgType single

    it 'should equal Command.argType.multiple', ()->
      assert.equal frap.Command.type.multiple, testCommand.determineArgType multiple
    
  describe '#constructor()', ()->
    it 'should properly set name to test', ()->
      assert.equal 'test', testCommand.name()

    it 'should properly set description to "A test with multiple attributes."', ()->
      assert.equal 'A test with multiple attributes.', testCommand.description()

    it 'should properly set argType to multple', ()->
      assert.equal frap.Command.type.multiple, testCommand.argType()

    it 'should properly set argType to single', ()->
      assert.equal frap.Command.type.single, testCommandMultiple.argType()

    it 'should set options with names boolean, variable, array', ()->
      assert.equal 'boolean', testCommand.options()[0].name()
      assert.equal 'variable', testCommand.options()[1].name()
      assert.equal 'array', testCommand.options()[2].name()

    it 'should properly set rawCommand to "test [args]"', ()->
      assert.equal 'test [args]', testCommand.rawCommand()

    # it 'should properly return a array with Options named boolean, variable, and array', ()->
    #   assert.equal 'boolean', testCommand.options()[0].name()
    #   assert.equal 'variable', testCommand.options()[0].name()
    #   assert.equal 'array', testCommand.options()[0].name()



  # describe '#findSingleArg()', ()->
  #   it 'should return <arg>', ()->
  #     assert.equal '<arg>', testCommandSingleArg.findSingleArg testCommandSingleArgParam

  # describe '#findMultipleArg()', ()->
  #   it 'should return [arg]', ()->
  #     assert.equal '[arg]', testCommandMultipleArg.findMultipleArg testCommandMultipleArgParam

  # describe '#argType()', ()->
  #   it 'should return Command.type.single', ()->
  #     assert.equal frap.Command.type.single, testCommandSingleArg.argType()

  #   it 'should return Command.type.multiple', ()->
  #     assert.equal frap.Command.type.multiple, testCommandMultipleArg.argType()

  # describe '#name()', ()->
  #   it 'should return model', ()->
  #     assert.equal 'model', testCommandSingleArg.name()

  #   it 'should return model', ()->
  #     assert.equal 'model', testCommandMultipleArg.name()

  # describe '#addVersionOption()', ()->
  #   it 'should have a version option automatically added', ()->

  # describe '#func()', ()->
  #   testArg = 'testArg'
  #   it 'should return same result', ()->
  #     assert.equal testArg, testCommandSingleArg.func testArg