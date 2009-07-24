module Metamuse
  class Artist
    include InstanceInitialize
    extend Association
    has_many :albums, Album

    attr_accessor :name, :echonest_id, :freebase_guid, :mbid

    def self.build(name)
      artist = Services::Freebase.artist(name)
      artist.enhance_albums!
      artist
    end

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

    def fetch_albums_and_tracks!
      artist = Services::Freebase.artist(name)
      self.albums = artist.albums
    end

    def inspect
      "#<#{self.class.inspect}:#{object_id.inspect}, name: #{name.inspect}, echonest_id: #{echonest_id.inspect}, freebase_guid: #{freebase_guid.inspect}, mbid: #{mbid.inspect}, albums: #{album_names.inspect}>"
    end

    private

    def album_names
      @album_names ||= albums.map {|a| a.name}
    end

    def lastfm_albums
      @lastfm_albums ||= Services::Lastfm.top_albums(name)
    end
  end
end
