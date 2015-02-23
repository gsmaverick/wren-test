import "src/matchers" for Expect
import "src/suite" for Suite

// Module under test.
import "src/expectation" for Expectation

var TestExpectation = new Suite("Expectation") {
  var expectation

  return {
    "beforeEach": new Fn {
        expectation = new Expectation(true, "Failure message")
    },

    "should admit whether the expectation passed": new Fn {
        Expect.call(expectation.passed).toBeTruthy
    },

    "should return the failure message": new Fn {
        Expect.call(expectation.message).toEqual("Failure message")
    }
  }
}