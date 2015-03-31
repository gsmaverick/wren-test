import "src/stub" for Stub
import "src/matchers/range" for RangeMatchers

class StubMatchers is RangeMatchers {
  /**
   * Assert that this stub was called at least once.
   */
  toHaveBeenCalled {
    enforceClass_(Stub)

    var message = "Expected " + value.name + " to have been called"
    report_(value.called, message)
  }

  /**
   * Assert that this stub was called a certain number of times.
   *
   * @param {Num} times Number of times this stub should have been called.
   */
  toHaveBeenCalled (times) {
    enforceClass_(Stub)

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
    enforceClass_(Stub)

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
          return
        }
      }
    }

    var message = "Expected " + value.name + " to have been called with " +
        args.toString + " but was never called. Calls were:\n    " +
        value.calls.join("\n    ")
    report_(false, message)
  }
}