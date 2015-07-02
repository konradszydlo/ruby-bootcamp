require_relative '../lib/game'

describe Game do

  # let(:game) { described_class.new }
  #
  # subject { game }

  describe '#score' do
    it 'empty dice returns 0' do
      expect(subject.score([])).to eq(0)
    end
    it 'single roll of 5 returns 50' do
      expect(subject.score([5])).to eq(50)
    end
    it 'single roll of 1 is 100' do
      expect(subject.score([1])).to eq(100)
    end
    it 'singles of 2, 3, 4 and 6 return 0' do
      expect(subject.score([2, 3, 4, 6])).to eq(0)
    end
    it 'two 1 are sum of single 1s' do
      expect(subject.score([1, 1])).to eq(200)
    end
    it 'two 5 are sum of single 5s' do
      expect(subject.score([5, 5])).to eq(100)
    end
    it 'multiples of 1 and 5 are sum of singles' do
      expect(subject.score([1, 5, 5, 1])).to eq(300)
    end
    context 'tripple scores' do
      it 'tripple 1 is 1000' do
        expect(subject.score([1, 1, 1])).to eq(1000)
      end
      context 'tripples of 2, 3, 4, 5 and 6 are multuplication of 100' do
        it 'tripple of 2 is 200' do
          expect(subject.score([2, 2, 2])).to eq(200)
        end
        it 'tripple of 3 is 300' do
          expect(subject.score([3, 3, 3])).to eq(300)
        end
      end
      context 'tripples with more scores' do
        it 'scores after tripples are counted as singles' do
          expect(subject.score([2,5,2,2,3])).to eq(250)
        end
        it 'quadruple 5 is tripple 5 plus single' do
          expect(subject.score([5, 5, 5, 5])).to eq(550)
        end
        it 'quintuple of 1 is tripple plus two singles' do
          expect(subject.score([1, 1, 1, 1, 1])).to eq(1200)
        end
      end
    end
    context 'mixed scored' do

    end

  end
end