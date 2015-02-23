class Expectation {
  /**
   * Create a new expectation result instance.
   *
   * @param {Bool} passed Whether this expectation was successful.
   * @param {String} message Message to print if the expectation was not
   *                         successful.
   */
  new(passed, message) {
    _passed = passed
    _message = message
  }

  /**
   * @return {Bool} Whether or not this expectation was successful.
   */
  passed { _passed }

  /**
   * @return {String} Message that explains the failure mode of this
   * expectation.
   */
  message { _message }
}