import "src/matchers/base" for BaseMatchers

/**
 * A class of matchers for making assertions about Fibers.
 */
class FiberMatchers is BaseMatchers {
  /**
   * Assert that invoking this value as a fiber generated a runtime error.
   */
  toBeARuntimeError {
    // TODO: Use Fiber.abort instead of faking it with an Expectation.
    if (!ensureValueIsFiber_) {
      return
    }

    // Run the fiber to generate the possible error.
    value.try

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
    // TODO: Use Fiber.abort instead of faking it with an Expectation.
    if (!ensureValueIsFiber_) {
      return
    }

    // Run the fiber to generate the possible error.
    while (!value.isDone) {
      value.try
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
    // TODO: Use Fiber.abort instead of faking it with an Expectation.
    if (!ensureValueIsFiber_) {
      return
    }

    var message = "Expected the fiber to be done"
    report_(value.isDone, message)
  }

  /**
   * Assert that invoking this fiber yields the expected value(s).
   *
   * @param shouldYield
   */
  toYield (shouldYield) {
    // TODO: Use Fiber.abort instead of faking it with an Expectation.
    if (!ensureValueIsFiber_) {
      return
    }

    // If a bare value was passed coerce it into a list.
    if (!(shouldYield is List)) { shouldYield = [shouldYield] }

    var results = []

    // Get all values that this fiber could yield.
    while (!value.isDone) {
      results.add(value.try)
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
  }

  /**
   * @return True if the value of this matcher is a Fiber, otherwise emits a
   *         failed Expectation and returns false.
   */
  ensureValueIsFiber_ {
    if (!(value is Fiber)) {
      var message = value.toString + " was not a Fiber"
      report_(false, message)
    }

    return value is Fiber
  }
}