class Metamuse
  module Services
    class Echonest
      include HTTParty
      base_uri 'http://developer.echonest.com/api'
      default_params :version => 3
      format :xml

      class << self
        attr_reader :api_key
      end

      def self.api_key=(key)
        @api_key = key
        default_params :api_key => api_key
      end

      def self.find_artist(name)
        Metamuse::Artist.from_echonest get('/search_artists', :query => {:query => name})
      end
    end
  end
end
