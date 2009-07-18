class Metamuse
  class Artist
    include InstanceInitialize
    extend Association
    has_many :albums, Album

    attr_accessor :name, :echonest_id, :freebase_guid, :mbid

    def tracks
      @tracks ||= albums.map{|a| a.tracks}.flatten
    end

    def enhance_albums!
      return albums if albums.empty?
      self.albums = albums.map do |album|
        lastfm_album = lastfm_albums.detect{|a| a.name == album.name}
        if lastfm_album
          album.rank = lastfm_album.rank
          album.mbid = lastfm_album.mbid
          album.images = lastfm_album.images
        end
        album
      end.sort
    end

    private

    def lastfm_albums
      @lastfm_albums ||= Services::Lastfm.top_albums(name)
    end
  end
end
