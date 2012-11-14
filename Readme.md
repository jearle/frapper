Frapper
===============

DSL for command-line applications.  Inspired in part by commander.

```coffee
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
```

## Features

  * A simple way to create command line utilities
  * Similar to Commander, but easier to write and understand
  * A DSL dedicated to cli applications