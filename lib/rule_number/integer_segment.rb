class RuleNumber
  class IntegerSegment < Segment
    # Override parent method to provide type specific comparison
    # @param other_segment [RuleNumber::IntegerSegment]
    # @return [Integer]
    def <=>(other_segment)
      super do
        int_value <=> other_segment.int_value
      end
    end

    # Return the integer equivalent of the segment value
    # @return [Integer]
    def int_value
      value.to_i
    end

    # @return [Symbol]
    def type
      :integer
    end
  end
end