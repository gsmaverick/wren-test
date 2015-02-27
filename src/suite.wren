import "src/runnable" for Runnable
import "src/reporters/reporter" for Reporter

class Suite {
  /**
   * Create a new suite of tests.
   *
   * @param {String} name Name of the suite.
   * @param {Fn} block Function that defines the set of tests that belong to
   *                   this suite. It receives this instance as its first
   *                   argument.
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
   * @param {Fn} block Function that defines the set of tests that belong to
   *                   this suite. It receives this instance as its first
   *                   argument.
   */
  new (name, beforeEaches, afterEaches, block) {
    constructor_(name, beforeEaches, afterEaches, block)
  }

  /**
   * Define a block to run after every test in this suite and any nested suites.
   *
   * @param {Fn} block Function that should be run after every test.
   */
  afterEach (block) {
    _afterEaches.add(block)
  }

  /**
   * Define a block to run before every test in this suite and any nested
   * suites.
   *
   * @param {Fn} block Function that should be run before every test.
   */
  beforeEach (block) {
    _beforeEaches.add(block)
  }

  run { run(new Reporter) }

  run (reporter) {

    reporter.suiteStart(title)

    for (runnable in _runnables) {
      if (runnable is Suite) {
        runnable.run(reporter)
      } else {
        reporter.testStart(runnable)

        var result = runnable.run
        var passed = result.all { |r| r.passed }

        if (runnable.error) {
          reporter.testError(runnable)
        } else if (passed) {
          reporter.testPassed(runnable)
        } else {
          reporter.testFailed(runnable)
        }

        reporter.testEnd(runnable)
      }
    }

    reporter.suiteEnd(title)
  }

  /**
   * Create a new test block.
   *
   * @param {String} name Descriptive name for the test.
   * @param {Fn|Fiber} block Function or fiber block that should be executed for
   *                         this test.
   */
  should (name, block) {
    var runnable = new Runnable(name, block, _beforeEaches, _afterEaches)
    _runnables.add(runnable)
  }

  /**
   * Create a new suite of tests that are nested under this suite.
   *
   * @param {String} name Name of the suite.
   * @param {Fn} block Function that defines the set of tests that belong to
   *                   this suite.
   */
  suite (name, block) {
    var suite = new Suite(name, _beforeEaches, _afterEaches, block)
    _runnables.add(suite)
  }

  /**
   * @return {String} Title string of this suite.
   */
  title { _name }

  constructor_ (name, beforeEaches, afterEaches, block) {
    _name = name

    _beforeEaches = beforeEaches
    _afterEaches = afterEaches

    _runnables = []

    // Invoke the block that defines the tests in this suite.
    block.call(this)
  }
}
