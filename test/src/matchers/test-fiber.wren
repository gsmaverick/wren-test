import "src/matchers" for Expect
import "src/suite" for Suite

import "src/expectation" for Expectation
import "src/matchers/base" for BaseMatchers
import "src/matchers/fiber" for FiberMatchers
import "test/test-utils" for MatcherTestHarness

var TestFiberMatchers = new Suite("FiberMatchers") { |it|
  // TODO: "#toBeARuntimeError"
  // TODO: "#toYield"

  it.suite("#toBeDone") { |it|
    it.should("pass if the fiber is done") {
      var fiber = new Fiber {}
      fiber.call()

      var expectation = MatcherTestHarness.call {
        var matcher = new FiberMatchers(fiber)
        matcher.toBeDone
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("fail if the fiber is not done") {
      var fiber = new Fiber {
        Fiber.yield(1)
      }
      fiber.call()

      var expectation = MatcherTestHarness.call {
        var matcher = new FiberMatchers(fiber)
        matcher.toBeDone
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
      Expect.call(expectation.message).toEqual("Expected the fiber to be done")
    }

    it.should("abort the fiber if the value given is not a fiber") {
      var fiber = new Fiber {
        var matcher = new FiberMatchers("not a fiber")
        matcher.toBeDone
      }

      fiber.try()

      Expect.call(fiber.isDone).toBeTrue
      Expect.call(fiber.error).toEqual("not a fiber was not a Fiber")
    }
  }
}