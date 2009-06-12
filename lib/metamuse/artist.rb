class Metamuse
  class Artist
    attr_accessor :name, :echonest_id

    def self.from_echonest(response)
      if artists = response['response']['artists']
        artist = artists['artist']
        artist = artist.first if artist.is_a?(Array)
        new :name => artist['name'], :echonest_id => artist['id']
      end
    end

    def initialize(attrs={})
      attrs.each {|k,v| send(:"#{k}=", v)}
    end
  end
end
