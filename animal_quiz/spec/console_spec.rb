require_relative '../../animal_quiz/lib/console'

describe Console do
  describe '#ask' do

    subject(:subject) { described_class.new }

    let(:message) { 'Think of an animal' }

    let(:answer) { 'rabbit' }

    it 'prints a question to user' do
      expect(STDOUT).to receive(:puts).with(message)
      subject.ask(message)
    end

    it 'returns user response' do
      subject.stub(:gets) { answer }
      expect(subject.ask(message)).to eq(answer)
    end
  end

  let(:y_question) { 'play again?' }

  describe "#y_n_question" do
    it "returns truthy when user answered 'y'" do
      subject.stub(:gets) { 'y' }
      expect(subject.y_n_question(y_question)).to be_truthy
    end

    it "returns false when user doens't asnwer 'y'" do
      subject.stub(:gets) { 'n' }
      expect(subject.y_n_question(y_question)).to be_falsey
    end
  end

  describe '#say' do

    subject(:subject) { described_class.new }

    let(:message) { 'I win' }

    it 'prints passed message to console' do
      expect(STDOUT).to receive(:puts).with(message)
      subject.say(message)
    end
  end

end