should = require 'should'
Program = require('../../frapper').Program
Command = require('../../frapper').Command

sys = require 'sys'
exec = require('child_process').exec
path = require 'path'

describe 'Program', ->
  testProps =
    'test <name> [args]':
      description: 'A test with multiple attributes.'
      options:
        '-b --boolean': 'A boolean test option.'
        '-v --variable <arg>': 'A single variable test option.'
        '-a --array [args]': 'An array variable test option.'
      action: (name, args)->
        console.log name
        console.log args
    'model <name> [attrs]':
      description: 'A test command to generate models'
      action: (name, attrs)->
        console.log name
        console.log attrs

  program = new Program testProps

  it 'should have a commandProperties getter that returns a value equal to testProps', ->
    program.commandProperties().should.eql testProps

  it 'should have a commands getter that return an object with properties test and model that point to Command objects', ->
    program.commands().test.should.be.an.instanceof Command
    program.commands().model.should.be.an.instanceof Command

  mockProgramLocation = path.join __dirname, '/mocks/mockProgram.coffee'
  console.log mockProgramLocation
  it 'should produce stdout which contains MyModel, [ \'title:string\', \'body:string\' ], and { boolean: true }', (done)->
    exec mockProgramLocation + ' model MyModel title:string body:string -b', (error, stdout, stderr)->
      
      stdout.should.match /MyModel/g
      stdout.should.match /\[ 'title:string', 'body:string' \]/g
      stdout.should.match /\{ boolean: true \}/

      throw error if error
      done()