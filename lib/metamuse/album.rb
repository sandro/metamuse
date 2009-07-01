class Metamuse
  class Album
    extend Collection
    has_many :tracks, Track

    attr_accessor :name, :release_date, :freebase_id

    def initialize(attrs={})
      attrs.each {|k,v| send(:"#{k}=", v)}
    end
  end
end

