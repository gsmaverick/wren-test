/**
 * Represents a skipped test or suite and implements the same basic interface as
 * `Runnable`.
 */
class Skippable {
  /**
   * Create a new skipped test or suite.
   *
   * @param {String} title Name of the skipped test or suite.
   */
  construct new (title) {
    _title = title
  }

  run { /* Do nothing. */ }

  /**
   * @return {String} Title string of this Skippable.
   */
  title { _title }
}
