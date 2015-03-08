import "src/matchers" for Expect
import "src/suite" for Suite

import "src/expectation" for Expectation
import "src/matchers/num" for NumMatchers
import "test/test-utils" for MatcherTestHarness

var TestNumMatchers = new Suite("NumMatchers") { |it|
  it.suite("#toBeGreaterThan") { |it|
    it.should("return true for a user-defined class") {
      class UserDefined {
        > (other) { true }
      }

      var expectation = MatcherTestHarness.call {
        var matcher = new NumMatchers(new UserDefined)
        matcher.toBeGreaterThan(new UserDefined)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("return true for a number") {
      var expectation = MatcherTestHarness.call {
        var matcher = new NumMatchers(2)
        matcher.toBeGreaterThan(1)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("return the correct error message") {
      var expectation = MatcherTestHarness.call {
        var matcher = new NumMatchers(1)
        matcher.toBeGreaterThan(2)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.message).toEqual(
          "Expected 1 to be greater than 2")
    }
  }

  it.suite("#toBeLessThan") { |it|
    it.should("return true for a user-defined class") {
      class UserDefined {
        < (other) { true }
      }

      var expectation = MatcherTestHarness.call {
        var matcher = new NumMatchers(new UserDefined)
        matcher.toBeLessThan(new UserDefined)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("return true for a number") {
      var expectation = MatcherTestHarness.call {
        var matcher = new NumMatchers(1)
        matcher.toBeLessThan(2)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("return the correct error message") {
      var expectation = MatcherTestHarness.call {
        var matcher = new NumMatchers(2)
        matcher.toBeLessThan(1)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.message).toEqual(
          "Expected 2 to be less than 1")
    }
  }

  it.suite("#toBeBetween") { |it|
    it.should("return true for a user-defined class") {
      class UserDefined {
        < (other) { true }
        > (other) { true }
      }

      var expectation = MatcherTestHarness.call {
        var matcher = new NumMatchers(new UserDefined)
        matcher.toBeBetween(new UserDefined, new UserDefined)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("return true for numbers") {
      var expectation = MatcherTestHarness.call {
        var matcher = new NumMatchers(2)
        matcher.toBeBetween(1, 3)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTrue
    }

    it.should("return the correct error message") {
      var expectation = MatcherTestHarness.call {
        var matcher = new NumMatchers(2)
        matcher.toBeBetween(1, 2)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.message).toEqual(
          "Expected 2 to be between 1 and 2")
    }
  }
}