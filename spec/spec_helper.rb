require_relative '../lib/rule_number'
require_relative '../lib/rule_number/segment'
require_relative '../lib/rule_number/integer_segment'
require_relative '../lib/rule_number/other_segment'
require_relative '../lib/rule_number/repeated_char_segment'
require_relative '../lib/rule_number/roman_segment'
require_relative '../lib/rule_number/text_segment'
require_relative '../lib/rule_number/roman_numerable'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
end
