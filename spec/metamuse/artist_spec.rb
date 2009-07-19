require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Metamuse::Artist do
  subject { Metamuse::Artist.new :name => 'Mozart' }

  describe ".build_artist" do
    subject { Metamuse::Artist }
    it "gets and enhances freebase artist information" do
      mock.proxy(Metamuse::Services::Freebase).artist('Mozart') do |artist|
        mock(artist).enhance_albums!
        artist
      end
      subject.build('Mozart')
    end
  end

  describe "#tracks" do
    it "collects all of the tracks from the every album" do
      album1 = fake(:tracks => [1,2])
      album2 = fake(:tracks => [3,4])
      stub(subject).albums { [album1, album2] }
      subject.tracks.should == [1,2,3,4]
    end
  end

  describe "#enhance_albums!" do
    context "when albums exist" do
      before do
        @image = fake('image')
        @lastfm_albums = [
          Metamuse::Album.new(:name => 'Mild', :rank => 3, :mbid => 1),
          Metamuse::Album.new(:name => 'Hot', :rank => 1, :mbid => 2, :images => [@image]),
          Metamuse::Album.new(:name => 'Medium', :rank => 2, :mbid => 3)
        ]
        stub(subject).lastfm_albums { @lastfm_albums }
        subject.albums = [{:name => "Mild"}, {:name => 'Hot'}, {:name => 'Medium'}]
      end

      it "uses albums from Last.fm" do
        subject.enhance_albums!
        subject.should have_received(:lastfm_albums).any_times
      end

      it "sets the album's mbid" do
        subject.enhance_albums!.first.mbid.should == 2
      end

      it "sets the album's images collection" do
        subject.enhance_albums!.first.images.should include(@image)
      end

      it "sets the album's rank" do
        subject.enhance_albums!.first.rank.should == 1
      end

      context "rankings" do
        it "sets rank to nil when the lastfm album is unranked" do
          ranked = Metamuse::Album.new
          stub(subject).lastfm_albums { [ranked] }
          subject.enhance_albums!.first.rank.should be_nil
        end

        it "sorts based on rank" do
          ranked = [Metamuse::Album.new(:name => 'Mild', :rank => 3), Metamuse::Album.new(:name => 'Hot', :rank => 1), Metamuse::Album.new(:name => 'Medium', :rank => 2)]
          stub(subject).ranked_albums { ranked }
          subject.enhance_albums!
          subject.albums.map{|a| a.name}.should == %w(Hot Medium Mild)
        end
      end
    end

    context "artist has no albums" do
      it "returns albums if the artist has no albums" do
        albums = []
        mock(subject).albums.any_times { albums }
        subject.enhance_albums!.should == albums
      end
    end
  end

  describe "#fetch_albums_and_tracks!" do
    it "fetches artist information from Freebase" do
      mock.proxy(Metamuse::Services::Freebase).artist("Mozart") do |freebase_artist|
        mock(subject).albums=(freebase_artist.albums)
        freebase_artist
      end
      subject.fetch_albums_and_tracks!
    end

    it "assigns the tracks that were retrieved from Freebase" do
      freebase_artist = nil
      stub.proxy(Metamuse::Services::Freebase).artist('Mozart') do |fba|
        freebase_artist = fba
      end
      subject.fetch_albums_and_tracks!
      subject.tracks.should == freebase_artist.tracks
    end
  end
end
