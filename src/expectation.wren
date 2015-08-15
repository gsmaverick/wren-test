/**
 * An Expectation captures an assertion about a value made in a test block. It
 * is used by the default matchers to communicate the pass/fail state of a test
 * block and can be used by other matcher implementations if you need to extend
 * the deafault matchers.
 */
class Expectation {
  /**
   * Create a new expectation result instance.
   *
   * @param {Bool} passed Whether this expectation was successful.
   * @param {String} message Message to print if the expectation was not
   *                         successful.
   */
  construct new(passed, message) {
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
