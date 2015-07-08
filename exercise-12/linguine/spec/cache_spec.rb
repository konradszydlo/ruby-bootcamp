require_relative '../cache'

describe Cache do

  let(:welcome) { 'Welcome' }
  let(:salut) { 'Salut'}

  describe '#add' do
    it 'adds value to cache using provided key' do
      subject.add(welcome, salut)
      expect(subject.get_cached_value(welcome)).to eq(salut)
    end
  end

  describe '#remove' do
    it 'removes value from cache for provided key' do
      subject.add(welcome, salut)
      subject.remove(welcome)
      expect(subject.get_cached_value(welcome)).to be(nil)
    end
  end

  describe '#is_cached' do
    it 'returns false when value is not cached' do
      expect(subject.is_cached(welcome)).to be(false)
    end
    it 'returns true when value is cached' do
      subject.add(welcome, salut)
      expect(subject.is_cached(welcome)).to be(true)
    end
  end

  describe '#get_cached_value' do
    it 'returns cached value' do
      subject.add(welcome, salut)
      expect(subject.get_cached_value(welcome)).to eq(salut)
    end
  end
end