require_relative 'spec_helper'

RSpec.describe ::RuleNumber do
  subject { RuleNumber.new(number).parse.segments.map(&:value) }

  describe 'parse' do
    context 'when number is a single digit' do
      let(:number) { '2' }

      it { is_expected.to eq ['2'] }
    end

    context 'when number is a decimal' do
      let(:number) { '6.1' }

      it { is_expected.to eq %w[6 . 1] }

      context 'when number are also parenthetical alphas' do
        let(:number) { '6.1(a)' }

        it { is_expected.to eq %w[6 . 1 ( a )] }
      end
    end

    context 'when it contains mixed integers and decimals' do
      let(:number) { '910A23' }

      it { is_expected.to eq ['910A23'] }
    end

    context 'when there are roman numerals' do
      let(:number) { '6(xix)' }

      it { is_expected.to eq %w[6 ( xix )] }
    end

    context 'when there are repeated characters' do
      let(:number) { '6.1(aa)' }

      it { is_expected.to eq %w[6 . 1 ( aa )] }
    end

    context 'when there is lots of text' do
      let(:number) { 'NFA Compliance Rule 2-41' }

      it { is_expected.to eq ['NFA', ' ', 'Compliance', ' ', 'Rule', ' ', '2', '-', '41'] }
    end

    context 'when there are commas' do
      let(:number) { 'One, Too' }

      it { is_expected.to eq ['One', ',', ' ', 'Too'] }
    end

    context 'when there are pound signs (#)' do
      let(:number) { 'NFA Compliance Rule #2' }

      it { is_expected.to eq ['NFA', ' ', 'Compliance', ' ', 'Rule', ' ', '#', '2'] }
    end

    context 'when there are extra spaces' do
      let(:number) { 'NFA Compliance  Rule 2-34' }

      it { is_expected.to eq ['NFA', ' ', 'Compliance', ' ', 'Rule', ' ', '2', '-', '34'] }
    end

    context 'when there are many dots' do
      let(:number) { '515.B.1' }

      it { is_expected.to eq %w[515 . B . 1] }
    end

    context 'when dots, parenthesis and roman numerals are all mixed' do
      let(:number) { '49.20(c)(1)(i)(A)' }

      it { is_expected.to eq %w[49 . 20 ( c ) ( 1 ) ( i ) ( A )] }
    end

    context 'when spaces, parens, numbers, text and romans are mixed' do
      let(:number) { '17 CFR 4.23(a)(12)' }

      it { is_expected.to eq ['17', ' ', 'CFR', ' ', '4', '.', '23', '(', 'a', ')', '(', '12', ')'] }
    end
  end
end
