# RuleNumberSorting

This project implements a Ruby class `RuleNumber` with business logic such that a group of rule numbers can be sorted
according to the behavior specified in the RSpec spec `rule_parser_spec.rb`. The correctness of the code is
verified by the passing of all the RSpec examples.

The main idea of the implementation is to break down a rule number into segments of different types (e.g. integer,
roman numeral, text, etc) and let the sub-class implements its own comparison logic. The top-level `RuleNumber` class
needs to 1) decide what characters belong to the same segment and 2) coordinate the comparison of the corresponding
segments of the two rule numbers.