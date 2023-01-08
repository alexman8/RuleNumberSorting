class RuleNumber
  class TextSegment < Segment
    # Override parent method to provide type specific comparison
    # @param other_segment [RuleNumber::TextSegment]
    # @return [Integer]
    def <=>(other_segment)
      super do
        value <=> other_segment.value
      end
    end

    # @return [Symbol]
    def type
      :text
    end
  end
end