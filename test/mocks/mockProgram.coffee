#!/usr/bin/env coffee

Program = require('../../../frapper').Program

program = new Program
  
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
    
    options:
      '-b --boolean': 'A boolean test option.'
    
    action: (name, attrs)->
      console.log name
      console.log attrs
      console.log @

program.run()