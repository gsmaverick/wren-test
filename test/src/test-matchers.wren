import "src/matchers" for Expect
import "src/suite" for Suite

import "src/matchers/base" for BaseMatchers
import "src/matchers/fiber" for FiberMatchers
import "src/matchers/num" for NumMatchers
import "src/matchers/range" for RangeMatchers
import "src/matchers/stub" for StubMatchers

var TestMatchers = new Suite("Matchers") { |it|
  it.should("return an instance that is a subclass of all matcher classes") {
    var matcher = Expect.call(true)

    Expect.call(matcher).toBe(BaseMatchers)
    Expect.call(matcher).toBe(FiberMatchers)
    Expect.call(matcher).toBe(NumMatchers)
    Expect.call(matcher).toBe(RangeMatchers)
    Expect.call(matcher).toBe(StubMatchers)
  }
}