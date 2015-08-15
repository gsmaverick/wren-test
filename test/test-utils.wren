/**
 * Utility function for easily testing matchers inside a Fiber and returning the
 * yielded result.
 *
 * @param {Function} block Function block containing the matcher that is being
 *                         tested.
 * @return {*} Value returned by the block provided to the harness.
 */
var MatcherTestHarness = Fn.new { |block|
    var fiber = Fiber.new(block)

    return fiber.try()
}
