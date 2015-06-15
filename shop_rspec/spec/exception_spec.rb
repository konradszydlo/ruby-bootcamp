class Run

  attr_reader :distance, :time

  def initialize distance, time
    @distance = distance
    @time = time
  end

  def add_more_distance new_distance
    raise "distance must be positive" unless new_distance > 0
    @distance += new_distance
  end

  def add_more_time new_time
    raise ArgumentError, "time must be positive" unless new_time > 0
    @time += new_time
  end
end


describe Run do

  subject { described_class.new 10, 20 }

  describe "#add_more_distance" do
    it "raises exception when distance is negative" do
      expect{ subject.add_more_distance(-2) }.to raise_error("distance must be positive")
    end
  end

  describe "#add_more_time" do
    it "raises ArgumentError when time is negative" do
      expect { subject.add_more_time(-3)}.to raise_error(ArgumentError, "time must be positive")
    end
  end
end