require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe Metamuse::Services::Lastfm::Artist do
  subject { Metamuse::Services::Lastfm::Artist }

  describe "#best_guess" do
    it "returns itself when the artist is valid" do
      artist = subject.new :url => 'http://last.fm/music/Coldplay'
      artist.best_guess.should == artist
    end

    it "returns the most similar artist when the artist is invalid" do
      similar_artist = fake(:similar_artist)
      artist = subject.new :url => 'http://last.fm/music/+noredirect/Cold Play'
      mock(artist).similar_artists { [similar_artist] }
      artist.best_guess.should == similar_artist
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
end
