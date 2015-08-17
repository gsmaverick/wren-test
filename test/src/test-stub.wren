import "src/matchers" for Expect
import "src/suite" for Suite

import "src/stub" for Stub

var TestStub = Suite.new("Stub") { |it|
  it.suite("#andCallFake") { |it|
    it.should("return an instance of Stub") {
      var called = false

      var stub = Stub.andCallFake("Fake Stub") {
        called = true
      }
      stub.call

      Expect.call(called).toBeTrue
    }
  }

  it.suite("#andReturnValue") { |it|
    it.should("return an instance of Stub") {
      var stub = Stub.andReturnValue("Fake Stub", 1)

      Expect.call(stub.call).toEqual(1)
    }
  }

  it.suite("#called") { |it|
    it.should("return the correct value") {
      var stub = Stub.new("Fake Stub")

      Expect.call(stub.called).toBeFalse

      stub.call

      Expect.call(stub.called).toBeTrue
    }
  }

  it.suite("#calls") { |it|
    // TODO: Enable after supporting better equals for complex objects.
    it.should("return list of arguments used when stub was called").skip {
      var stub = Stub.new("Fake Stub")
      stub.call
      stub.call(null)
      stub.call(1, 2)

      Expect.call(stub.calls).toEqual([[], [null], [1, 2]])
    }
  }

  it.suite("#firstCall") { |it|
    it.should("return null when no calls have been made") {
      var stub = Stub.new("Fake Stub")

      Expect.call(stub.firstCall).toEqual(null)
    }

    // TODO: Enable after supporting better equals for complex objects.
    it.should("return the arguments for the first call").skip {
      var stub = Stub.new("Fake Stub")
      stub.call(1, 2)

      Expect.call(stub.firstCall).toEqual([1, 2])
    }
  }

  it.suite("#mostRecentCall") { |it|
    it.should("return null if no calls have been made") {
      var stub = Stub.new("Fake Stub")

      Expect.call(stub.mostRecentCall).toEqual(null)
    }

    // TODO: Enable after supporting better equals for complex objects.
    it.should("return the most recent call's arguments").skip {
      var stub = Stub.new("Fake Stub")
      stub.call(1, 2)
      stub.call("test")

      Expect.call(stub.mostRecentCall).toEqual(["test"])
    }
  }

  it.suite("#name") { |it|
    it.should("return the name of the stub") {
      var stub = Stub.new("Fake Stub")

      Expect.call(stub.name).toEqual("Fake Stub")
    }
  }

  it.suite("#reset") { |it|
    it.should("reset the stub's state") {
      var stub = Stub.new("Fake Stub")
      stub.call(1, 2)

      // TODO: Use a deep-equals matcher here.
      Expect.call(stub.calls.count).toEqual(1)

      stub.reset

      Expect.call(stub.calls.count).toEqual(0)
    }
  }
}
