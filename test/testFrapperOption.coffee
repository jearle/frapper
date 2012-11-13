assert = require 'assert'
frap = require '../'
should = require 'should'

describe 'frap.Option', ()->
  testCommand = '-o, --option1 <variable>'
  testDescription = 'test description'
  
  testOption = new frap.Option testCommand, testDescription
  describe '#longHand', ()->
    
    it 'should return --option1', ()->
      testOption.longHand.should.be.eql '--option1'

  describe '#shortHand', ()->

    it 'should return -o', ()->
      testOption.shortHand.should.be.eql '-o'

  describe '#description()', ()->
    
    it 'should return ' + testDescription, ()->
      testOption.description.should.be.eql testDescription

  describe '#name', ()->
    
    it 'should return option1', ()->
      testOption.name.should.be.eql 'option1'

  describe '#argType()', ->

    it 'should return type Option.type.single', ->
      testOption.argType.should.equal frap.Option.type.single

    testOptionMultiple = new frap.Option '-o, --option1 [variables]', testDescription
    it 'should return type Option.type.multiple', ->
      testOptionMultiple.argType.should.equal frap.Option.type.multiple

    testOptionBool = new frap.Option '-o, --option1', testDescription
    it 'should return type Option.type.bool', ->
      testOptionBool.argType.should.equal frap.Option.type.bool


describe 'frap.Option.isOptionSwitch()', ->
  it 'should be true', ->
    frap.Option.isOptionSwitch('-p').should.be.true
    frap.Option.isOptionSwitch('--test-param').should.be.true
    frap.Option.isOptionSwitch('--test').should.be.true
  it 'should be false', ->
    frap.Option.isOptionSwitch('p').should.be.false
    frap.Option.isOptionSwitch('test-param').should.be.false
