require 'rake'
load 'Rakefile'

describe 'rake task' do

  it 'should list all files' do
    Rake::Task['list'].invoke('resources/')
  end
end