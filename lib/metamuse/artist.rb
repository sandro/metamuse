class Metamuse
  class Artist
    include InstanceInitialize
    extend Association
    has_many :albums, Album

    attr_accessor :name, :echonest_id, :freebase_guid, :mbid

    def tracks
      @tracks ||= albums.map{|a| a.tracks}.flatten
    end
  end
end
