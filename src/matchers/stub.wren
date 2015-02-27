import "src/stub" for Stub
import "src/matchers/fiber" for FiberMatchers

class StubMatchers is FiberMatchers {
  /**
   * Assert that this stub was called at least once.
   */
  toHaveBeenCalled {
    ensureValueIsStub_

    var message = "Expected " + value.name + " to have been called"
    report_(value.called, message)
  }

  /**
   * Assert that this stub was called a certain number of times.
   *
   * @param {Num} times Number of times this stub should have been called.
   */
  toHaveBeenCalled (times) {
    ensureValueIsStub_

    var message = "Expected " + value.name + " to have been called " +
        times.toString + " times but was called " + value.calls.count.toString +
        " times"
    report_(value.calls.count == times, message)
  }

  /**
   * Assert that this stub was called with the given arguments.
   *
   * @param {Sequence[*]} args Arguments that the stub should have been called
   *                           with.
   */
  toHaveBeenCalledWith (args) {
    ensureValueIsStub_

    for (call in value.calls) {
      // Ignore any call lists that aren't the same size.
      if (call.count == args.count) {
        var i = 0

        var argsEqual = call.all { |callArg|
          i = i + 1
          return callArg == args[i - 1]
        }

        if (argsEqual) {
          report_(true, "")
          // TODO: Add a test to ensure that we only return a single Expectation
          // if the matcher is true.
          return
        }
      }
    }

    var message = "Expected " + value.name + " to have been called with " +
        args.toString + " but was never called. Calls were:\n    " +
        value.calls.join("\n    ")
    report_(false, message)
  }

  /**
   * @return True if the value of this matcher is a Stub, otherwise emits a
   *         failed Expectation and returns false.
   */
  ensureValueIsStub_ {
    if (!(value is Stub)) {
      Fiber.abort("Expected " + value.toString + " to be an instance of Stub")
    }
  }
}