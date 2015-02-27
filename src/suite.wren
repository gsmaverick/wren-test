import "deps/wren-colors/index" for AnsiColors, AnsiPrinter
import "src/runnable" for Runnable

class Suite {
  /**
   * Create a new suite of tests.
   *
   * @param {String} name Name of the suite.
   * @param {Fn} block A block that when invoked returns a dictionary that
   *                   defines the tests that belong to this suite.
   */
  new (name, block) {
    constructor_(name, [], [], block)
  }

  /**
   * Create a new suite of tests with the given `beforeEach` and `afterEach`
   * functions.
   *
   * @param {String} name Name of the suite.
   * @param {Sequence[Fn]} beforeEaches A list of functions to invoke before
   *                                    each test is invoked.
   * @param {Sequence[Fn]} afterEaches A list of functions to invoke after each
   *                                   test is invoked.
   * @param {Fn} block A block that when invoked returns a dictionary that
   *                   defines the tests that belong to this suite.
   */
  new (name, beforeEaches, afterEaches, block) {
    constructor_(name, beforeEaches, afterEaches, block)
  }

  constructor_ (name, beforeEaches, afterEaches, block) {
    _name = name

    _beforeEaches = beforeEaches
    _afterEaches = afterEaches

    // Invoke the block that defines the tests in this suite.
    var definition = block.call

    if (definition.containsKey("beforeEach")) {
      _beforeEaches.add(definition["beforeEach"])

      // Remove from map so we don't create a `Runnable` for it later on.
      definition.remove("beforeEach")
    }

    if (definition.containsKey("afterEach")) {
      _afterEaches.add(definition["afterEach"])

      // Remove from map so we don't create a `Runnable` for it later on.
      definition.remove("afterEach")
    }

    _runnables = []

    for (key in definition.keys) {
      if (definition[key] is Fn) { // This is a test case.
        var runnable = new Runnable(key, definition[key], _beforeEaches,
          _afterEaches)

        _runnables.add(runnable)
      }

      if (definition[key] is Map) { // This is a nested suite.
        var definitionMap = definition[key]

        var suite = new Suite(key, _beforeEaches, _afterEaches) {
          return definitionMap
        }

        _runnables.add(suite)
      }
    }

    _passedOut = new AnsiPrinter(AnsiColors.GREEN)
    _failedOut = new AnsiPrinter(AnsiColors.RED)
  }

  title { _name }

  run (indent) {
    IO.print // Empty newline to make nesting nicer.
    IO.print(indented_(_name, indent))

    for (runnable in _runnables) {
      if (runnable is Suite) {
        runnable.run(indent + 1)
      } else {
        var result = runnable.run
        var passed = result.all { |r| r.passed }

        if (runnable.error) {
          _failedOut.print(
            indented_("[error] "  + runnable.title, indent + 1))
          _failedOut.print(
            indented_("Error: "  + runnable.error, indent + 2))
        } else if (passed) {
          _passedOut.print(
            indented_("[passed] " + runnable.title, indent + 1))
        } else {
          _failedOut.print(
            indented_("[failed] " + runnable.title, indent + 1))

          for (expectation in result) {
            if (!expectation.passed) {
              _failedOut.print(
                indented_(expectation.message, indent + 2))
            }
          }
        }
      }
    }
  }

  run { run(0) }

  indented_ (string, num) {
    var result = ""

    for (i in 0...(num * 4)) {
      result = result + " "
    }

    return result + string
  }
}
