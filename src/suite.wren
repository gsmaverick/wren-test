import "src/runnable" for Runnable
import "src/skippable" for Skippable

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
   * Stub method used when skipping an `afterEach` block.
   */
  afterEach { this }

  /**
   * Define a block to run after every test in this suite and any nested suites.
   *
   * @param {Fn} block Function that should be run after every test.
   */
  afterEach (block) {
    _afterEaches.add(block)
  }

  /**
   * Stub method used when skipping an `beforeEach` block.
   */
  beforeEach { this }

  /**
   * Define a block to run before every test in this suite and any nested
   * suites.
   *
   * @param {Fn} block Function that should be run before every test.
   */
  beforeEach (block) {
    _beforeEaches.add(block)
  }

  run (reporter) {

    reporter.suiteStart(title)

    for (runnable in _runnables) {
      if (runnable is Suite) {
        runnable.run(reporter)
      } else if (runnable is Skippable) {
        reporter.runnableSkipped(runnable)
      } else {
        reporter.testStart(runnable)

        var result = runnable.run()
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
   * Stub method used when skipping a `should` block inside the suite.
   *
   * @param {String} name Descriptive name for the test.
   */
  should (name) {
    var skippable = new Skippable(name)
    _runnables.add(skippable)

    return this
  }

  /**
   * Create a new test block.
   *
   * @param {String} name Descriptive name for the test.
   * @param {Fn|Fiber} block Function or fiber block that should be executed for
   *                         this test.
   */
  should (name, block) {
    var runnable = new Runnable(name, _beforeEaches, _afterEaches, block)
    _runnables.add(runnable)
  }

  /**
   * Does nothing except receive the block that would normally be associated
   * with the construct that was skipped.
   */
  skip (block) { /* Do nothing */ }

  /**
   * Stub method used when skipping a `suite` block inside the suite.
   *
   * @param {String} name Name of the suite.
   */
  suite (name) {
    var skippable = new Skippable(name)
    _runnables.add(skippable)

    return this
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
