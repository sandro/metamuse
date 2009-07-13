class Metamuse
  class Track
    include InstanceInitialize
    extend Association
    belongs_to :album, Album
    attr_accessor :name, :index, :freebase_id, :mbid
    alias number index

    def <=>(other)
      name <=> other.name
    end
  end
end
