Program = require('./').Program
program = new Program
  'test <name> [args]':
    description: 'A test command line program.'
    options:
      '-b --boolean': 'A test boolean value'
    action: (name, args)->
      console.log name
      console.log args
      console.log @boolean

program.run()

# $ coffee use_test.coffee test MyName myArg -b
# log: MyName
# log: [ 'myArg' ]
# log: true