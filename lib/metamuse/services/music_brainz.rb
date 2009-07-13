class Metamuse
  module Services
    class MusicBrainz
      include HTTParty
      base_uri 'http://musicbrainz.org/ws/1'
      default_params :type => :xml

      def self.album(id)
        build_album get("/release/#{id}/", :query => {:inc => :tracks})
      end

      private

      def self.build_album(response)
        release = response['metadata']['release']
        album_data = {:name => release['title'], :mbid => release['id']}

        track_list = release['track_list']['track']
        tracks = track_list.map do |track|
          Track.new :name => track['title'], :index => track_list.index(track), :mbid => track['id']
        end

        Album.new album_data.merge(:tracks => tracks)
      end
    end
  end
end
