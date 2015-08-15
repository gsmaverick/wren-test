import "src/reporters/reporter" for Reporter

/**
 * A test reporter that outputs the results to the console.
 */
class ConsoleReporter is Reporter {
  construct new() {
    _indent = 0

    // Count the different kinds of tests reported.
    _counters = {
      "tests": 0,
      "passed": 0,
      "failed": 0,
      "errors": 0,
      "skipped": 0
    }

    _startTime = IO.clock
  }

  getCount_ (kind) { _counters[kind].toString }

  count_ (kind) {
    _counters[kind] = _counters[kind] + 1
  }

  /**
   * Prints out a summary of the test run reported on by this instance.
   */
  epilogue () {
    var duration = ((IO.clock - _startTime) * 1000).ceil.toString

    IO.print("")
    IO.print("==== Tests Summary ====")

    var result = getCount_("tests") + " tests, " + getCount_("passed") +
      " passed, " + getCount_("failed") + " failed, " + getCount_("errors") +
      " errors, " + getCount_("skipped") + " skipped (" + duration + " ms)"
    print_(result, 2)
  }

  runnableSkipped (skippable) {
    count_("skipped")

    print_("- " + skippable.title, _indent + 1,
      "\u001b[36m")
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
    count_("tests")
  }

  testEnd (runnable) {
    _indent = _indent - 1
  }

  testPassed (runnable) {
    count_("passed")

    print_(Symbols["ok"] + " \u001b[90mshould " + runnable.title, _indent,
      "\u001b[32m")
  }

  testFailed (runnable) {
    count_("failed")

    print_(Symbols["err"] + " \u001b[90mshould " + runnable.title, _indent,
      "\u001b[31m")

    var failedExpectations = runnable.expectations.where { |e| !e.passed }

    for (expectation in failedExpectations) {
      print_(expectation.message, _indent + 1, "\u001b[31m")
    }
  }

  testError (runnable) {
    count_("errors")

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
