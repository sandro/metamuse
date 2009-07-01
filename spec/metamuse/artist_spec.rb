require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Metamuse::Artist do
  describe "#tracks" do
    it "collects all of the tracks from the every album" do
      album1 = stub(:tracks => [1,2])
      album2 = stub(:tracks => [3,4])
      subject.stub!(:albums => [album1, album2])
      subject.tracks.should == [1,2,3,4]
    end
  end
end
