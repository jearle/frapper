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

## Usage

Create a program

```coffee
program = new Program()
```

A program won't do anything by itself.  You have to provide commands to the program.

Let's say we're creating a command line application to generate mongoose models

```coffee
program = new Program
  'model <modelName> [modelAttributes]'
    description: 'The model command will generate mongoose models.'
    options:
      '-d --details': 'This will print details of the generated model to stdout.'
    action: (modelName, modelAttributes)->
      console.log name
      console.log args
program.run()
```
### Command

The <> around modelName tell frapper that it takes a single argument.  This means that first variable passed to the action callback function will be the first process.argv after your commmand.

The [] around modelAttributes denotes an array.  This means that all attributes after the first first argument will be placed into an array and passed as the second argument of the action callback.

For example:

  $ ./my_program model MyModel title:String body:String
  $ MyModel
  $ [ 'title:String', 'body:String' ]

### Options

You can also include a -d switch at the end of the command.  This is a boolean value, because there is no <> or [] at the end of the option definition.

Options are attached to the this pointer of the action callback.

Lets change the action callback to:

```coffee
program = new Program
  'model <modelName> [modelAttributes]'
    description: 'The model command will generate mongoose models.'
    options:
      '-d --details': 'This will print details of the generated model to stdout.'
    action: (modelName, modelAttributes)->
      console.log name
      console.log args
      console.log @details
program.run()
```

This will print false:

  $ ./my_program model MyModel title:String body:String
  $ MyModel
  $ [ 'title:String', 'body:String' ]
  $ false

This will print true:

  $ ./my_program model MyModel title:String body:String -d
  $ MyModel
  $ [ 'title:String', 'body:String' ]
  $ true

This will also print true:

  $ ./my_program model MyModel title:String body:String --details
  $ MyModel
  $ [ 'title:String', 'body:String' ]
  $ true

We can also have options with single variables or an array of variables:

```coffee
program = new Program
  'model <modelName> [modelAttributes]'
    description: 'The model command will generate mongoose models.'
    options:
      '-d --details': 'This will print details of the generated model to stdout.'
      '-s --single-variable <variable>': 'A test single variable.'
      '-m --multi-variable [variables]': 'A test multi varaible.'
    action: (modelName, modelAttributes)->
      console.log name
      console.log args
      console.log @details
      console.log @singleVariable
      console.log @multiVariable
program.run()
```
Example:

    $ ./my_program model MyModel title:String body:String -d -m test1 test2 test3 -s singleTest
    MyModel
    [ 'title:String', 'body:String' ]
    true
    singleTest
    [ 'test1', 'test2', 'test3' ]

