class Metamuse
  class Artist
    include InstanceInitialize
    extend Association
    has_many :albums, Album

    attr_accessor :name, :echonest_id, :freebase_guid, :mbid

    def tracks
      @tracks ||= albums.map{|a| a.tracks}.flatten
    end

    def rank_albums!
      return if albums.empty?
      self.albums = albums.map do |album|
        album.rank = ranked_albums.detect{|a| a.name == album.name}.try(:rank)
        album
      end.sort
    end

    private

    def ranked_albums
      @ranked_albums ||= Services::Lastfm.top_albums(name)
    end
  end
end
