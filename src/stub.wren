/**
 * This class provides a way to create a stub function that can used in place of
 * a real method with additional tracking and introspection capabilities.
 *
 * This class takes advantage of the `call` semantics of Wren to create a class
 * that can be passed around like a function by virtue of defining the
 * appropriate `call` methods for any number of allowed arguments.
 *
 * This class does not contain any matcher methods instead look at StubMatchers
 * for matchers that work with Stub instances.
 *
 * A number of static constructor helper methods are provided to make stub
 * creation more readable in context.
 */
class Stub {
  /**
   * Create a new Stub instance that returns nothing when invoked.
   *
   * @param {String} name Name of the stub instance.
   */
  new (name) {
    _name = name
    _calls = []
  }

  /**
   * Create a new Stub instance that calls the given function when invoked.
   *
   * @param {String} name Name of the stub instance.
   * @param {Fn} fakeFn Function to call when this stub is invoked.
   */
  new (name, fakeFn) {
    _name = name
    _fakeFn = fakeFn
    _calls = []
  }

  /**
   * Creates a Stub that calls the given fake function when called.
   *
   * @param {String} name Name of the stub instance.
   * @param {Fn} fakeFn Function that should be called every time this stub is
   *                    called.
   * @return {Stub} Instance that calls the fake function when called with any
   * number of arguments.
   */
  static andCallFake (name, fakeFn) {
    return new Stub(name, fakeFn)
  }

  /**
   * Creates a Stub that always returns the same value when called.
   *
   * @param {String} name Name of the stub instance.
   * @param {*} returnValue Value that should be returned when this stub is
   *                        called.
   * @return {Stub} Instance that returns a value when called with any number of
   * arguments.
   */
  static andReturnValue (name, returnValue) {
    // Wrap the bare return value in a function to unify interfaces.
    var valueReturningFn = new Fn { |args| returnValue }

    return new Stub(name, valueReturningFn)
  }

  /**
   * @return {Bool} Whether or not the stub has been called.
   */
  called { _calls.size != 0 }

  /**
   * @return {Sequence[Sequence[*]]} List of lists containing the arguments that
   * each call to this stub provided.
   */
  calls { _calls }

  /**
   * @return {Sequence[*]} List of arguments for the first call on this stub.
   */
  firstCall {
    if (_calls.size > 0) {
      return _calls[0]
    }
  }

  /**
   * @return {Sequence[*]} List of arguments for the most recent call on this
   * stub.
   */
  mostRecentCall {
    if (_calls.size > 0) {
      return _calls[_calls.size - 1]
    }
  }

  /**
   * Clears all tracking for this stub.
   */
  reset {
    _calls = []
  }

  call {
    _calls.add([])

    if (_fakeFn) {
      return _fakeFn.call([])
    }
  }

  call (a) {
    _calls.add([a])

    if (_fakeFn) {
      return _fakeFn.call([a])
    }
  }

  call (a, b) {
    _calls.add([a, b])

    if (_fakeFn) {
      return _fakeFn.call([a, b])
    }
  }

  call (a, b, c) {
    _calls.add([a, b, c])

    if (_fakeFn) {
      return _fakeFn.call([a, b, c])
    }
  }

  call (a, b, c, d) {
    _calls.add([a, b, c, d])

    if (_fakeFn) {
      return _fakeFn.call([a, b, c, d])
    }
  }

  call (a, b, c, d, e) {
    _calls.add([a, b, c, d, e])

    if (_fakeFn) {
      return _fakeFn.call([a, b, c, d, e])
    }
  }

  call (a, b, c, d, e, f) {
    _calls.add([a, b, c, d, e, f])

    if (_fakeFn) {
      return _fakeFn.call([a, b, c, d, e, f])
    }
  }

  call (a, b, c, d, e, f, g) {
    _calls.add([a, b, c, d, e, f, g])

    if (_fakeFn) {
      return _fakeFn.call([a, b, c, d, e, f, g])
    }
  }

  call (a, b, c, d, e, f, g, h) {
    _calls.add([a, b, c, d, e, f, g, h])

    if (_fakeFn) {
      return _fakeFn.call([a, b, c, d, e, f, g, h])
    }
  }

  call (a, b, c, d, e, f, g, h, i) {
    _calls.add([a, b, c, d, e, f, g, h, i])

    if (_fakeFn) {
      return _fakeFn.call([a, b, c, d, e, f, g, h, i])
    }
  }

  call (a, b, c, d, e, f, g, h, i, j) {
    _calls.add([a, b, c, d, e, f, g, h, i, j])

    if (_fakeFn) {
      return _fakeFn.call([a, b, c, d, e, f, g, h, i, j])
    }
  }

  call (a, b, c, d, e, f, g, h, i, j) {
    _calls.add([a, b, c, d, e, f, g, h, i, j])

    if (_fakeFn) {
      return _fakeFn.call([a, b, c, d, e, f, g, h, i, j])
    }
  }

  call (a, b, c, d, e, f, g, h, i, j, k) {
    _calls.add([a, b, c, d, e, f, g, h, i, j, k])

    if (_fakeFn) {
      return _fakeFn.call([a, b, c, d, e, f, g, h, i, j, k])
    }
  }

  call (a, b, c, d, e, f, g, h, i, j, k, l) {
    _calls.add([a, b, c, d, e, f, g, h, i, j, k, l])

    if (_fakeFn) {
      return _fakeFn.call([a, b, c, d, e, f, g, h, i, j, k, l])
    }
  }

  call (a, b, c, d, e, f, g, h, i, j, k, l, m) {
    _calls.add([a, b, c, d, e, f, g, h, i, j, k, l, m])

    if (_fakeFn) {
      return _fakeFn.call([a, b, c, d, e, f, g, h, i, j, k, l, m])
    }
  }

  call (a, b, c, d, e, f, g, h, i, j, k, l, m, n) {
    _calls.add([a, b, c, d, e, f, g, h, i, j, k, l, m, n])

    if (_fakeFn) {
      return _fakeFn.call([a, b, c, d, e, f, g, h, i, j, k, l, m, n])
    }
  }

  call (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o) {
    _calls.add([a, b, c, d, e, f, g, h, i, j, k, l, m, n, o])

    if (_fakeFn) {
      return _fakeFn.call([a, b, c, d, e, f, g, h, i, j, k, l, m, n, o])
    }
  }

  call (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p) {
    _calls.add([a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p])

    if (_fakeFn) {
      return _fakeFn.call([a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p])
    }
  }
}