import "src/matchers" for Expect
import "src/suite" for Suite

import "src/expectation" for Expectation
import "src/matchers/base" for BaseMatchers

var TestBaseMatchers = new Suite("BaseMatchers") { |it|
  var matcher

  it.beforeEach {
    matcher = new BaseMatchers("string")
  }

  it.suite("#not") { |it|
    it.should("return itself") {
      Expect.call(matcher.not).toEqual(matcher)
    }

    it.should("negate the result") {
      var matchResult = new Fiber {
        matcher.not.toBe(Num)
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTruthy
    }

    it.should("have the correct failure message") {
      var matchResult = new Fiber {
        matcher.not.toBe(Num)
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.message).toEqual(
          "Expected string of class String to be of class Num")
    }
  }

  it.suite("#toBe") { |it|
    it.should("be true") {
      var matchResult = new Fiber {
        matcher.toBe(String)
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTruthy
    }

    it.should("be true for superclasses") {
      var matchResult = new Fiber {
        matcher.toBe(Object)
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTruthy
    }

    it.should("be true for user-defined classes") {
      class Foo {}

      matcher = new BaseMatchers(new Foo)
      var matchResult = new Fiber {
        matcher.toBe(Foo)
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTruthy
    }

    it.should("have the correct failure message") {
      var matchResult = new Fiber {
        matcher.toBe(Num)
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalsy
      Expect.call(expectation.message).toEqual(
          "Expected string of class String to be of class Num")
    }
  }

  it.suite("#toBeFalsy") { |it|
    it.should("be true for boolean false") {
      var matchResult = new Fiber {
        var matcher = new BaseMatchers(false)
        matcher.toBeFalsy
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTruthy
    }

    it.should("be true for null") {
      var matchResult = new Fiber {
        var matcher = new BaseMatchers(null)
        matcher.toBeFalsy
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTruthy
    }

    it.should("have the correct failure message") {
      var matchResult = new Fiber {
        var matcher = new BaseMatchers([])
        matcher.toBeFalsy
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalsy
      Expect.call(expectation.message).toEqual("Expected [] to be falsy")
    }
  }

  it.suite("#toBeTrthy") { |it|
    it.should("be true for boolean true") {
      var matchResult = new Fiber {
        var matcher = new BaseMatchers(true)
        matcher.toBeTruthy
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTruthy
    }

    it.should("not be true for null") {
      var matchResult = new Fiber {
        var matcher = new BaseMatchers(null)
        matcher.toBeTruthy
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalsy
    }

    it.should("be true for anything else") {
      var matchResult = new Fiber {
        var matcher = new BaseMatchers([])
        matcher.toBeTruthy
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTruthy
    }

    it.should("should have the correct failure message") {
      var matchResult = new Fiber {
        var matcher = new BaseMatchers(false)
        matcher.toBeTruthy
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalsy
      Expect.call(expectation.message).toEqual("Expected false to be truthy")
    }
  }

  it.suite("#toEqual") { |it|
    it.should("work correctly") {
      var matchResult = new Fiber {
        matcher.toEqual("string")
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTruthy
    }

    it.should("have the correct failure message") {
      var matchResult = new Fiber {
        matcher.toEqual("value")
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalsy
      Expect.call(expectation.message).toEqual(
          "Expected string to equal value")
    }
  }
}