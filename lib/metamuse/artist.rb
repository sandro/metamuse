class Metamuse
  class Artist
    extend Association
    has_many :albums, Album

    attr_accessor :name, :echonest_id, :freebase_guid

    def initialize(attrs={})
      attrs.each {|k,v| send(:"#{k}=", v)}
    end

    def tracks
      @tracks ||= albums.map{|a| a.tracks}.flatten
    end
  end
end
