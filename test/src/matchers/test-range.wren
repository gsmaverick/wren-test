import "src/matchers" for Expect
import "src/suite" for Suite

import "src/expectation" for Expectation
import "src/matchers/range" for RangeMatchers
import "test/test-utils" for MatcherTestHarness

var TestRangeMatchers = Suite.new("RangeMatchers") { |it|
  it.suite("#toContain") { |it|
    it.should("abort the fiber if the value given is not a range") {
      var fiber = Fiber.new {
        var matcher = RangeMatchers.new("not a range")
        matcher.toContain(1..3)
      }

      fiber.try()

      Expect.call(fiber.isDone).toBeTrue
      Expect.call(fiber.error).toEqual("not a range was not a Range")
    }

    it.should("return true") {
      var expectation = MatcherTestHarness.call {
        var matcher = RangeMatchers.new(1..3)
        matcher.toContain(1...2)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("return false for include & exclusive range of same points") {
      var expectation = MatcherTestHarness.call {
        var matcher = RangeMatchers.new(1...3)
        matcher.toContain(1..3)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
    }

    it.should("have the right error message") {
      var expectation = MatcherTestHarness.call {
        var matcher = RangeMatchers.new(3..6)
        matcher.toContain(1...4)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
      Expect.call(expectation.message).toEqual("Expected 3..6 to contain 1...4")
    }
  }

  it.suite("#toBeContainedBy") { |it|
    it.should("abort the fiber if the value given is not a range") {
      var fiber = Fiber.new {
        var matcher = RangeMatchers.new("not a range")
        matcher.toBeContainedBy(1..3)
      }

      fiber.try()

      Expect.call(fiber.isDone).toBeTrue
      Expect.call(fiber.error).toEqual("not a range was not a Range")
    }

    it.should("return true") {
      var expectation = MatcherTestHarness.call {
        var matcher = RangeMatchers.new(1..2)
        matcher.toBeContainedBy(1...3)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("return false for include & exclusive range of same points") {
      var expectation = MatcherTestHarness.call {
        var matcher = RangeMatchers.new(1..3)
        matcher.toBeContainedBy(1...3)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
    }

    it.should("have the right error message") {
      var expectation = MatcherTestHarness.call {
        var matcher = RangeMatchers.new(3..6)
        matcher.toBeContainedBy(1...3)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
      Expect.call(expectation.message).toEqual(
          "Expected 3..6 to be contained by 1...3")
    }
  }
}
