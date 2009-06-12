$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'httparty'
require 'metamuse/httparty_ext.rb'
require 'metamuse/artist.rb'

class Metamuse
  include HTTParty
  base_uri 'http://developer.echonest.com/api'
  default_params :version => 3

  class << self
    attr_reader :echonest_api_key

    def echo_nest_api_key=(key)
      @echonest_api_key = key
      default_params :api_key => echonest_api_key
    end
  end

  def self.find_artist(name, options={})
    Artist.from_echonest get('/search_artists', :query => {:query => name})
  end
end
