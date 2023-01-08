class RuleNumber
  class OtherSegment < Segment
    # Override parent method to provide type specific comparison
    # @param other_segment [RuleNumber::OtherSegment]
    # @return [Integer]
    def <=>(other_segment)
      super do
        value <=> other_segment.value
      end
    end

    # @return [Symbol]
    def type
      :other
    end
  end
end