
shared_examples 'question object' do
  it 'responds to guess' do
    expect(subject).to respond_to(:guess)
  end
end