$LOAD_PATH.unshift(File.dirname(__FILE__))

begin; require 'rubygems'; rescue LoadError; end
require 'cgi'
require 'httparty'

require 'httparty_ext'
require 'object_ext'
require 'array_ext'
require 'arrayish'

require 'metamuse/collection'
require 'metamuse/association'
require 'metamuse/services'
require 'metamuse/services/echonest'
require 'metamuse/services/freebase'
require 'metamuse/services/music_brainz'

class Metamuse
  autoload :Artist, 'metamuse/artist'
  autoload :Album, 'metamuse/album'
  autoload :Track, 'metamuse/track'

  class << self
    attr_reader :echonest_api_key

    def echonest_api_key=(key)
      @echonest_api_key = key
      Services::Echonest.api_key = echonest_api_key
    end
  end

  def self.find_artist(name)
    Services::Echonest.artist(name)
  end
end
