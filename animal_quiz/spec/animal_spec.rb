require_relative '../lib/animal'
require_relative '../lib/console'
require_relative '../lib/question'

describe Animal do

  let(:console) { Console.new }
  let(:rabbit) { 'rabbit' }
  let(:dog) { 'dog' }
  let(:yes_no) { '(y or n)' }

  subject(:subject) { described_class.new console, rabbit }
  let(:elephant) { Animal.new console, 'elephant'}
  let(:win_message) { 'You win' }

  describe '#guess' do

    context 'ai guessed correctly' do

      before {
        allow(subject).to receive(:animal_guessed?).and_return(true)
      }

      it 'calls #correct_guess' do
        expect(subject).to receive(:correct_guess)
        subject.guess
      end

      it '#guess returns self - animal' do
        expect(subject.guess).to eq(subject)
      end
    end

    context 'ai guessed incorrectly' do
      before {
        allow(subject).to receive(:animal_guessed?).and_return(false)
      }

      it 'calls #incorrect_guess' do
        expect(subject).to receive(:incorrect_guess)
        subject.guess
      end
    end

  end

  describe '#animal_guessed?' do
    it 'ask user if she thought about rabbit' do
      expect(STDOUT).to receive(:puts).with("Is it rabbit #{yes_no} ?")
      subject.animal_guessed?
    end
  end

  describe 'correct_guess' do
    it 'displays ai wins message to the user' do
      expect(STDOUT).to receive(:puts).with("I win. Pretty smart aren't I?")
      subject.correct_guess
    end
  end

  describe 'incorrect_guess' do

    let(:first_message) { 'You win. help me learn from my mistake before you go...' }

    let(:second_message) { 'Thanks' }

    before {
      allow(STDOUT).to receive(:puts).and_return(first_message, second_message)
    }

    it 'displays user wins message' do
      allow(STDOUT).to receive(:puts).and_return(first_message)
      expect(STDOUT).to receive(:puts).with('You win. help me learn from my mistake before you go...')
      subject.incorrect_guess
    end

    it 'calls #ask_for_correct_animal' do
      expect(subject).to receive(:ask_for_correct_animal)
      subject.incorrect_guess
    end

    it 'calls #ask_for_distinguishing_question' do

      subject.incorrect_guess
    end

    it 'calls #ask_for_answer_to_distinguishing_question' do
      expect(subject).to receive(:ask_for_answer_to_distinguishing_question)
      subject.incorrect_guess
    end

    it 'displays thank you message to the user' do
      expect(STDOUT).to receive(:puts).with('Thanks')
      subject.incorrect_guess
    end

    it ' calls function to saves animal,question and answer data' do
      expect(subject).to receive(:save_question)
      subject.incorrect_guess
    end

    context 'animal distinguishing answer is yes' do
      let(:yes_question) do
        Question.new 'like a donkey', elephant, subject, console
      end

      it 'returns question with subject set to yes' do
        # allow(subject).to receive(:save_question).and_return(yes_question)
        allow(subject).to receive(:ask_for_correct_animal).and_return('elephant')
        allow(subject).to receive(:ask_for_distinguishing_question).and_return('like a donkey')
        allow(subject).to receive(:ask_for_answer_to_distinguishing_question).and_return(true)
        expect(subject.incorrect_guess).to  be  == yes_question
      end
    end

    context 'animal distinguishing answer is no' do
      let(:no_question) do
        Question.new 'Is it small', subject, elephant, console
      end

      it 'returns question with subject set to no' do
        allow(subject).to receive(:ask_for_correct_animal).and_return('elephant')
        allow(subject).to receive(:ask_for_distinguishing_question).and_return('Is it small')
        allow(subject).to receive(:ask_for_answer_to_distinguishing_question).and_return(false)
        expect(subject.incorrect_guess).to  be  == no_question

        # allow(subject).to receive(:save_question).and_return(no_question)
        # expect(subject.incorrect_guess).to eq(no_question)
      end
    end

  end

  describe '#ask_for_correct_animal' do
    let(:message) { 'What animal were you thinking of?' }

    it 'ask what animal the user was thinking of' do
      expect(STDOUT).to receive(:puts).with(message)
      subject.ask_for_correct_animal
    end

    it 'returns user answer' do
      allow(console).to receive(:ask).and_return(rabbit)
      expect(subject.ask_for_correct_animal()).to eq(rabbit)
    end
  end

  describe '#ask_for_distinguishing_question' do

    it 'ask user how to distinguish his animal from ai guess' do
      expect(STDOUT).to receive(:puts).with("Give me a question to distinguish #{rabbit} from #{dog}")
      subject.ask_for_distinguishing_question rabbit, dog
    end
  end

  describe '#ask_for_answer_to_distinguishing_question' do
    it 'ask user for the answer to her distinguishing question' do
      # expect(STDOUT).to receive(:puts).with("For #{rabbit} what is the answer to your question #{yes_no}")
      allow(console).to receive(:y_n_question).and_return true
      expect(subject.ask_for_answer_to_distinguishing_question rabbit).to be_truthy
    end
  end

end