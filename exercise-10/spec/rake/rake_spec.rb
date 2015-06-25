require 'rake'

describe 'Rakefile List' do

  include_context 'temporary_files'

  let(:list_csv) { %w{csv_file1.csv csv_file2.csv csv_file3.csv csv_file4.csv csv_file5.csv}}

  let(:list_jpg) { %w{ image1.jpg image2.jpg image3.jpg image4.jpg image5.jpg} }

  before do
    list_csv.each do |filename|
      touch_file filename
    end

    list_jpg.each do |filename|
      touch_file filename
    end
  end

  before do
    Rake.application = Rake::Application.new
    Rake.application.add_import 'rakelib/list.rake'
    Rake.application.init
    Rake.application.load_imports
  end

  after do
    FileUtils.rm_r temp_dir
  end

  context 'without pattern specified' do
    it 'displays list of all files in a dir' do
      output = "#{list_csv.join("\n")}\n#{list_jpg.join("\n")}\n"
      expect { Rake::Task['list'].invoke(temp_dir)}.to output(output).to_stdout
    end
  end

  context 'with pattern passed' do
    it 'displays list of images' do
      output = "#{list_jpg.join("\n")}\n"
      expect { Rake.application['list'].invoke(temp_dir, '*.jpg')}.to output(output).to_stdout
    end

    it 'displays list of csvs' do
      output = "#{list_csv.join("\n")}\n"
      expect { Rake.application['list'].invoke(temp_dir, '*.csv')}.to output(output).to_stdout
    end
  end
end