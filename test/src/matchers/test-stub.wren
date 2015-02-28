import "src/matchers" for Expect
import "src/stub" for Stub
import "src/suite" for Suite

import "src/expectation" for Expectation
import "src/matchers/stub" for StubMatchers

var runMatcher = new Fn { |block|
  var f = new Fiber(block)
  return f.try()
}

var TestStubMatchers = new Suite("StubMatchers") { |it|
  it.suite("#toHaveBeenCalled") { |it|
    it.should("abort the fiber if the value given is not a stub") {
      var fiber = new Fiber {
        var matcher = new StubMatchers("not a stub")
        matcher.toHaveBeenCalled
      }

      fiber.try()

      Expect.call(fiber.isDone).toBeTruthy
      Expect.call(fiber.error).toEqual("Expected not a stub to be an " +
          "instance of Stub")
    }

    it.should("be false if the stub has not been called") {
      var stub = new Stub("stub")

      var expectation = runMatcher.call {
        var matcher = new StubMatchers(stub)
        matcher.toHaveBeenCalled
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalsy
      Expect.call(expectation.message).toEqual(
          "Expected stub to have been called")
    }

    it.should("be true if the stub has been called at least once") {
      var stub = new Stub("stub")
      stub.call

      var expectation = runMatcher.call {
        var matcher = new StubMatchers(stub)
        matcher.toHaveBeenCalled
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTruthy
    }

    it.should("be false if stub was not called the right number of times") {
      var stub = new Stub("stub")
      stub.call

      var expectation = runMatcher.call {
        var matcher = new StubMatchers(stub)
        matcher.toHaveBeenCalled(2)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalsy
      Expect.call(expectation.message).toEqual(
          "Expected stub to have been called 2 times but was called 1 times")

      stub.call
      stub.call

      expectation = runMatcher.call {
        var matcher = new StubMatchers(stub)
        matcher.toHaveBeenCalled(2)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalsy
      Expect.call(expectation.message).toEqual(
          "Expected stub to have been called 2 times but was called 3 times")
    }

    it.should("be true if the stub was called the right number of times") {
      var stub = new Stub("stub")
      stub.call
      stub.call

      var expectation = runMatcher.call {
        var matcher = new StubMatchers(stub)
        matcher.toHaveBeenCalled(2)
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTruthy
    }
  }

  it.suite("#toHaveBeenCalledWith") { |it|
    it.should("abort the fiber if the value given is not a stub") {
      var fiber = new Fiber {
        var matcher = new StubMatchers("not a stub")
        matcher.toHaveBeenCalledWith(1)
      }

      fiber.try()

      Expect.call(fiber.isDone).toBeTruthy
      Expect.call(fiber.error).toEqual("Expected not a stub to be an " +
          "instance of Stub")
    }

    it.should("be false if the stub was not called with the given args") {
      var stub = new Stub("stub")
      stub.call(1)

      var expectation = runMatcher.call {
        var matcher = new StubMatchers(stub)
        matcher.toHaveBeenCalledWith([2])
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeFalsy
      Expect.call(expectation.message).toEqual("Expected stub to have been " +
          "called with [2] but was never called. Calls were:\n    [1]")
    }

    it.should("be true if the stub was called with the given args") {
      var stub = new Stub("stub")
      stub.call(1)
      stub.call(2)
      stub.call(3, 4)

      var expectation = runMatcher.call {
        var matcher = new StubMatchers(stub)
        matcher.toHaveBeenCalledWith([2])
      }

      Expect.call(expectation).toBe(Expectation)
      Expect.call(expectation.passed).toBeTruthy
    }
  }
}