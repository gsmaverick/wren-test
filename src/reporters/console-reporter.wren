import "src/reporters/reporter" for Reporter

/**
 * A test reporter that outputs the results to the console.
 */
class ConsoleReporter is Reporter {
  new {
    _indent = 0

    // Keep track of the kinds of tests we encounter.
    _tests = 0
    _passed = 0
    _errors = 0
    _failed = 0

    _startTime = IO.clock
  }

  /**
   * Prints out a summary of the test run reported on by this instance.
   */
  epilogue () {
    var duration = ((IO.clock - _startTime) * 1000).ceil

    IO.print("")
    IO.print("==== Tests Summary ====")

    var result = _tests.toString + " tests, " + _passed.toString +
      " passed, " + _failed.toString + " failed, " + _errors.toString +
      " errors (" + duration.toString + " ms)"
    print_(result, 2)
  }

  suiteStart (title) {
    _indent = _indent + 1

    print_(title)
  }

  suiteEnd (title) {
    _indent = _indent - 1

    if (_indent == 0) { IO.print("") }
  }

  testStart (runnable) {
    _indent = _indent + 1
    _tests = _tests + 1
  }

  testEnd (runnable) {
    _indent = _indent - 1
  }

  testPassed (runnable) {
    _passed = _passed + 1
    print_(Symbols["ok"] + " \u001b[90mshould " + runnable.title, _indent,
      "\u001b[32m")
  }

  testFailed (runnable) {
    _failed = _failed + 1
    print_(Symbols["err"] + " \u001b[90mshould " + runnable.title, _indent,
      "\u001b[31m")

    var failedExpectations = runnable.expectations.where { |e| !e.passed }

    for (expectation in failedExpectations) {
      print_(expectation.message, _indent + 1, "\u001b[31m")
    }
  }

  testError (runnable) {
    _errors = _errors + 1
    print_(Symbols["err"] + " \u001b[90mshould " + runnable.title)
    print_("Error: " + runnable.error, _indent + 1, "\u001b[31m")
  }

  print_ (string) {
    print_(string, _indent)
  }

  print_ (string, indent) {
    print_(string, indent, "")
  }

  print_ (string, indent, color) {
    var result = ""

    for (i in 2...(indent * 2)) {
      result = result + " "
    }

    IO.print(color + result + string + "\u001b[0m")
  }
}

var Symbols = {
  "ok": "✓",
  "err": "✖"
}