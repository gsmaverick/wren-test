import "src/matchers" for Expect
import "src/suite" for Suite

import "src/expectation" for Expectation

// Module under test ("Expect" is already imported above).
import "src/matchers" for Matchers

var TestMatchers = new Suite("Matchers") {
  // TODO: Write unit tests for toBeARuntimeError matcher.

  var matcher

  return {
    "beforeEach": new Fn {
      matcher = new Matchers("string")
    },

    "should return an instance of Matchers when calling Expect": new Fn {
      var matcher = Expect.call(true)

      Expect.call(matcher).toBe(Matchers)
    },

    "#not": {
      "should return itself": new Fn {
        Expect.call(matcher.not).toEqual(matcher)
      },

      "should negate the result": new Fn {
        var matchResult = new Fiber {
          matcher.not.toBe(Num)
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeTruthy
      },

      "should have the correct failure message": new Fn {
        var matchResult = new Fiber {
          matcher.not.toBe(Num)
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.message).toEqual(
            "Expected string of class String to be of class Num")
      }
    },

    "toBe": {
      "should be true": new Fn {
        var matchResult = new Fiber {
          matcher.toBe(String)
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeTruthy
      },

      "should be true for superclasses": new Fn {
        var matchResult = new Fiber {
          matcher.toBe(Object)
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeTruthy
      },

      "should be true for user-defined classes": new Fn {
        class Foo {}

        matcher = new Matchers(new Foo)
        var matchResult = new Fiber {
          matcher.toBe(Foo)
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeTruthy
      },

      "should have the correct failure message": new Fn {
        var matchResult = new Fiber {
          matcher.toBe(Num)
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeFalsy
        Expect.call(expectation.message).toEqual(
            "Expected string of class String to be of class Num")
      }
    },

    "toBeFalsy": {
      "should be true for boolean false": new Fn {
        var matchResult = new Fiber {
          var matcher = new Matchers(false)
          matcher.toBeFalsy
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeTruthy
      },

      "should be true for null": new Fn {
        var matchResult = new Fiber {
          var matcher = new Matchers(null)
          matcher.toBeFalsy
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeTruthy
      },

      "should have the correct failure message": new Fn {
        var matchResult = new Fiber {
          var matcher = new Matchers([])
          matcher.toBeFalsy
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeFalsy
        Expect.call(expectation.message).toEqual("Expected [] to be falsy")
      }
    },

    "toBeTrthy": {
      "should be true for boolean true": new Fn {
        var matchResult = new Fiber {
          var matcher = new Matchers(true)
          matcher.toBeTruthy
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeTruthy
      },

      "should not be true for null": new Fn {
        var matchResult = new Fiber {
          var matcher = new Matchers(null)
          matcher.toBeTruthy
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeFalsy
      },

      "should be true for anything else": new Fn {
        var matchResult = new Fiber {
          var matcher = new Matchers([])
          matcher.toBeTruthy
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeTruthy
      },

      "should have the correct failure message": new Fn {
        var matchResult = new Fiber {
          var matcher = new Matchers(false)
          matcher.toBeTruthy
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeFalsy
        Expect.call(expectation.message).toEqual("Expected false to be truthy")
      }
    },

    "toEqual": {
      "should work correctly": new Fn {
        var matchResult = new Fiber {
          matcher.toEqual("string")
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeTruthy
      },

      "should have the correct failure message": new Fn {
        var matchResult = new Fiber {
          matcher.toEqual("value")
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeFalsy
        Expect.call(expectation.message).toEqual(
            "Expected string to equal value")
      }
    }
  }
}