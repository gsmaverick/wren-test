import "src/matchers" for Expect
import "src/suite" for Suite

import "src/stub" for Stub

var TestStub = new Suite("Stub") {{
  "#andCallFake should return an instance of Stub": new Fn {
    var called = false

    var stub = Stub.andCallFake("Fake Stub") {
      called = true
    }
    stub.call

    Expect.call(called).toBeTruthy
  },

  "#andReturnValue should return an instance of Stub": new Fn {
    var stub = Stub.andReturnValue("Fake Stub", 1)

    Expect.call(stub.call).toEqual(1)
  },

  "#called should return the correct value": new Fn {
    var stub = new Stub("Fake Stub")

    Expect.call(stub.called).toBeFalsy

    stub.call

    Expect.call(stub.called).toBeTruthy
  },

  "#calls should return list of arguments used when stub was called": new Fn {
    var stub = new Stub("Fake Stub")
    stub.call
    stub.call(null)
    stub.call(1, 2)

    Expect.call(stub.calls).toEqual([], [null], [1, 2])
  },

  "#firstCall should return null when no calls have been made": new Fn {
    var stub = new Stub("Fake Stub")

    Expect.call(stub.firstCall).toEqual(null)
  },

  "#firstCall should return the arguments for the first call": new Fn {
    var stub = new Stub("Fake Stub")
    stub.call(1, 2)

    Expect.call(stub.firstCall).toEqual([1, 2])
  },

  "#mostRecentCall should return null if no calls have been made": new Fn {
    var stub = new Stub("Fake Stub")

    Expect.call(stub.mostRecentCall).toEqual(null)
  },

  "#mostRecentCall should return the most recent call's arguments": new Fn {
    var stub = new Stub("Fake Stub")
    stub.call(1, 2)
    stub.call("test")

    Expect.call(stub.mostRecentCall).toEqual(["test"])
  },

  "#reset should work correctly": new Fn {
    var stub = new Stub("Fake Stub")
    stub.call(1, 2)

    // TODO: Use a deep-equals matcher here.
    Expect.call(stub.calls.count).toEqual(1)

    stub.reset

    Expect.call(stub.calls.count).toEqual(0)
  }
}}