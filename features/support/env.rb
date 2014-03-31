# Since simplecov need to run in the same process as the code being annalized,
# we run initialize simplecov at the very beginning of our plugin. To only do
# so during tests, we wrap it in a check for an environment variable.
ENV['COVERAGE'] = 'true'
require 'coveralls'
# Since simplecov is running under a separate process, we need to retrieve the
# results afterwards.
Coveralls.wear_merged!
require 'aruba/cucumber'
