/**
 * Defines the full interface for a test reporter.
 */
class Reporter {
  /**
   * Called when a test run is entirely finished and can be used to print a test
   * summary for instance.
   */
  epilogue () {}

  /**
   * Called when a suite run is started.
   *
   * @param {String} title Name of the suite that has been started.
   */
  suiteStart (title) {}

  /**
   * Called when a suite run is finished.
   *
   * @param {String} title Name of the suite that has been finished.
   */
  suiteEnd (title) {}

  /**
   * Called when a test is started.
   *
   * @param {Runnable} runnable Runnable object that is about to be run.
   */
  testStart (runnable) {}

  /**
   * Called when a test passed.
   *
   * @param {Runnable} runnable Runnable object that was successful.
   */
  testPassed (runnable) {}

  /**
   * Called when a test failed.
   *
   * @param {Runnable} runnable Runnable object that failed.
   */
  testFailed (runnable) {}

  /**
   * Called when a test encounters an error.
   *
   * @param {Runnable} runnable Runnable object that encountered an error.
   */
  testError (runnable) {}

  /**
   * Called when a test is finished.
   *
   * @param {Runnable} runnable Runnable object that just finished.
   */
  testEnd (runnable) {}
}