require_relative '../lib/animal'
require_relative '../lib/console'
require_relative '../lib/question'

require_relative 'support/question_shared_examples'

describe Question do

  let(:console) { Console.new }

  let(:rabbit) { Animal.new console, 'rabbit'}
  let(:elephant) { Animal.new console, 'elephant' }
  let(:shih_tzu) { Animal.new console, 'Shih-Tzu' }
  let(:whale) { Animal.new console, 'whale' }

  let(:does_it_swim_question) { Question.new 'Does it swim', whale, elephant, console }
  let(:is_it_small_question) { 'Is it small (y or n) ?' }

  let(:yes_question) { described_class.new is_it_small_question, rabbit, elephant, console }
  let(:is_it_kind_a_dog_question) { Question.new 'Is it kind a dog', shih_tzu, rabbit, console }

  subject {  described_class.new is_it_small_question, rabbit, elephant, console }

  describe '#guess' do

    context 'user answered yes to question' do
      it 'calls guess on yes_answer variable' do
        allow(console).to receive(:y_n_question).and_return(true)
        expect(rabbit).to receive(:guess)
        yes_question.guess
      end

      context 'user guessed animal correctly' do
        it 'calling guess on yes_answer variable returns animal' do
          expect(yes_question.yes_answer).to be == rabbit
        end
      end

      context 'user guessed animal incorrectly' do
        it 'yes_answer variable is populated with question returned ' do
          allow(console).to receive(:y_n_question).and_return(true)
          allow(rabbit).to receive(:guess).and_return(is_it_kind_a_dog_question)
          yes_question.guess
          expect(yes_question.yes_answer).to be == is_it_kind_a_dog_question
        end
      end
    end

    context 'user answered no to question' do
      it 'calls guess on no_answer variable' do
        allow(console).to receive(:y_n_question).and_return(false)
        expect(elephant).to receive(:guess)
        yes_question.guess
      end

      context 'user guessed animal correctly' do
        it 'calling guess on no_answer returns other animal' do
          allow(console).to receive(:y_n_question).and_return(false, true)
          yes_question.guess
          expect(yes_question.no_answer).to be == elephant
        end
      end

      context "user didn't guess animal correctly" do
        it 'calling guess on no_answer returns a new question' do
          allow(console).to receive(:y_n_question).and_return(false, false)
          allow(elephant).to receive(:save_question).and_return(does_it_swim_question)
          yes_question.guess
          expect(yes_question.no_answer).to be == does_it_swim_question
        end
      end
    end
  end

  it_behaves_like 'question object'

end
