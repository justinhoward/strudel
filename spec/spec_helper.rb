require 'simplecov'
require 'codeclimate-test-reporter'
SimpleCov.start if ENV['COVERAGE']
CodeClimate::TestReporter.start

require 'strudel'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!

  config.warnings = true
end
