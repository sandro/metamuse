class Metamuse
  module Services
    class Freebase
      include HTTParty
      base_uri 'http://www.freebase.com'
      format :json

      def self.artist(name)
        envelop = %({"query": #{album_and_track_mql(name)}})
        response = get("/api/service/mqlread", :query => {:query => envelop})
        build_artist response
      end

      def self.artist_search(name)
        response = get("/api/service/search", :query => album_and_track_search_query(name))
        build_artist response
      end

      private

      def self.album_and_track_mql(name)
        %({"album": [{ "id": null, "name": null, "track": [{ "name": null, "index": null, "sort": "index" }], "release_date": null, "release_type": null, "sort": "-release_date", "/common/topic/image": [{ "id": null, "optional": true, "limit": 3 }] }], "id": null, "name": "#{name}", "type": "/music/artist"})
      end

      def self.album_and_track_search_query(name)
        {:query => name, :type => "/music/artist", :limit => 1, :mql_output => album_and_track_mql(name)}
      end

      def self.build_artist(response)
        result = response['result']
        artist = Metamuse::Artist.new :name => CGI.unescapeHTML(result['name']), :freebase_guid => result['guid']
        albums = Array.insist result['album']
        albums.each do |album|
          data = {:name => CGI.unescapeHTML(album['name']), :release_date => album['release_date'], :freebase_id => album['freebase_id']}
          tracks = album['track']
          data['tracks'] = tracks.map {|t| t.update 'name' => CGI.unescapeHTML(t['name'])}
          artist.albums << data
        end
        artist
      end
    end
  end
end
