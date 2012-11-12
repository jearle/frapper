should = require 'should'
Command = require('../../frapper').Command

describe 'Command', ->
  
  testName = null
  testArgs = null
  testActionThisPointer = null

  testRunArguments = ['MyTest', 'test1:string', 'test2:string', '-a', 'a1', 'a2', '-v', 'varr', '-b']
  testCommandArguments = ['<test>', '[tests]']

  # given
  command = new Command 'test <name> [args]',
    description: 'A test with multiple attributes.'
    options:
      '-b --boolean': 'A boolean test option.'
      '-v --variable <arg>': 'A single variable test option.'
      '-a --array [args]': 'An array variable test option.'
    action: (name, args)->
      testName = name
      testArgs = args
      testActionThisPointer = @

  it 'should be an instanceof Command', ->
    command.should.be.an.instanceof(Command)

  it 'should have a getter name that returns value "test"', ->
    command.name().should.equal 'test'

  it 'should have a getter rawCommand that returns value "test <name> [args]"', ->
    command.rawCommand().should.equal 'test <name> [args]'

  it 'should have a getter description that returns value "A test with multiple attributes."', ->
    command.description().should.equal 'A test with multiple attributes.'

  it 'should have options with name boolean, variable, and array', ->
    command.options()[0].name().should.equal 'boolean'
    command.options()[1].name().should.equal 'variable'
    command.options()[2].name().should.equal 'array'

  it 'should have a getter action that returns a function', ->
    command.action().should.be.a 'function'

  describe '#run()', ->
    command.run testRunArguments

    it 'should set testName to MyTest', ->
      testName.should.equal 'MyTest'

    it 'should set testArgs to ["test1:string", "test2:string"]', ->
      testArgs.should.eql ['test1:string', 'test2:string']

    it 'should have a this pointer with property array with value ["a1", "a2"]', ->
      testActionThisPointer.should.have.property 'array'
      testActionThisPointer.array.should.eql ['a1', 'a2']

    it 'should have a this pointer with property boolean with value true', ->
      testActionThisPointer.should.have.property 'boolean', true

    it 'should have a this pointer with property variable with value varr', ->
      testActionThisPointer.should.have.property 'variable', 'varr'

  describe '#extractOptionValues()', ->
    optionValues = command.extractOptionValues ['MyTest', 'test1:string', 'test2:string', '-a', 'a1', 'a2', '-v', 'varr', '-b']
    
    it 'should have a property boolean with a value of true', ->
      optionValues.should.have.property 'boolean', true

    it 'should have a property variable wiht a value of varr', ->
      optionValues.should.have.property 'variable', 'varr'

    it 'should have a property array with a value of ["a1", "a2"]', ->
      optionValues.should.have.property 'array'
      optionValues.array.should.eql ["a1", "a2"]

  describe '#extractSingleArgs()', ->
    it 'should return array with MyTest at first index', ->
      command.extractSingleArgs(testCommandArguments, testRunArguments)[0].should.equal 'MyTest'

  describe '#extractMultipleArgs()', ->
    it 'should return an array ["test1:string", "test2:string"]', ->
      command.extractMultipleArgs(testCommandArguments, testRunArguments).should.eql ['test1:string', 'test2:string']
