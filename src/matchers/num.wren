import "src/matchers/range" for RangeMatchers

class NumMatchers is RangeMatchers {
  /**
   * Assert that the value is greater than some value. This matcher works on any
   * class that defines the `>` operator.
   */
  toBeGreaterThan (other) {
    report_(value > other, "Expected " + value.toString + " to be greater " +
        "than " + other.toString)
  }

  /**
   * Assert that the value is less than some value. This matcher works on any
   * class that defines the `<` operator.
   */
  toBeLessThan (other) {
    report_(value < other, "Expected " + value.toString + " to be less than " +
        other.toString)
  }

  /**
   * Assert that the value is between two values. This matches works on any
   * class that defines the `<` and `>` operator.
   */
  toBeBetween (min, max) {
    var message = "Expected " + value.toString + " to be between " +
        min.toString + " and " + max.toString
    report_(value > min && value < max, message)
  }
}