class Metamuse
  class Track
    extend Collection
    belongs_to :album, Album
    attr_accessor :name, :freebase_id, :index
    alias number index

    def initialize(attrs={})
      attrs.each {|k,v| send(:"#{k}=", v)}
    end
  end
end
