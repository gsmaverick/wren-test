import "src/expectation" for Expectation

/**
 * Run a test block.
 */
class Runnable {
  /**
   * Create a new runnable test object. Either a Fiber or Fn can be given as the
   * runnable object.
   *
   * @param {String} title Name of the test.
   * @param {Sequence[Fn|Fiber]} beforeEaches List of functions or fibers that
   *                                          should be called before the main
   *                                          test block is run.
   * @param {Sequence[Fn|Fiber]} afterEaches List of functions or fibers that
   *                                         should be called after the main
   *                                         test block is run.
   * @param {Fiber|Fn} body Fiber or function that represents the test to run.
   */
  new (title, beforeEaches, afterEaches, fn) {
    _title = title

    _beforeEaches = beforeEaches
    _afterEaches = afterEaches

    _expectations = []

    // Wrap bare functions in Fibers.
    if (fn.type != Fiber) {
      fn = new Fiber(fn)
    }

    _fn = fn
  }

  /**
   * @return {Num} Elapsed time for this test, in milliseconds, including
   * running all defined `beforeEach` and `afterEach` methods.
   */
  duration { (_duration * 1000).ceil }

  /**
   * @return {String} The error string of this Runnable if an error was
   * encountered while running this test.
   */
  error { _fn.error }

  /**
   * @return {Sequence[Expectations]} List of `Expectation`s that were emitted
   * by the test body.
   */
  expectations { _expectations }

  /**
   * @return {Bool} Whether this Runnable instance has been run.
   */
  hasRun { _fn.isDone }

  /**
   * Runs the test function and collects the `Expectation`s that were generated.
   *
   * @return {Sequence[Expectation]} List of `Expectation`s that were emitted by
   * the test body.
   */
  run() {
    var startTime = IO.clock

    for (fn in _beforeEaches) { fn.call() }

    while (!_fn.isDone) {
      var result = _fn.try()

      // Ignore any values that were yielded that weren't an Expectation.
      // Note: When a fiber is finished the last `yield` invocation returns
      // `null` so it will not be added to the array.
      if (result is Expectation) {
        _expectations.add(result)
      }
    }

    for (fn in _afterEaches) { fn.call() }

    _duration = IO.clock - startTime

    return _expectations
  }

  /**
   * @return {String} Title string of this Runnable.
   */
  title { _title }
}