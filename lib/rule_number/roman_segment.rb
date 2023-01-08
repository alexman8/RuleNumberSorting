require_relative 'roman_numerable'

class RuleNumber
  class RomanSegment < Segment
    include RomanNumerable

    # Override parent method to provide type specific comparison
    # @param other_segment [RuleNumber::RomanSegment]
    # @return [Integer]
    def <=>(other_segment)
      super do
        int_value <=> other_segment.int_value
      end
    end

    # Return the integer equivalent of the segment value
    # @return [Integer]
    def int_value
      roman_numeral_to_i(value)
    end

    # @return [Symbol]
    def type
      :roman
    end
  end
end