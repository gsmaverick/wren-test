import "src/matchers/stub" for StubMatchers

/**
 * A class of matchers for making assertions about ranges.
 */
class RangeMatchers is StubMatchers {
  /**
   * Assert that the value contains the given range.
   *
   * @param {Range} other The range that should be contained within the range
   *                      represented by the value.
   */
  toContain (other) {
    ensureValueIsRange_

    var otherIsContained = (other.from >= value.from) && (other.to <= value.to)
    var message = "Expected " + value.toString + " to contain " + other.toString
    report_(otherIsContained, message)
  }

  /**
   * Assert that the value is contained within the given range.
   *
   * @param {Range} other The range that should contain this range represented
   *                      by the value.
   */
  toBeContainedBy (other) {
    ensureValueIsRange_

    var valueIsContained = (value.from >= other.from) && (value.to <= other.to)
    var message = "Expected " + value.toString + " to be contained by " +
        other.toString
    report_(valueIsContained, message)
  }

  /**
   * @return True if the value of this matcher is a Range, otherwise emits a
   *         failed Expectation and returns false.
   */
  ensureValueIsRange_ {
    if (!(value is Range)) {
      Fiber.abort(value.toString + " was not a Range")
    }
  }
}