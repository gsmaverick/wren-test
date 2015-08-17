import "src/matchers" for Expect
import "src/suite" for Suite

import "src/expectation" for Expectation
import "src/matchers/base" for BaseMatchers
import "src/matchers/fiber" for FiberMatchers
import "test/test-utils" for MatcherTestHarness

var TestFiberMatchers = Suite.new("FiberMatchers") { |it|
  it.suite("#toBeDone") { |it|
    it.should("pass if the fiber is done") {
      var fiber = Fiber.new {}
      fiber.call()

      var expectation = MatcherTestHarness.call {
        var matcher = FiberMatchers.new(fiber)
        matcher.toBeDone
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("fail if the fiber is not done") {
      var fiber = Fiber.new {
        Fiber.yield(1)
      }
      fiber.call()

      var expectation = MatcherTestHarness.call {
        var matcher = FiberMatchers.new(fiber)
        matcher.toBeDone
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
      Expect.call(expectation.message).toEqual("Expected the fiber to be done")
    }

    it.should("abort the fiber if the value given is not a fiber") {
      var fiber = Fiber.new {
        var matcher = FiberMatchers.new("not a fiber")
        matcher.toBeDone
      }

      fiber.try()

      Expect.call(fiber.isDone).toBeTrue
      Expect.call(fiber.error).toEqual("not a fiber was not a Fiber")
    }
  }

  it.suite("#toBeARuntimeError") { |it|
    it.should("abort the fiber if the value given is not a fiber") {
      var fiber = Fiber.new {
        var matcher = FiberMatchers.new("not a fiber")
        matcher.toBeARuntimeError
      }

      fiber.try()

      Expect.call(fiber.isDone).toBeTrue
      Expect.call(fiber.error).toEqual("not a fiber was not a Fiber")
    }

    it.should("return true") {
      var expectation = MatcherTestHarness.call {
        var matcher = FiberMatchers.new(Fiber.new { 1.try })
        matcher.toBeARuntimeError
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("return true with an error message") {
      var expectation = MatcherTestHarness.call {
        var matcher = FiberMatchers.new(Fiber.new { 1.try })
        matcher.toBeARuntimeError("Num does not implement 'try'.")
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("fail if there was no runtime error") {
      var expectation = MatcherTestHarness.call {
        var matcher = FiberMatchers.new(Fiber.new {})
        matcher.toBeARuntimeError
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
      Expect.call(expectation.message).toEqual(
        "Expected a runtime error but it did not occur")
    }

    it.should("fail if there was no runtime error with an error message") {
      var expectation = MatcherTestHarness.call {
        var matcher = FiberMatchers.new(Fiber.new {})
        matcher.toBeARuntimeError("Error message")
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
      Expect.call(expectation.message).toEqual(
        "Expected a runtime error but it did not occur")
    }

    it.should("fail if runtime error had the wrong error message") {
      var expectation = MatcherTestHarness.call {
        var matcher = FiberMatchers.new(Fiber.new { 1.try })
        matcher.toBeARuntimeError("Error message")
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
      Expect.call(expectation.message).toEqual(
        "Expected a runtime error with error: Error message but got: Num " +
        "does not implement 'try'.")
    }
  }

  it.suite("#toYield").skip { |it|
    it.should("abort the fiber if the value given is not a fiber") {
      var fiber = Fiber.new {
        var matcher = FiberMatchers.new("not a fiber")
        matcher.toYield([])
      }

      fiber.try()

      Expect.call(fiber.isDone).toBeTrue
      Expect.call(fiber.error).toEqual("not a fiber was not a Fiber")
    }
  }
}
