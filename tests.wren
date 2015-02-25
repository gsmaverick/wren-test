// Tests for the tester.

import "test/src/matchers/test-base" for TestBaseMatchers
TestBaseMatchers.run

import "test/src/matchers/test-fiber" for TestFiberMatchers
TestFiberMatchers.run

import "test/src/test-expectation" for TestExpectation
TestExpectation.run

import "test/src/test-matchers" for TestMatchers
TestMatchers.run

import "test/src/test-runnable" for TestRunnable
TestRunnable.run

import "test/src/test-stub" for TestStub
TestStub.run