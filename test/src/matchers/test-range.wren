import "src/matchers" for Expect
import "src/suite" for Suite

import "src/expectation" for Expectation
import "src/matchers/range" for RangeMatchers
import "test/test-utils" for MatcherTestHarness

var TestRangeMatchers = new Suite("RangeMatchers") { |it|
  it.suite("#toContain") { |it|
    it.should("abort the fiber if the value given is not a range") {
      var fiber = new Fiber {
        var matcher = new RangeMatchers("not a range")
        matcher.toContain(1..3)
      }

      fiber.try()

      Expect.call(fiber.isDone).toBeTrue
      Expect.call(fiber.error).toEqual("not a range was not a Range")
    }

    it.should("return true") {
      var expectation = MatcherTestHarness.call {
        var matcher = new RangeMatchers(1..3)
        matcher.toContain(1...2)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("have the right error message") {
      var expectation = MatcherTestHarness.call {
        var matcher = new RangeMatchers(1..3)
        matcher.toContain(1...4)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
      Expect.call(expectation.message).toEqual("Expected 1..3 to contain 1...4")
    }
  }

  it.suite("#toBeContainedBy") { |it|
    it.should("abort the fiber if the value given is not a range") {
      var fiber = new Fiber {
        var matcher = new RangeMatchers("not a range")
        matcher.toBeContainedBy(1..3)
      }

      fiber.try()

      Expect.call(fiber.isDone).toBeTrue
      Expect.call(fiber.error).toEqual("not a range was not a Range")
    }

    it.should("return true") {
      var expectation = MatcherTestHarness.call {
        var matcher = new RangeMatchers(1..2)
        matcher.toBeContainedBy(1...3)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("have the right error message") {
      var expectation = MatcherTestHarness.call {
        var matcher = new RangeMatchers(1..4)
        matcher.toBeContainedBy(1...3)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
      Expect.call(expectation.message).toEqual(
          "Expected 1..4 to be contained by 1...3")
    }
  }
}