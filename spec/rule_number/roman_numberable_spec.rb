require_relative '../spec_helper'

class RomanDummy
  include RuleNumber::RomanNumerable
end

RSpec.describe RuleNumber::RomanNumerable do
  describe 'roman_numeral_to_i' do
    let(:converted_int) { RomanDummy.new.roman_numeral_to_i(roman_num_str) }

    context "when the roman numeral string is 'i'" do
      let(:roman_num_str) { 'i' }
      it { expect(converted_int).to eq 1 }
    end

    context "when the roman numeral string is 'iii'" do
      let(:roman_num_str) { 'iii' }
      it { expect(converted_int).to eq 3 }
    end

    context "when the roman numeral string is 'iv'" do
      let(:roman_num_str) { 'iv' }
      it { expect(converted_int).to eq 4 }
    end

    context "when the roman numeral string is 'v'" do
      let(:roman_num_str) { 'v' }
      it { expect(converted_int).to eq 5 }
    end

    context "when the roman numeral string is capital 'VII'" do
      let(:roman_num_str) { 'VII' }
      it { expect(converted_int).to eq 7 }
    end

    context "when the roman numeral string is 'ix'" do
      let(:roman_num_str) { 'ix' }
      it { expect(converted_int).to eq 9 }
    end

    context "when the roman numeral string is 'mmmdccxlviii'" do
      let(:roman_num_str) { 'mmmdccxlviii' }
      it { expect(converted_int).to eq 3748 }
    end
  end
end
