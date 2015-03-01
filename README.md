wren-test is an elegant testing framework for the [Wren programming language](http://munificent.github.io/wren/) that comes with everything you need to quickly get started writing tests out of the box. It provides a familiar API for defining test suites inspired by [mocha](http://mochajs.org/) and [Jasmine](http://jasmine.github.io/).


**Note:** wren-test is still under heavy development although the API should not undergo much more churn moving forward.

<h2 id="table-of-contents">Table of contents</h2>

  - [Installation](#installation)
  - [Getting Started](#getting-started)
  - [Matchers](#matchers)

<h2 id="installation">Installation</h2>

  TODO

<h2 id="getting-started">Getting Started</h2>

    import "src/matchers" for Expect
    import "src/suite" for Suite

    var TestString = new Suite("String") { |it|
      it.suite("indexOf") { |it|
        it.should("return -1 when the value is not found") {
          Expect.call("foo".indexOf("bar")).toEqual(-1)
        }
      }
    }

<h2 id="matchers">Matchers</h2>

   wren-test provides a variety of built-in assertion helpers were are called Matchers.