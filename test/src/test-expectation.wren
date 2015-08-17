import "src/matchers" for Expect
import "src/suite" for Suite

// Module under test.
import "src/expectation" for Expectation

var TestExpectation = Suite.new("Expectation") { |it|
  var expectation

  it.beforeEach {
    expectation = Expectation.new(true, "Failure message")
  }

  it.should("admit whether the expectation passed") {
    Expect.call(expectation.passed).toBeTrue
  }

  it.should("return the failure message") {
    Expect.call(expectation.message).toEqual("Failure message")
  }
}
