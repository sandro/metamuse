require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Metamuse::Services::MusicBrainz do
  describe ".album" do
    subject { Metamuse::Services::MusicBrainz }

    it "Finds an album with tracks" do
      album = subject.album("bb32aa1d-f37b-4134-8c0e-b43b7a6dab85")
      album.tracks.should_not be_empty
    end
  end
end
