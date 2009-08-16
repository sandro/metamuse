module Metamuse
  module Services
    module Lastfm
      extend Service
      include HTTParty
      base_uri 'http://ws.audioscrobbler.com/2.0/'
      has_api_key

      def self.top_albums(name)
        build_albums get('', :query => {:method => "artist.gettopalbums", :artist => name})
      end

      def self.artist(name)
        attributes = artist_info(name).attributes.rename_key(:url, :lastfm_url)
        ::Metamuse::Artist.new attributes
      end

      def self.artist_info(name)
        response = get('', :query => {:method => 'artist.getinfo', :artist => name})
        Artist.build response
      end

      private

      def self.build_albums(response)
        album_data = response['lfm']['topalbums']['album']
        album_data.map do |data|
          images = data['image'].map {|location| Image.new location}
          Album.new :name => data['name'], :mbid => data['mbid'], :rank => data['rank'], :images => images
        end
      end
    end
  end
end
