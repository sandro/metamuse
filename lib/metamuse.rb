$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'httparty'
require 'metamuse/httparty_ext.rb'
require 'metamuse/artist.rb'
require 'metamuse/services/echonest.rb'

class Metamuse
  class << self
    attr_reader :echonest_api_key

    def echonest_api_key=(key)
      @echonest_api_key = key
      Services::Echonest.api_key = echonest_api_key
    end
  end

  def self.find_artist(name)
    Services::Echonest.find_artist(name)
  end
end
