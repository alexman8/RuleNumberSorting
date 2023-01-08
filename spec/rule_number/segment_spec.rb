require_relative '../spec_helper'

RSpec.describe RuleNumber::Segment do
  describe '<=>' do
    let(:segment) { RuleNumber::Segment.build(value) }
    let(:other_segment) { RuleNumber::Segment.build(other_value) }

    context 'when both segments are text' do
      context 'when the texts are the same' do
        let(:value) { 'NFA' }
        let(:other_value) { 'NFA' }

        it 'should return 0' do
          expect(segment <=> other_segment).to eq 0
        end
      end

      context 'when the first text is less than the second lexicographically' do
        let(:value) { 'Compliance' }
        let(:other_value) { 'Interpretive' }

        it 'should return -1' do
          expect(segment <=> other_segment).to eq -1
        end
      end
    end

    context 'when both segments are integer' do
      context 'when the integers are the same' do
        let(:value) { '910' }
        let(:other_value) { '910' }

        it 'should return 0' do
          expect(segment <=> other_segment).to eq 0
        end
      end

      context 'when the first integer is greater than the second' do
        let(:value) { '910' }
        let(:other_value) { '909' }

        it 'should return 1' do
          expect(segment <=> other_segment).to eq 1
        end
      end
    end

    context 'when both segments are repeated characters' do
      context 'when two segments are the same' do
        let(:value) { 'ccc' }
        let(:other_value) { 'ccc' }

        it 'should return 0' do
          expect(segment <=> other_segment).to eq 0
        end
      end

      context 'when the two segments are of the same length with different characters' do
        let(:value) { 'aa' }
        let(:other_value) { 'bb' }

        it 'should return -1' do
          expect(segment <=> other_segment).to eq -1
        end
      end

      context 'when the two segments are different in length with the same character' do
        let(:value) { 'dd' }
        let(:other_value) { 'd' }

        it 'should return 1' do
          expect(segment <=> other_segment).to eq 1
        end
      end
    end

    context 'when both segments are roman numerals' do
      context 'when the roman numerals are the same' do
        let(:value) { 'xii' }
        let(:other_value) { 'xii' }

        it 'should return 0' do
          expect(segment <=> other_segment).to eq 0
        end
      end

      context 'when the first roman numeral is smaller than the second' do
        let(:value) { 'cm' }
        let(:other_value) { 'm' }

        it 'should return -1' do
          expect(segment <=> other_segment).to eq -1
        end
      end
    end

    context 'when the two segments are of different type' do
      context 'when the first segment is less than the second lexicographically' do
        let(:value) { '6C' }
        let(:other_value) { '910' }

        it 'should return -1' do
          expect(segment <=> other_segment).to eq -1
        end
      end
    end
  end

  describe 'segment_class' do
    let(:segment_class) { RuleNumber::Segment.segment_class(value) }

    context 'when the value is a single space' do
      let(:value) { ' ' }

      it 'should return :other' do
        expect(segment_class).to eq RuleNumber::OtherSegment
      end
    end

    context 'when the value is a series of digits' do
      let(:value) { '12345' }

      it 'should return :integer' do
        expect(segment_class).to eq RuleNumber::IntegerSegment
      end
    end

    context 'when the value is a single character' do
      let(:value) { 'd' }

      it 'should return :repeated_char' do
        expect(segment_class).to eq RuleNumber::RepeatedCharSegment
      end
    end

    context 'when the value is a series of repeated characters' do
      let(:value) { 'bbb' }

      it 'should return :repeated_char' do
        expect(segment_class).to eq RuleNumber::RepeatedCharSegment
      end
    end

    context 'when the value is a roman numeral (dccxlix)' do
      let(:value) { 'dccxlix' }

      it 'should return :roman' do
        expect(segment_class).to eq RuleNumber::RomanSegment
      end
    end

    context 'when the value is a capital roman numeral (CMXLII)' do
      let(:value) { 'CMXLII' }

      it 'should return :roman' do
        expect(segment_class).to eq RuleNumber::RomanSegment
      end
    end

    context 'when the value is an invalid roman numeral (dccmmmxlviii)' do
      let(:value) { 'dccmmmxlviii' }

      it 'should return :roman' do
        expect(segment_class).to eq RuleNumber::TextSegment
      end
    end

    context 'when the value is a series of alphanumeric characters' do
      let(:value) { 'NFA23' }

      it 'should return :text' do
        expect(segment_class).to eq RuleNumber::TextSegment
      end
    end
  end
end
