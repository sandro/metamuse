require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Metamuse" do
  describe "integration" do
    it "finds coldplay" do
      Metamuse.lastfm_api_key = "TEST"
      Metamuse.find_artist('coldplay').name.should == 'Coldplay'
    end
  end

  describe "finding an artist" do
    it "searches through lastfm" do
      mock(Metamuse::Services::Lastfm).artist('coldplay')
      Metamuse.find_artist('coldplay')
    end
  end

  describe "finding tracks" do

  end
end
