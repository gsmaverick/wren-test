import "src/matchers" for Expect
import "src/suite" for Suite

import "src/expectation" for Expectation

// Module under test.
import "src/runnable" for Runnable

var TestRunnable = new Suite("Runnable") {{
  // TODO: Figure out a good way to test beforeEach, afterEach behaviour.

  "should return the title": new Fn {
    var runnable = new Runnable("Test Title", new Fn{}, [], [])

    Expect.call(runnable.title).toEqual("Test Title")
  },

  "should wrap a bare function": new Fn {
    var testFn = new Fn {
      return new Expectation(true, "Fail")
    }
    var runnable = new Runnable("Test", testFn, [], [])

    var result = runnable.run

    Expect.call(result.size).toEqual(1)
    Expect.call(result[0].passed).toBeTruthy
    Expect.call(result[0].message).toEqual("Fail")
  },

  "should not return values yielded that aren't Expectation": new Fn {
    var testFiber = new Fiber {
      Fiber.yield(1)
    }
    var runnable = new Runnable("Test", testFiber, [], [])

    Expect.call(runnable.run.size).toEqual(0)
  },

  "should return all expectations emitted by the function": new Fn {
    var testFiber = new Fiber {
      Fiber.yield(new Expectation(true, "First"))

      // Yield a value that isn't an Expectation.
      Fiber.yield(false)

      Fiber.yield(new Expectation(false, "Second"))
    }
    var runnable = new Runnable("Test", testFiber, [], [])

    var result = runnable.run

    Expect.call(result[0].passed).toBeTruthy
    Expect.call(result[0].message).toEqual("First")
    Expect.call(result[1].passed).toBeFalsy
    Expect.call(result[1].message).toEqual("Second")
  }
}}