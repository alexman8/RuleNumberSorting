class RuleNumber
  class Segment
    OTHER_REGEXP         = /\A[^[[:alpha:]]^[[:digit:]]]{1}\z/
    INTEGER_REGEXP       = /\A[[:digit:]]+\z/
    # Exclude the character 'i', 'v', 'x' since they're probably the roman numerals that are most
    # used in rule numbers. The downside is that this can't handle repeated characters like 'ii',
    # 'vvv', etc
    REPEATED_CHAR_REGEXP = /\A([a-zA-Z&&[^ivxIVX]])\1*\z/
    ROMAN_NUMERAL_REGEXP = /\AM*(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})\z/i

    attr_reader :value

    # Factory for building a segment
    # @return [RuleNumber::OtherSegment]
    # @return [RuleNumber::IntegerSegment]
    # @return [RuleNumber::RepeatedCharSegment]
    # @return [RuleNumber::RomanSegment]
    # @return [RuleNumber::TextSegment]
    def self.build(value)
      segment_class(value).new(value)
    end

    # To determine the segment class based on the value
    # @return [Class]
    def self.segment_class(value)
      case
        when value =~ OTHER_REGEXP
          RuleNumber::OtherSegment
        when value =~ INTEGER_REGEXP
          RuleNumber::IntegerSegment
        when value =~ REPEATED_CHAR_REGEXP
          RuleNumber::RepeatedCharSegment
        when value =~ ROMAN_NUMERAL_REGEXP
          RuleNumber::RomanSegment
        else
          RuleNumber::TextSegment
      end
    end

    # Initialize the segment
    # @param value [String]
    def initialize(value)
      @value = value
    end

    # Compare with another segment
    # -1 means self < other segment
    # 1 means self > other segment
    # 0 means identical
    # @param other_segment [RuleNumber::Segment]
    # @return [Integer]
    def <=>(other_segment)
      # use the lexicographical string comparison when the types differ
      unless same_type?(other_segment)
        return value <=> other_segment.value
      end
      yield
    end

    private

    # Tell if the two segments are of the same type
    # @return [Boolean]
    def same_type?(segment)
      type == segment.type
    end
  end
end