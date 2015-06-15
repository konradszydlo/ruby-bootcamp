require_relative '../../animal_quiz/lib/play'
require_relative '../../animal_quiz/lib/console'

describe Play do
  describe "#game" do

    subject { described_class.new }

    it 'should ask user to think of an animal' do
      expect { subject.game}.to output('Think of an animal').to_stdout
    end
  end
end
#