require 'animal'

describe Animal do

  subject(:subject) { described_class.new }
  let(:win_message) { 'You win' }

  describe '#guess' do
    context 'human guesses animal correctly' do
      it 'guessing correct animal displays shows win message' do
        expect(STDOUT).to receive(:puts).with(win_message)
        # expect(subject.guess).to
        subject.guess
      end
    end
  end
end