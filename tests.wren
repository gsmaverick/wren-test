import "src/reporters/console-reporter" for ConsoleReporter

// Tests for the tester.
var reporter = new ConsoleReporter

import "test/src/matchers/test-base" for TestBaseMatchers
import "test/src/matchers/test-fiber" for TestFiberMatchers
import "test/src/matchers/test-range" for TestRangeMatchers
import "test/src/matchers/test-stub" for TestStubMatchers
import "test/src/test-expectation" for TestExpectation
import "test/src/test-matchers" for TestMatchers
import "test/src/test-runnable" for TestRunnable
import "test/src/test-stub" for TestStub

var suites = [TestFiberMatchers, TestBaseMatchers, TestStubMatchers,
  TestExpectation, TestMatchers, TestRunnable, TestStub, TestRangeMatchers]

for (suite in suites) { suite.run(reporter) }

reporter.epilogue()