module Metamuse
  class Track
    include InstanceInitialize
    extend Association
    belongs_to :album, Album
    attr_accessor :name, :index, :freebase_id, :mbid
    alias number index

    def <=>(other)
      name <=> other.name
    end

    def inspect
      "#<#{self.class.inspect}:#{object_id.inspect}, index: #{index.inspect}, name: #{name.inspect}, album: #{album.name.inspect}>"
    end
  end
end
