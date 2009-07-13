require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Metamuse::Artist do
  subject { Metamuse::Artist.new :name => 'Mozart' }

  describe "#tracks" do
    it "collects all of the tracks from the every album" do
      album1 = stub(:tracks => [1,2])
      album2 = stub(:tracks => [3,4])
      subject.stub!(:albums => [album1, album2])
      subject.tracks.should == [1,2,3,4]
    end
  end

  describe "#rank_albums!" do
    before do
      subject.albums = [{:name => "Mild"}, {:name => 'Hot'}, {:name => 'Medium'}]
    end

    it "uses the #ranked_albums collection" do
      ranked = Metamuse::Album.new(:name => 'Mild')
      subject.should_receive(:ranked_albums).at_least(:once).and_return([ranked])
      subject.rank_albums!
    end

    it "returns nil when a ranked album cannot be found" do
      ranked = Metamuse::Album.new
      subject.stub(:ranked_albums => [ranked])
      subject.rank_albums!
      subject.albums.first.rank.should be_nil
    end

    it "sorts based on rank" do
      ranked = [Metamuse::Album.new(:name => 'Mild', :rank => 3), Metamuse::Album.new(:name => 'Hot', :rank => 1), Metamuse::Album.new(:name => 'Medium', :rank => 2)]
      subject.stub(:ranked_albums => ranked)
      subject.rank_albums!
      subject.albums.map{|a| a.name}.should == %w(Hot Medium Mild)
    end
  end

  describe "#ranked_albums" do
    it "grabs ranked albums from Last.fm" do
      Metamuse::Services::Lastfm.should_receive(:top_albums).with('Mozart')
      subject.send(:ranked_albums)
    end
  end
end
