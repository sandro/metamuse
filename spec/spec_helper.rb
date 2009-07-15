$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'metamuse'
require 'spec'
require 'spec/autorun'
require 'rr'
require 'fake_object'
include FakeObject

Spec::Runner.configure do |config|
  config.mock_with RR::Adapters::Rspec
end

def web_fixture(filename)
  File.join(File.dirname(__FILE__), %W[web_fixtures #{filename}])
end

end
