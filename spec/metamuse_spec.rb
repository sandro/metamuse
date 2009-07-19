require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Metamuse" do
  describe "integration" do
    it "finds coldplay" do
      Metamuse.echonest_api_key = "TEST"
      Metamuse.find_artist('coldplay').name.should == 'Coldplay'
    end
  end

  describe "finding an artist" do
    it "searches through echonest" do
      mock(Metamuse::Services::Echonest).artist('coldplay')
      Metamuse.find_artist('coldplay')
    end
  end

  describe "finding tracks" do

  end
end
