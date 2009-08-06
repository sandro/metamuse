module Metamuse
  class Album
    include InstanceInitialize
    extend Association
    has_many :tracks, Track
    belongs_to :artist, Artist

    attr_accessor :name, :release_date, :freebase_id, :mbid, :rank, :images

    def <=>(other)
      if rank && other.rank
        rank.to_i <=> other.rank.to_i
      elsif rank
        -1
      elsif other.rank
        1
      else
        0
      end
    end

  end
end

