// Generated by CoffeeScript 1.4.0
(function() {
  var Command, should;

  should = require('should');

  Command = require('../').Command;

  describe('Command', function() {
    var command, testActionThisPointer, testArgs, testCommandArguments, testName, testRunArguments;
    testName = null;
    testArgs = null;
    testActionThisPointer = null;
    testRunArguments = ['MyTest', 'test1:string', 'test2:string', '-a', 'a1', 'a2', '-v', 'varr', '-b'];
    testCommandArguments = ['<test>', '[tests]'];
    command = new Command('test <name> [args]', {
      description: 'A test with multiple attributes.',
      options: {
        '-b --boolean': 'A boolean test option.',
        '-v --variable <arg>': 'A single variable test option.',
        '-a --array [args]': 'An array variable test option.'
      },
      action: function(name, args) {
        testName = name;
        testArgs = args;
        return testActionThisPointer = this;
      }
    });
    it('should be an instanceof Command', function() {
      return command.should.be.an["instanceof"](Command);
    });
    it('should have a getter name that returns value "test"', function() {
      return command.name().should.equal('test');
    });
    it('should have a getter rawCommand that returns value "test <name> [args]"', function() {
      return command.rawCommand().should.equal('test <name> [args]');
    });
    it('should have a getter description that returns value "A test with multiple attributes."', function() {
      return command.description().should.equal('A test with multiple attributes.');
    });
    it('should have options with name boolean, variable, and array', function() {
      command.options()[0].name().should.equal('boolean');
      command.options()[1].name().should.equal('variable');
      return command.options()[2].name().should.equal('array');
    });
    it('should have a getter action that returns a function', function() {
      return command.action().should.be.a('function');
    });
    describe('#run()', function() {
      command.run(testRunArguments);
      it('should set testName to MyTest', function() {
        return testName.should.equal('MyTest');
      });
      it('should set testArgs to ["test1:string", "test2:string"]', function() {
        return testArgs.should.eql(['test1:string', 'test2:string']);
      });
      it('should have a this pointer with property array with value ["a1", "a2"]', function() {
        testActionThisPointer.should.have.property('array');
        return testActionThisPointer.array.should.eql(['a1', 'a2']);
      });
      it('should have a this pointer with property boolean with value true', function() {
        return testActionThisPointer.should.have.property('boolean', true);
      });
      return it('should have a this pointer with property variable with value varr', function() {
        return testActionThisPointer.should.have.property('variable', 'varr');
      });
    });
    describe('#extractOptionValues()', function() {
      var optionValues;
      optionValues = command.extractOptionValues(['MyTest', 'test1:string', 'test2:string', '-a', 'a1', 'a2', '-v', 'varr', '-b']);
      it('should have a property boolean with a value of true', function() {
        return optionValues.should.have.property('boolean', true);
      });
      it('should have a property variable wiht a value of varr', function() {
        return optionValues.should.have.property('variable', 'varr');
      });
      return it('should have a property array with a value of ["a1", "a2"]', function() {
        optionValues.should.have.property('array');
        return optionValues.array.should.eql(["a1", "a2"]);
      });
    });
    describe('#extractSingleArgs()', function() {
      return it('should return array with MyTest at first index', function() {
        return command.extractSingleArgs(testCommandArguments, testRunArguments)[0].should.equal('MyTest');
      });
    });
    return describe('#extractMultipleArgs()', function() {
      return it('should return an array ["test1:string", "test2:string"]', function() {
        return command.extractMultipleArgs(testCommandArguments, testRunArguments).should.eql(['test1:string', 'test2:string']);
      });
    });
  });

}).call(this);
