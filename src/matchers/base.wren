import "src/expectation" for Expectation

/**
 * A class of matchers to use for making assertions.
 */
class BaseMatchers {
  /**
   * Create a new `Matcher` object for a value.
   *
   * @param {*} value The value to be matched on.
   */
  new (value) {
    _value = value
  }

  /**
   * @return The value for which this matcher was constructed.
   */
  value { _value }

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
   * Asserts that the value is false.
   */
  toBeFalse {
    var message = "Expected " + _value.toString + " to be false"
    report_(_value == false, message)
  }

  /**
   * Asserts that the value is true.
   */
  toBeTrue {
    var message = "Expected " + _value.toString + " to be true"
    report_(_value == true, message)
  }

  /**
   * Asserts that the value is null.
   */
  toBeNull {
    var message = "Expected " + _value.toString + " to be null"
    report_(_value == null, message)
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

  report_ (result, message) {
    result = _negated ? !result : result

    var expectation = new Expectation(result, message)
    Fiber.yield(expectation)
  }

  /**
   * Enforces that the value for this matcher instance is of a certain class. If
   * the value is not of the specified type the current Fiber will be aborted
   * with an error message.
   *
   * @param {Class} klass Type of which the value should be an instance.
   */
  enforceClass_ (klass) {
    if (!(value is klass)) {
      Fiber.abort(value.toString + " was not a " + klass.toString)
    }
  }
}