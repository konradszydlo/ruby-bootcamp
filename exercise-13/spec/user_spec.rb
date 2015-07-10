require 'set'

require_relative '../models/user'

describe User do

  let(:roles) { Set.new(["admin", "user"])  }

  let(:admin_role) { 'admin' }

  let(:subject) { described_class.new 'bob', 'bobb' }

  describe '#in_role?' do
    context 'user has role defined' do
      it 'returns true' do
        expect(subject.in_role?(admin_role)).to be true
      end
    end
    context 'user does not have a role' do
      it 'returns false' do
        expect(subject.in_role?('accounting')).to be false
      end
    end
  end
end