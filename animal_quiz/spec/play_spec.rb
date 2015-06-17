require_relative '../../animal_quiz/lib/play'
require_relative '../../animal_quiz/lib/console'
require_relative '../../animal_quiz/lib/animal'

describe Play do
  describe "#start_game" do

    let(:console) { Console.new }
    let(:rabbit) { Animal.new( console, "rabbit" ) }
    let(:dog) { Animal.new(console, 'dog') }

    let(:think_of_animal_message) { 'Think of an animal' }

    subject { described_class.new( console, rabbit ) }

    let(:yes_question) { Question.new('Is it small', rabbit, dog, console) }

    it 'should ask user to think of an animal' do
      allow(STDOUT).to receive(:puts).and_return(think_of_animal_message)
      expect(STDOUT).to receive(:puts).with(think_of_animal_message)
      subject.start_game
    end

    it 'calls #guess method on animal' do
      expect(rabbit).to receive(:guess)
      subject.start_game
    end

    context 'game subject is set to question' do
      it 'calls #guess method of question' do
        allow(rabbit).to receive(:guess).and_return(:yes_question)
        expect(yes_question).to receive(:guess)
        subject.start_game
      end
    end
  end
end