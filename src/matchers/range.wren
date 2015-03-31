import "src/matchers/num" for NumMatchers

/**
 * A class of matchers for making assertions about ranges.
 */
class RangeMatchers is NumMatchers {
  /**
   * Assert that the value contains the given range.
   *
   * @param {Range} other The range that should be contained within the range
   *                      represented by the value.
   */
  toContain (other) {
    enforceClass_(Range)

    var result = rangeIsContainedBy_(value, other)
    var message = "Expected " + value.toString + " to contain " + other.toString
    report_(result, message)
  }

  /**
   * Assert that the value is contained within the given range.
   *
   * @param {Range} other The range that should contain this range represented
   *                      by the value.
   */
  toBeContainedBy (other) {
    enforceClass_(Range)

    var result = rangeIsContainedBy_(other, value)
    var message = "Expected " + value.toString + " to be contained by " +
        other.toString
    report_(result, message)
  }

  rangeIsContainedBy_ (parent, child) {
    var parentTo = parent.isInclusive ? parent.to : (parent.to - 1)
    var childTo = child.isInclusive ? child.to : (child.to - 1)

    return (child.from >= parent.from) && (childTo <= parentTo)
  }
}