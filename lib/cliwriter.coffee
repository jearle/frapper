class CLIWriter
  commandNotFoundWithName: (commandName)->
    console.log()
    console.log '\tCommand: "%s" not found.', commandName
    console.log()

  noCommandSupplied: ()->
    console.log()
    console.log '\t You did not supply a command. '
    console.log()

  displayVersion: (version)->
    console.log()
    console.log '\t %s', version
    console.log()

module.exports = CLIWriter