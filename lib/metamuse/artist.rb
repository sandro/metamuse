class Metamuse
  class Artist
    attr_accessor :name, :echonest_id

    attr_accessor :name, :echonest_id, :freebase_guid

    def initialize(attrs={})
      attrs.each {|k,v| send(:"#{k}=", v)}
    end
  end
end
