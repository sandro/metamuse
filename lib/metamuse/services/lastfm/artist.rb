class Metamuse::Services::Lastfm::Artist
  attr_reader :name, :mbid, :url, :images, :listeners, :playcount, :similar_artists, :tags, :biography, :biography_summary

  include ::Metamuse::InstanceInitialize

  def self.build(response)
    if response['lfm']['status'] == 'ok'
      data = response['lfm']['artist']
      new data
    else
      new :invalid => true
    end
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

  def url=(url)
    @url = url
    @invalid = ! valid?
  end

  def valid?
    url && url !~ %r(/music/\+noredirect/)
  end
end
