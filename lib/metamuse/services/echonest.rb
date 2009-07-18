module Metamuse
  module Services
    class Echonest
      extend Service
      include HTTParty
      base_uri 'http://developer.echonest.com/api'
      default_params :version => 3
      format :xml
      has_api_key

      def self.artist(name)
        build_artist get('/search_artists', :query => {:query => name})
      end

      private

      def self.build_artist(response)
        if artists = response['response']['artists']
          artist = artists['artist']
          artist = artist.first if artist.is_a?(Array)
          Metamuse::Artist.new :name => artist['name'], :echonest_id => artist['id']
        end
      end
    end
  end
end
