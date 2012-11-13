# should = require 'should'
# Program = require('../').Program
# Command = require('../').Command

# sys = require 'sys'
# exec = require('child_process').exec
# path = require 'path'

# describe 'Program', ->
#   testProps =
#     'test <name> [args]':
#       description: 'A test with multiple attributes.'
#       options:
#         '-b --boolean': 'A boolean test option.'
#         '-v --variable <arg>': 'A single variable test option.'
#         '-a --array [args]': 'An array variable test option.'
#       action: (name, args)->
#         console.log name
#         console.log args
#     'model <name> [attrs]':
#       description: 'A test command to generate models'
#       action: (name, attrs)->
#         console.log name
#         console.log attrs

#   program = new Program testProps

#   it 'should have a commandProperties getter that returns a value equal to testProps', ->
#     program.commandProperties().should.eql testProps

#   it 'should have a commands getter that return an object with properties test and model that point to Command objects', ->
#     program.commands().test.should.be.an.instanceof Command
#     program.commands().model.should.be.an.instanceof Command