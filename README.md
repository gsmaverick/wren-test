wren-test is an elegant testing framework for the [Wren programming language](http://munificent.github.io/wren/) that comes with everything you need to get started writing tests right out of the box. It provides a familiar API for defining test suites inspired by [mocha](http://mochajs.org/) and [Jasmine](http://jasmine.github.io/) among others.

**Note:** wren-test is still under heavy development although the API should not undergo much more churn moving forward.

<h2 id="table-of-contents">Table of contents</h2>

  - [Installation](#installation)
  - [Getting started](#getting-started)
  - [Hooks](#hooks)
  - [Matchers](#matchers)
  - [Skipping tests](#skipping-tests)

<h2 id="installation">Installation</h2>

  The easiest way to use wren-test in your project is by running [./scripts/bundle.py](scripts/bundle.py) and importing the resulting `module.wren` file that is generated.

  This bundle file includes the entire framework (including all the matchers and reporters). Currently this is the best way to use wren-test as Wren's module system is still a bit immature.

  All the examples in the README assume you have followed these steps and are importing via the bundled `module.wren` file.

<h2 id="getting-started">Getting started</h2>

Here's a quick test suite to get you familiar with writing tests with wren-test.

```scala
import "wren-test" for Expect, Suite

var TestString = new Suite("String") { |it|
  it.suite("indexOf") { |it|
    it.should("return -1 when the value is not found") {
      Expect.call("foo".indexOf("bar")).toEqual(-1)
    }
  }
}
```

<h2 id="hooks">Hooks</h2>

wren-test provides the hooks `beforeEach` and `afterEach` that can be used to setup the preconditions and clean up after your tests.

```scala
new Suite("String") { |it|
  it.beforeEach {
    // runs before every test in this block
  }

  it.afterEach {
    // runs after every test in this block
  }
}
```

<h2 id="matchers">Matchers</h2>

wren-test provides a variety of built-in assertion helpers were are called Matchers.

<h3>Base Matchers</h3>

A collection of general purpose matchers.

**toBe (klass):** asserts that the value is of a given class

```scala
Expect.call(1).toBe(Num)
Expect.call(1).not.toBe(String)
```

**toBeFalse:** asserts that the value is boolean `false`

```scala
Expect.call(false).toBeFalse
Expect.call(true).not.toBeFalse
```

**toBeTrue:** asserts that the value is boolean `true`

```scala
Expect.call(true).toBeTrue
Expect.call(false).not.toBeTrue
```

**toBeNull:** asserts that the value is `null`

```scala
Expect.call(null).toBeNull
Expect.call(1).not.toBeNull
```

**toEqual (other):** asserts that the value is equal to `other` using the builtin `==` operator

```scala
Expect.call(1).toEqual(1)
Expect.call(1).not.toEqual(2)
Expect.call([]).not.toEqual([])
```

<h3>Fiber Matchers</h3>

A collection of matchers that can be invoked on instances of `Fiber`.

**toBeARuntimeError:** asserts that invoking the fiber results in a runtime error with any error message

```scala
var fiberWithError = new Fiber { 1.ceil(1) }
Expect.call(fiberWithError).toBeARuntimeError
Expect.call(new Fiber {}).not.toBeARuntimeError
```

**toBeARuntimeError (errorMessage):** asserts that invoking the fiber results  in a runtime error witn an error message equal to `errorMessage`

```scala
var fiberWithError = new Fiber { Fiber.abort("Error message!") }
Expect.call(fiberWithError).toBeARuntimeError("Error message!")
Expect.call(fiberWithError).not.toBeARuntimeError("Different error message!")
```

**toBeDone:** asserts that the fiber is done

```scala
var fiber = new Fiber {}
Expect.call(fiber).not.toBeDone
fiber.call
Expect.call(fiber).toBeDone
```

**toYield (shouldYield):** asserts that the fiber yielded the same values as `shouldYield`

```scala
var fiber = new Fiber {
  Fiber.yield(1)
  Fiber.yield(2)
}
Expect.call(fiber).toYield([1, 2])
Expect.call(new Fiber {}).not.toYield([1, 2, 3])
```

<h3>Range Matchers</h3>

A collection of matchers that can be invoked on instances of `Range`.

**toContain (other):** asserts that the value contains the given range

```scala
Expect.call(1...3).toContain(1..2)
Expect.call(1...3).not.toContain(1...4)
```

**toBeContainedBy (other):** asserts the given range contains the value

```scala
Expect.call(1..2).toBeContainedBy(1...3)
Expect.call(1...4).not.toBeContainedBy(1...3)
```

<h3>Stub Matchers</h3>

A collection of matchers that can be invoked on instances of `Stub`.

**toHaveBeenCalled:** asserts that the stub was called

```scala
var stub = new Stub("Test stub")
Expect.call(stub).not.toHaveBeenCalled
stub.call(1)
Expect.call(stub).toHaveBeenCalled
```

**toHaveBeenCalled (times):** asserts that the stub was called a certain number of times

```scala
var stub = new Stub("Test stub")
stub.call
stub.call
Expect.call(stub).toHaveBeenCalled(2)
Expect.call(stub).not.toHaveBeenCalled(3)
```

**toHaveBeenCalledWith (args):** asserts that the stub was called at least once with the given list of arguments

```scala
var stub = new Stub("Test stub")
stub.call(1, 2, 3)
Expect.call(stub).toHaveBeenCalledWith([1, 2, 3])
Expect.call(stub).not.toHaveBeenCalledWith([1, 2, 3, 4])
```

<h3>Num Matchers</h3>

A collection of matchers that can be invoked on `Num`s and user-defined classes that implement the `>` and `<` operators.

**toBeGreaterThan (other):** asserts that value is greater than the given value

```scala
Expect.call(2).toBeGreaterThan(1)
Expect.call(1).not.toBeGreaterThan(2)
```

**toBeLessThan (other):** asserts that value is less than the given value

```scala
Expect.call(1).toBeLessThan(1)
Expect.call(2).not.toBeLessThan(1)
```

**toBeBetween (min, max):** asserts that the value is between the min and max values

```scala
Expect.call(2).toBeBetween(1, 3)
Expect.call(2).not.toBeBetween(3, 5)
```

<h2 id="skipping-tests">Skipping tests</h2>

In order to skip a test or suite simply append `.skip` after the initial argument list and that test or suite will not be run. This is preferred to commenting out tests because it will still show up in the reported output whereas commented out tests will not be reported.

```scala
it.suite("String") { |it|
  it.suite("indexOf").skip { |it|
    ...
  }
}
```

Or for a specific test-case:

```scala
it.suite("String") { |it|
  it.suite("indexOf") { |it|
    it.should("return -1 when the value is not found").skip {
      Expect.call("foo".indexOf("bar")).toEqual(-1)
    }

    it.should("return the index when value is found") {
      Expect.call("foo".indexOf("foo")).toEqual(0)
    }
  }
}
```

*Note:* The `skip` method can also be called on `beforeEach` and `afterEach` to prevent wren-test from running those blocks.