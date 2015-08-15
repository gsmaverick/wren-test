import "src/matchers/base" for BaseMatchers

/**
 * A class of matchers for making assertions about Fibers.
 */
class FiberMatchers is BaseMatchers {
  /**
   * Create a new `Matcher` object for a value.
   *
   * @param {*} value The value to be matched on.
   */
  construct new (value) {
    super(value)
  }

  /**
   * Assert that invoking this value as a fiber generated a runtime error.
   */
  toBeARuntimeError {
    enforceClass_(Fiber)

    // Run the fiber to generate the possible error.
    value.try()

    var message = "Expected a runtime error but it did not occur"
    report_(value.error != null, message)
  }

  /**
   * Assert that invoking this value as a fiber generated a runtime error with
   * the given message.
   *
   * @param {String} errorMessage Error message that should have been generated
   *                              by the fiber.
   */
  toBeARuntimeError (errorMessage) {
    enforceClass_(Fiber)

    // Run the fiber to generate the possible error.
    while (!value.isDone) {
      value.try()
    }

    if (value.error == null) {
      var message = "Expected a runtime error but it did not occur"
      report_(false, message)
    } else {
      var message = "Expected a runtime error with error: " + errorMessage +
          " but got: " + value.error
      report_(value.error == errorMessage, message)
    }
  }

  /**
   * Assert that the fiber is done.
   */
  toBeDone {
    enforceClass_(Fiber)

    var message = "Expected the fiber to be done"
    report_(value.isDone, message)
  }

  /**
   * Assert that invoking this fiber yields the expected value(s).
   *
   * @param shouldYield
   */
  /*toYield (shouldYield) {
    enforceClass_(Fiber)

    // If a bare value was passed coerce it into a list.
    if (!(shouldYield is List)) { shouldYield = [shouldYield] }

    var results = []

    // Get all values that this fiber could yield.
    while (!value.isDone) {
      results.add(value.try())
    }

    // The last value yielded from any fiber before it finishes is null.
    results.removeAt(results.size - 1)

    if (value.error != null) {
      var message = "Expected the fiber to yield `" + shouldYield.toString +
          "` but instead got a runtime error with message: `" + value.error +
          " and yielded `" + results.toString + "`"
      report_(false, message)
    } else {
      var message = "Expected the fiber to yield `" + shouldYield.toString +
          "` but instead it yielded `" + results.toString + "`"
      report_(results.size == shouldYield.size, message)
    }
  }*/
}
