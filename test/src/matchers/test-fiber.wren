import "src/matchers" for Expect
import "src/suite" for Suite

import "src/expectation" for Expectation
import "src/matchers/base" for BaseMatchers
import "src/matchers/fiber" for FiberMatchers

var runMatcher = new Fn { |block|
  var f = new Fiber(block)
  return f.try
}

var TestFiberMatchers = new Suite("FiberMatchers") {{
  "should be a subclass of BaseMatchers": new Fn {
    var matcher = new FiberMatchers

    Expect.call(matcher).toBe(BaseMatchers)
  },

  // TODO: "#toBeARuntimeError"
  // TODO: "#toYield"

  "#toBeDone": {
    "should pass if the fiber is done": new Fn {
      var fiber = new Fiber {}
      fiber.call

      var expectation = runMatcher.call {
        var matcher = new FiberMatchers(fiber)
        matcher.toBeDone
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTruthy
    },

    "should fail if the fiber is not done": new Fn {
      var fiber = new Fiber {
        Fiber.yield(1)
      }
      fiber.call

      var expectation = runMatcher.call {
        var matcher = new FiberMatchers(fiber)
        matcher.toBeDone
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalsy
      Expect.call(expectation.message).toEqual("Expected the fiber to be done")
    },

    "should abort the fiber if the value given is not a fiber": new Fn {
      var fiber = new Fiber {
        var matcher = new FiberMatchers("not a fiber")
        matcher.toBeDone
      }

      fiber.try

      Expect.call(fiber.isDone).toBeTruthy
      Expect.call(fiber.error).toEqual("not a fiber was not a Fiber")
    }
  }
}}