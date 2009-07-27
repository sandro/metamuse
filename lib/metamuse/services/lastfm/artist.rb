class Metamuse::Services::Lastfm::Artist
  attr_reader :name, :mbid, :url, :images, :listeners, :playcount, :similar_artists, :tags, :biography, :biography_summary

  include ::Metamuse::InstanceInitialize

  def self.build(response)
    data = response['lfm']['artist']
    new data
  end

  def initialize(attrs={})
    @similar_artists = []
    @images = []
    super
  end

  def bio=(bio)
    @biography = bio['content']
    @biography_summary = bio['summary']
  end

  def images=(urls)
    urls.each do |url|
      @images << Metamuse::Services::Lastfm::Image.new(url) if url.is_a? String
    end
  end
  alias image= images=

  def best_guess
    valid? ? self : similar_artists.first
  end

  def similar_artists=(attrs={})
    attrs['artist'].each do |artist_attrs|
      @similar_artists << self.class.new(artist_attrs)
    end
  end
  alias similar= similar_artists=

  def stats=(stats)
    @playcount = stats['playcount']
    @listeners = stats['listeners']
  end

  def valid?
    url !~ %r(/music/\+noredirect/)
  end
end
