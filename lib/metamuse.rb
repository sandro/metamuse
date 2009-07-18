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
require 'metamuse/services/lastfm'

class Metamuse
  autoload :Artist, 'metamuse/artist'
  autoload :Album, 'metamuse/album'
  autoload :Track, 'metamuse/track'

  class << self
    attr_reader :echonest_api_key, :lastfm_api_key

    def echonest_api_key=(key)
      @echonest_api_key = key
      Services::Echonest.api_key = echonest_api_key
    end

    def lastfm_api_key=(key)
      @lastfm_api_key = key
      Services::Lastfm.api_key = lastfm_api_key
    end

    def find_artist(name)
      Services::Echonest.artist(name)
    end

    private

    def api_keys
      if File.exists?(name=".api_keys.yml")
        YAML.load_file name
      else
        {}
      end
    end

    def register_api_keys
      api_keys.each do |service, value|
        send("#{service}_api_key=", value)
      end
    end
  end

  module InstanceInitialize
    def initialize(attrs={})
      attrs.each {|k,v| instance_variable_set "@#{k}", v}
    end
  end
end
