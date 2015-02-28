class Reporter {
  new {
    _indent = 0
  }

  suiteStart (title) {
    _indent = _indent + 1

    print_(title)
  }

  suiteEnd (title) {
    _indent = _indent - 1
  }

  testStart (runnable) {
    _indent = _indent + 1
  }

  testEnd (runnable) {
    _indent = _indent - 1
  }

  testPassed (runnable) {
    print_("[passed] " + runnable.title)
  }

  testFailed (runnable) {
    print_("[failed] " + runnable.title)

    failedExpectations = runnable.expectations.filter { |e| e.passed }

    for (expectation in failedExpectations) {
      print_(expectation.message, _indent + 1)
    }
  }

  testError (runnable) {
    print_("[error] " + runnable.title)
    print_("Error: " + runnable.error, _indent + 1)
  }

  print_ (string) {
    print_(string, _indent)
  }

  print_ (string, indent) {
    var result = ""

    for (i in 4...(indent * 4)) {
      result = result + " "
    }

    IO.print(result + string)
  }
}