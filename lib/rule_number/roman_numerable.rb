class RuleNumber
  module RomanNumerable
    ROMAN_INT_H = { 'i'  => 1, 'v' => 5, 'x' => 10, 'l' => 50, 'c' => 100, 'd' => 500, 'm' => 1000,
                    'iv' => 4, 'ix' => 9, 'xl' => 40, 'xc' => 90, 'cd' => 400, 'cm' => 900 }

    # Convert a string containing a valid roman numeral to an integer
    # @param roman_num_str [String] the string with the roman numeral
    # @return [Integer]
    def roman_numeral_to_i(roman_num_str)
      roman_num_str.downcase!
      idx  = 0
      num  = 0
      size = roman_num_str.size

      loop do
        break if idx >= size
        next_idx        = idx + 1
        two_char_substr = next_idx < size ? roman_num_str[idx..next_idx] : nil
        if ROMAN_INT_H.has_key?(two_char_substr)
          num += ROMAN_INT_H[two_char_substr]
          idx += 2
        else
          num += ROMAN_INT_H[roman_num_str[idx]]
          idx += 1
        end
      end

      num
    end
  end
end