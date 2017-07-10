# frozen_string_literal: true

require 'bowling_score'

describe BowlingScore do
  describe '#initialize' do
    it 'takes a string as input and saves the value into the all_throws array' do
      expect(BowlingScore.new('X98/-').all_throws).to eq(['X', '9', '8', '/', '-'])
    end
  end

  describe '#total_score' do
    context 'when just one throw is provided' do
      context 'one strike' do
        subject { BowlingScore.new('X').total_score }
        it { is_expected.to eq(10) }
      end

      context 'one 9' do
        subject { BowlingScore.new('9').total_score }
        it { is_expected.to eq(9) }
      end

      context 'one - (a miss)' do
        subject { BowlingScore.new('-').total_score }
        it { is_expected.to eq(0) }
      end
    end

    context 'when two throws are provided' do
      context 'two strikes' do
        subject { BowlingScore.new('XX').total_score }
        it { is_expected.to eq(30) }
      end

      context 'one strike and one 5' do
        subject { BowlingScore.new('X5').total_score }
        it { is_expected.to eq(20) }
      end

      context '6 and spare' do
        subject { BowlingScore.new('6/').total_score }
        it { is_expected.to eq(10) }
      end

      context '6 and 3' do
        subject { BowlingScore.new('63').total_score }
        it { is_expected.to eq(9) }
      end
    end

    context 'when three throws are provided' do
      context 'three strikes' do
        subject { BowlingScore.new('XXX').total_score }
        it { is_expected.to eq(60) }
      end

      context 'one strike, 5 and a spare' do
        subject { BowlingScore.new('X5/').total_score }
        it { is_expected.to eq(30) }
      end

      context 'spare then 9' do
        subject { BowlingScore.new('6/9').total_score }
        it { is_expected.to eq(28) }
      end

      context '5, 4, 3' do
        subject { BowlingScore.new('543').total_score }
        it { is_expected.to eq(5 + 4 + 3) }
      end
    end
    context 'when provided with a full game' do
      context 'when only strikes' do
        subject { BowlingScore.new('XXXXXXXXXXXX', true).total_score }
        it { is_expected.to eq(300) }
      end
      context 'when each turn is a 9 and a miss' do
        subject { BowlingScore.new('9-9-9-9-9-9-9-9-9-9-', true).total_score }
        it { is_expected.to eq(90) }
      end
      context 'when each turn is a spare' do
        subject { BowlingScore.new('5/5/5/5/5/5/5/5/5/5/5', true).total_score }
        it { is_expected.to eq(150) }
      end
      context 'when each turn alternates between spare and strike' do
        subject { BowlingScore.new('5/X5/X5/X5/X5/X5/', true).total_score }
        it { is_expected.to eq(200) }
      end
      context 'when each turn alternates between strike and spare' do
        subject { BowlingScore.new('X5/X5/X5/X5/X5/X', true).total_score }
        it { is_expected.to eq(200) }
      end
    end
  end
end
