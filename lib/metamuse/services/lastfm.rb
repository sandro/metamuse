class Metamuse
  module Services
    class Lastfm
      extend Service
      include HTTParty
      base_uri 'http://ws.audioscrobbler.com/2.0/'
      has_api_key

      def self.top_albums(name)
        build_albums get('', :query => {:method => "artist.gettopalbums", :artist => name})
      end

      def self.artist(name)
      end

      private

      def self.build_albums(response)
        album_data = response['lfm']['topalbums']['album']
        album_data.map do |data|
          Album.new :name => data['name'], :mbid => data['mbid'], :rank => data['rank'], :images => data['image']
        end
      end
    end
  end
end
