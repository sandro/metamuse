class Metamuse
  class Album
    extend Association
    has_many :tracks, Track

    attr_accessor :name, :release_date, :freebase_id, :mbid

    def initialize(attrs={})
      attrs.each {|k,v| send(:"#{k}=", v)}
    end
  end
end

