module Metamuse
  class Album
    include InstanceInitialize
    extend Association
    has_many :tracks, Track

    attr_accessor :name, :release_date, :freebase_id, :mbid, :rank, :images

    def <=>(other)
      if rank
        rank <=> other.rank
      else
        to_s <=> other.to_s
      end
    end

  end
end

