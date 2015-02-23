import "src/expectation" for Expectation

/**
 * A class of matchers to use for making assertions.
 */
class Matchers {
  /**
   * Create a new `Matcher` object for a value.
   *
   * @param {*} value The value to be matched on.
   */
  new (value) {
    _value = value
  }

  /**
   * Negates this matcher and returns itself so that it can be chained with
   * other matchers:
   *
   *     var matcher = new Matchers("value")
   *     matcher.not.toEqual("string") // Passing expectation.
   *
   * @return This instance of the classes that received this method.
   */
  not {
    _negated = true

    // Return this matcher to support chaining.
    return this
  }

  /**
   * Asserts that the value is of a given class.
   *
   * @param {Class} klass Class which the value should be an instacne of.
   */
  toBe (klass) {
    var message = "Expected " + _value.toString + " of class " +
        _value.type.toString + " to be of class " + klass.toString
    report_(_value is klass, message)
  }

  /**
   * Asserts that the value is falsy.
   */
  toBeFalsy {
    var message = "Expected " + _value.toString + " to be falsy"
    report_(!_value, message)
  }

  /**
   * Asserts that the value is truthy.
   */
  toBeTruthy {
    var message = "Expected " + _value.toString + " to be truthy"
    report_(!!_value, message)
  }

  /**
   * Asserts that the value is equal to the given value.
   *
   * @param {*} other Object that this value should be equal to.
   */
  toEqual (other) {
    var message = "Expected " + _value.toString + " to equal " +  other.toString
    report_(_value == other, message)
  }

  /**
   * Asserts that this value generated a runtime error with the given message.
   *
   * @param {String} errorMessage Error message that should have been generated
   *                              by the value.
   */
  toBeARuntimeError (errorMessage) {
    if (!(_value is Fiber)) {
      var message = _value.toString + " was not a Fiber"
      report_(false, message)
      return
    }

    // Run the Fiber to generate the possible error.
    _value.try

    if (_value.error == null) {
      var message = "Expected a runtime error but it did not occur"
      report_(false, message)
    } else {
      var message = "Expected a runtime error with error: " + errorMessage +
          " but got: " + _value.error
      report_(_value.error == errorMessage, message)
    }
  }

  report_ (result, message) {
    result = _negated ? !result : result

    var expectation = new Expectation(result, message)
    Fiber.yield(expectation)
  }
}

/**
 * Convenience method for creating new Matchers in a more readable style.
 *
 * @param {*} value Value to create a new matcher for.
 * @return A new `Matchers` instance for the given value.
 */
var Expect = new Fn { |value|
  return new Matchers(value)
}