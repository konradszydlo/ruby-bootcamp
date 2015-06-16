require_relative '../../animal_quiz/lib/play'
require_relative '../../animal_quiz/lib/console'
require_relative '../../animal_quiz/lib/animal'

describe Play do
  describe "#start_game" do

    let(:console) { Console.new }
    let(:rabbit) { Animal.new( console, "rabbit" ) }

    let(:think_of_animal_message) { 'Think of an animal' }

    subject { described_class.new( console, rabbit ) }

    it 'should ask user to think of an animal' do
      allow(STDOUT).to receive(:puts).and_return(think_of_animal_message)
      # # allow(subject).to receive(:continue_game).and_return(false)
      #
      expect(STDOUT).to receive(:puts).with(think_of_animal_message)
      subject.start_game
    end

    it 'calls #guess method on animal' do
      expect(rabbit).to receive(:guess)
      subject.start_game
    end

    # context 'animal.guess returns current animal' do
    #   it 'animal returned is current animal' do
    #     expect(rabbit).to receive(:guess).and_return(subject)
    #     expect(subject).to eq()
    #   end
    # end
  end
end
#