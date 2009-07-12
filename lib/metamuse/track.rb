class Metamuse
  class Track
    extend Association
    belongs_to :album, Album
    attr_accessor :name, :index, :freebase_id, :mbid
    alias number index

    def initialize(attrs={})
      attrs.each {|k,v| send(:"#{k}=", v)}
    end

    def <=>(other)
      name <=> other.name
    end
  end
end
