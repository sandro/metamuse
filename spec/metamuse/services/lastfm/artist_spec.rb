require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe Metamuse::Services::Lastfm::Artist do
  subject { Metamuse::Services::Lastfm::Artist }

  describe ".build" do
    context "unsuccessful response from lastfm" do
      it "returns an invalid artist with no similar artists" do
        response = {'lfm' => {'status' => 'failed'}}
        artist = subject.build(response)
        artist.should_not be_valid
        artist.similar_artists.should be_empty
      end
    end
  end

  describe "#valid?" do
    it "is an invalid artist when the url contains '+noredirect'" do
      artist = subject.new :url => 'http://last.fm/music/+noredirect/Cold Play'
      artist.should_not be_valid
    end

    it "is a valid artist without redirection" do
      artist = subject.new :url => 'http://last.fm/music/Coldplay'
      artist.should be_valid
    end
  end

  describe "#url=" do
    it "sets the url instance variable" do
      artist = subject.new(:url => 'http://something.com')
      artist.instance_variable_get(:@url).should == 'http://something.com'
      artist.url.should == 'http://something.com'
    end

    it "sets the invalid instance variable" do
      artist = subject.new(:url => 'http://last.fm/music/+noredirect/Cold Play')
      artist.should_not be_valid
    end
  end
end
