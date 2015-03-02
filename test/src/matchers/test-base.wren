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
      Expect.call(expectation.passed).toBeTrue
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
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("be true for superclasses") {
      var matchResult = new Fiber {
        matcher.toBe(Object)
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("be true for user-defined classes") {
      class Foo {}

      matcher = new BaseMatchers(new Foo)
      var matchResult = new Fiber {
        matcher.toBe(Foo)
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("have the correct failure message") {
      var matchResult = new Fiber {
        matcher.toBe(Num)
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
      Expect.call(expectation.message).toEqual(
          "Expected string of class String to be of class Num")
    }
  }

  it.suite("#toBeFalse") { |it|
    it.should("be true for boolean false") {
      var matchResult = new Fiber {
        var matcher = new BaseMatchers(false)
        matcher.toBeFalse
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("be false for null") {
      var matchResult = new Fiber {
        var matcher = new BaseMatchers(null)
        matcher.toBeFalse
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
    }

    it.should("have the correct failure message") {
      var matchResult = new Fiber {
        var matcher = new BaseMatchers([])
        matcher.toBeFalse
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
      Expect.call(expectation.message).toEqual("Expected [] to be false")
    }
  }

  it.suite("#toBeTrue") { |it|
    it.should("be true for boolean true") {
      var matchResult = new Fiber {
        var matcher = new BaseMatchers(true)
        matcher.toBeTrue
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("not be true for null") {
      var matchResult = new Fiber {
        var matcher = new BaseMatchers(null)
        matcher.toBeTrue
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
    }

    it.should("not be true for anything else") {
      var matchResult = new Fiber {
        var matcher = new BaseMatchers([])
        matcher.toBeTrue
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
    }

    it.should("should have the correct failure message") {
      var matchResult = new Fiber {
        var matcher = new BaseMatchers(false)
        matcher.toBeTrue
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
      Expect.call(expectation.message).toEqual("Expected false to be true")
    }
  }

  it.suite("#toBeNull") { |it|
    it.should("be true") {
      var matchResult = new Fiber {
        var matcher = new BaseMatchers(null)
        matcher.toBeNull
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("not be true for any other value") {
      var matchResult = new Fiber {
        var matcher = new BaseMatchers(1)
        matcher.toBeNull
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
      Expect.call(expectation.message).toEqual("Expected 1 to be null")
    }
  }

  it.suite("#toEqual") { |it|
    it.should("work correctly") {
      var matchResult = new Fiber {
        matcher.toEqual("string")
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("have the correct failure message") {
      var matchResult = new Fiber {
        matcher.toEqual("value")
      }

      var expectation = matchResult.try()
      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalse
      Expect.call(expectation.message).toEqual(
          "Expected string to equal value")
    }
  }
}