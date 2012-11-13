Jobject
===============

  A class that adds properties to your class that are easily overriden and maintain direct accessors.  Similiar to objective-c @property and @synthesize.

```coffee
Jobject = require './'

class MyClass extends Jobject
  @property 'name'

  @property 'title', '', 
    get: ()->
      return 'TITLE: ' + @_title
  
  @property 'author', '', 
    get: ()->
      return @_author + '!!!!'
    set: (author)->
      @_author = 'AUTHOR: ' + author

myClass = new MyClass()
myClass.name = 'Jesse Earle'
myClass.title = 'Fruit Loop'
myClass.author = 'Stephen King'

console.log(myClass.name) # Jesse earle
console.log(myClass.title) # TITLE: Fruit Loop
console.log(myClass.author) #AUTHOR: Stephen King!!!!
```

## Features

  * A simple way to attach getters and setters to your classes
  * Similarity Objective-C @property and @synthesize
  * Reduce redundant code
  * Access properties with the simple dot syntax

## Usage

Create a class that extends Jobject

```coffee
class MyClass extends Jobject
  @property 'name'
```

This class now has the following properties:
  * _name
  * name

The _name property provides direct access to the value of the property.

The name property on the other hand actually points to a getter and setter function, but you still access it normally:

```coffee
myClass = new MyClass()
myClass.name = 'Jesse'
console.log myClass.name # logs: Jesse
```

You can also give a default value to the property:

```coffee
class MyClass extends Jobject
  @property 'name', 'Default'

myClass = new MyClass()
console.log myClass.name # logs: Default
```

If you do not provide a default value it will point to null. Note that the property will exist on the instance.

Overriding the getter and setter is simple:

```coffee
class MyClass extends Jobject

  @property 'name', '',
    get: ()->
      return @_name + '!'
    set: (name)->
      @_name = '!' + name

myClass = new MyClass()
myClass.name = 'Jesse'
console.log myClass.name # logs: !Jesse!
```