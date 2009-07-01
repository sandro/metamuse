$LOAD_PATH.unshift(File.dirname(__FILE__))

begin; require 'rubygems'; rescue LoadError; end
require 'cgi'
require 'httparty'
require 'httparty_ext'
require 'metamuse/artist'
require 'metamuse/services/echonest'

class Metamuse
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
