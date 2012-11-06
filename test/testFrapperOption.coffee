assert = require 'assert'
frap = require '../../frapper'

describe 'frap.Option', ()->
  testCommand = '-o, --option1 <variable>'
  testDescription = 'test description'

  describe '#longHand()', ()->
    testOption = new frap.Option testCommand, testDescription
    
    it 'should return --option1', ()->
      assert.equal '--option1', testOption.longHand()

  describe '#shortHand()', ()->
    testOption = new frap.Option testCommand, testDescription

    it 'should return -o', ()->
      assert.equal '-o', testOption.shortHand()

  describe '#description()', ()->
    testOption = new frap.Option testCommand, testDescription
    it 'should return ' + testDescription, ()->
     assert.equal testDescription, testOption.description()

  describe '#name()', ()->
    testOption = new frap.Option testCommand, testDescription
    it 'should return option1', ()->
      assert.equal 'option1', testOption.name()