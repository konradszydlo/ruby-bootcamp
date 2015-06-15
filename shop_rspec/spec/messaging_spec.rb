"Error: your message"
"Warn: your message"
"Info: your message"

module Messaging

  ERROR = "Error:"
  WARN = "Warn:"
  INFO = "Info:"

  def warning( message )
    "#{WARN} #{message}"
  end

  def error ( message )
    "#{ERROR} #{message}"
  end

  def info( message )
    "#{INFO} #{message}"
  end
end


class Calculator
  include Messaging
  
  def add number
    puts warning('Number is too large') if number > 1000
  end
end


class Till
  include Messaging

  attr_reader :basket

  def total
    puts error("Basket hasn't been set up") if basket.nil?
  end
end

class Robot
  include Messaging

  def dance
    puts info("Doing robot dance")
  end

end

describe Calculator do

  subject { described_class.new }

  describe "#add" do
    it "displays a warning message if number is > 1000" do
      expect {subject.add(1001) }.to output("Warn: Number is too large\n").to_stdout
    end
  end
end

describe Till do
  subject { described_class.new }

  describe "#total" do
     it "displays error message if basket hasn't been set up" do
       expect { subject.total }.to output("Error: Basket hasn't been set up\n").to_stdout
     end
  end
end

describe Robot do

  subject { described_class.new }

  it 'includes messaging module' do
    expect(subject).to be_a_kind_of(Messaging)
    expect(described_class).to include(Messaging)
  end

  it 'responds to info method' do
    expect(subject).to respond_to(:info)
  end
end

describe Messaging do
  subject { Object.new.tap{|o|o.extend(described_class)} }

  describe '#warning' do
    it 'returns a formatted message' do
      my_message = 'message'
      expect(subject.warning(my_message)).to eq("Warn: #{my_message}")
    end
  end
end
