class RuleNumber
  class RepeatedCharSegment < Segment
    # Override parent method to provide type specific comparison
    # If the size are different, the shorter goes before the longer one, e.g. 'bb' before 'aaa'
    # If the size are the same, the lexicographically smaller segment goes before, e.g. 'ccc' before 'ddd'
    # @param other_segment [RuleNumber::RepeatedCharSegment]
    # @return [Integer]
    def <=>(other_segment)
      super do
        if value.size != other_segment.value.size
          value.size <=> other_segment.value.size
        else
          value <=> other_segment.value
        end
      end
    end

    # @return [Symbol]
    def type
      :repeated_char
    end
  end
end