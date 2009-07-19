$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'metamuse'
require 'spec'
require 'spec/autorun'
require 'rr'
require 'fake_object'
$LOAD_PATH.unshift("/Users/santuri/Code/Ruby/fakeweb/lib")
require 'fake_web'
include FakeObject

Spec::Runner.configure do |config|
  config.mock_with RR::Adapters::Rspec
end

def web_fixture(filename)
  File.join(File.dirname(__FILE__), %W[web_fixtures #{filename}])
end

fixture_dir = File.join(File.dirname(__FILE__), %w(web_fixtures))

FakeWeb.generate_fixtures fixture_dir if ENV['FAKEWEB_FIXTURES']

unless FakeWeb.generate_fixtures?
  FakeWeb.register_fixtures fixture_dir
  FakeWeb.allow_net_connect = false
end
