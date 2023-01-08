class RuleNumber
  attr_reader :number, :segments

  # Initialize the rule number
  # @param number [String]
  def initialize(number)
    @number   = number
    @segments = []
  end

  # Compare self with another rule number
  # -1 means self < other
  # 1 means self > other
  # 0 means identical
  # @param other [RuleNumber] the other rule number
  # @return [Integer]
  def <=>(other)
    self.parse
    other.parse

    each_index(other) do |index|
      segment       = segments[index]
      other_segment = other.segments[index]
      comp_result   = segment <=> other_segment
      return comp_result unless comp_result == 0 # Can return as soon as any pair of segments differ
    end

    # If everything is equal up to the shorter of the two rule numbers, the one that is shorter will be
    # before the other, hence comparing their size as follows. E.g. 6.1(a) is before 6.1(a)(i)
    segments.size <=> other.segments.size
  end

  # Parse the rule number into array of segments
  def parse
    return if parsed?

    number.squish!
    segment_value = ''
    number.each_char do |char|
      if look_ahead?(char)
        segment_value << char
      else
        append_to_segments(segment_value, char)
        segment_value = ''
      end
    end
    append_to_segments(segment_value) # For the last segment

    self
  end

  # To string
  # @return [String]
  def to_s
    number.to_s
  end

  private

  # Only need to compare up to the the shorter of the two rule numbers
  # @param other [RuleNumber] the other rule number
  def each_index(other)
    minimum_segment_size = [segments.size, other.segments.size].min
    0.upto(minimum_segment_size - 1) do |index|
      yield(index)
    end
  end

  # Tell if the rule number is already parsed
  # @return [Boolean]
  def parsed?
    !segments.empty?
  end

  # Tell if this character is one that we should look ahead to the next one to group them into a segment
  # @param char [String] a single character string
  # @return [Boolean]
  def look_ahead?(char)
    char =~ /[[:alpha:]]|[[:digit:]]/
  end

  # Append segment values to the segments array
  def append_to_segments(*segment_values)
    segment_values.each do |segment_value|
      next if segment_value.empty?
      segments << Segment.build(segment_value)
    end
  end
end

class String
  # From Rails' ActiveSupport: condense consecutive whitespace groups into a single space each and then
  # remove all whitespace characters from both ends
  # @return [String]
  def squish!
    gsub!(/[[:space:]]+/, " ")
    strip!
    self
  end
end
