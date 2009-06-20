require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Metamuse" do
  describe "integration" do
    it "finds coldplay" do
      FakeWeb.register_uri('http://developer.echonest.com/api/search_artists?query=coldplay&version=3&api_key=TEST', :file => web_fixture('echonest_coldplay_search.xml'))
      Metamuse.echonest_api_key = "TEST"
      Metamuse.find_artist('coldplay').name.should == 'Coldplay'
    end
  end

  describe "finding an artist" do
    it "searches through echonest" do
      Metamuse::Services::Echonest.should_receive(:find_artist).with('coldplay')
      Metamuse.find_artist('coldplay')
    end
  end

  describe "finding tracks" do

  end
end
