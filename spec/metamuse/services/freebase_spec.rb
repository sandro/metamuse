require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Metamuse::Services::Freebase do
  context "build_artist" do
    before do
      @response = {'result' => {'name' => 'artist', 'guid' => '1'}}
      @album = {'name' => 'album', 'release_date' => 'today', 'freebase_id' => '1', 'track' => []}
    end

    it "parses one album" do
      @response['result'].merge! 'album' => @album
      artist = Metamuse::Services::Freebase.send(:build_artist, @response)
      artist.albums.size.should == 1
      artist.albums.first.name.should == 'album'
    end

    it "parses multiple album" do
      @response['result'].merge! 'album' => [@album, @album.merge('name' => 'album2')]
      artist = Metamuse::Services::Freebase.send(:build_artist, @response)
      artist.albums.size.should == 2
      artist.albums.last.name.should == 'album2'
    end
  end
end
