assert = require 'assert'
frap = require '../../frapper'

describe 'frap.Command', ()->
  testCommandSingleArgParam = 'model <arg>'
  testCommandMultipleArgParam = 'model [arg]'
  testFunc = (arg)->

  testCommandSingleArg = new frap.Command testCommandSingleArgParam, testFunc
  testCommandMultipleArg = new frap.Command testCommandMultipleArgParam, testFunc

  describe '#findCommandName()', ()->
    it 'should return model', ()->
      assert.equal 'model', testCommandSingleArg.findCommandName testCommandMultipleArgParam

  describe '#findSingleArg()', ()->
    it 'should return <arg>', ()->
      assert.equal '<arg>', testCommandSingleArg.findSingleArg testCommandSingleArgParam

  describe '#findMultipleArg()', ()->
    it 'should return [arg]', ()->
      assert.equal '[arg]', testCommandMultipleArg.findMultipleArg testCommandMultipleArgParam

  describe '#argType()', ()->
    it 'should return Command.type.single', ()->
      assert.equal frap.Command.type.single, testCommandSingleArg.argType()

    it 'should return Command.type.multiple', ()->
      assert.equal frap.Command.type.multiple, testCommandMultipleArg.argType()

  describe '#name()', ()->
    it 'should return model', ()->
      assert.equal 'model', testCommandSingleArg.name()

    it 'should return model', ()->
      assert.equal 'model', testCommandMultipleArg.name()