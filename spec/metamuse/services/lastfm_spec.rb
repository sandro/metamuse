require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Metamuse::Services::Lastfm do
  subject { Metamuse::Services::Lastfm }
  describe "#build_albums" do
    before do
      albums = [ {'name' => 'Album', 'mbid' => '123', 'rank' => '1', 'image' => []} ]
      @response = {'lfm' => {'topalbums' => {'album' => albums} }}
    end

    it "creates an album with a name, mbid, rank, and images" do
      mock(Metamuse::Album).new({:name => 'Album', :mbid => '123', :rank => '1', :images => []})
      subject.send(:build_albums, @response)
    end

    context "response with images" do
      before do
        images = %w(1.jpg 2.jpg)
        albums = [ {'image' => images} ]
        @response = {'lfm' => {'topalbums' => {'album' => albums} }}
      end

      it "builds a Lastfm::Image for each image location" do
        mock(Metamuse::Services::Lastfm::Image).new('1.jpg')
        mock(Metamuse::Services::Lastfm::Image).new('2.jpg')
        subject.send(:build_albums, @response)
      end
    end
  end
end
