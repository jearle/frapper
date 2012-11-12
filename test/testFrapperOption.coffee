assert = require 'assert'
frap = require '../../frapper'
should = require 'should'

describe 'frap.Option', ()->
  testCommand = '-o, --option1 <variable>'
  testDescription = 'test description'

  testOption = new frap.Option testCommand, testDescription

  describe '#longHand()', ()->
    
    it 'should return --option1', ()->
      assert.equal '--option1', testOption.longHand()

  describe '#shortHand()', ()->

    it 'should return -o', ()->
      assert.equal '-o', testOption.shortHand()

  describe '#description()', ()->
    
    it 'should return ' + testDescription, ()->
     assert.equal testDescription, testOption.description()

  describe '#name()', ()->
    
    it 'should return option1', ()->
      assert.equal 'option1', testOption.name()

  describe '#argType()', ->

    it 'should return type Option.type.single', ->
      testOption.argType().should.equal frap.Option.type.single

    testOptionMultiple = new frap.Option '-o, --option1 [variables]', testDescription
    it 'should return type Option.type.multiple', ->
      testOptionMultiple.argType().should.equal frap.Option.type.multiple

    testOptionBool = new frap.Option '-o, --option1', testDescription
    it 'should return type Option.type.bool', ->
      testOptionBool.argType().should.equal frap.Option.type.bool


describe 'frap.Option.isOptionSwitch()', ->
  it 'should be true', ->
    frap.Option.isOptionSwitch('-p').should.be.true
    frap.Option.isOptionSwitch('--test-param').should.be.true
    frap.Option.isOptionSwitch('--test').should.be.true
  it 'should be false', ->
    frap.Option.isOptionSwitch('p').should.be.false
    frap.Option.isOptionSwitch('test-param').should.be.false
