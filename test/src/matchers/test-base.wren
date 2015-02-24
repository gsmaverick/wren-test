import "src/matchers" for Expect
import "src/suite" for Suite

import "src/expectation" for Expectation
import "src/matchers/base" for BaseMatchers

var TestBaseMatchers = new Suite("BaseMatchers") {
  var matcher

  return {
    "beforeEach": new Fn {
      matcher = new BaseMatchers("string")
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

    "#toBe": {
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

        matcher = new BaseMatchers(new Foo)
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

    "#toBeFalsy": {
      "should be true for boolean false": new Fn {
        var matchResult = new Fiber {
          var matcher = new BaseMatchers(false)
          matcher.toBeFalsy
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeTruthy
      },

      "should be true for null": new Fn {
        var matchResult = new Fiber {
          var matcher = new BaseMatchers(null)
          matcher.toBeFalsy
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeTruthy
      },

      "should have the correct failure message": new Fn {
        var matchResult = new Fiber {
          var matcher = new BaseMatchers([])
          matcher.toBeFalsy
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeFalsy
        Expect.call(expectation.message).toEqual("Expected [] to be falsy")
      }
    },

    "#toBeTrthy": {
      "should be true for boolean true": new Fn {
        var matchResult = new Fiber {
          var matcher = new BaseMatchers(true)
          matcher.toBeTruthy
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeTruthy
      },

      "should not be true for null": new Fn {
        var matchResult = new Fiber {
          var matcher = new BaseMatchers(null)
          matcher.toBeTruthy
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeFalsy
      },

      "should be true for anything else": new Fn {
        var matchResult = new Fiber {
          var matcher = new BaseMatchers([])
          matcher.toBeTruthy
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeTruthy
      },

      "should have the correct failure message": new Fn {
        var matchResult = new Fiber {
          var matcher = new BaseMatchers(false)
          matcher.toBeTruthy
        }

        var expectation = matchResult.try
        Expect.call(expectation).toBe(Expectation)
        Expect.call(expectation.passed).toBeFalsy
        Expect.call(expectation.message).toEqual("Expected false to be truthy")
      }
    },

    "#toEqual": {
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