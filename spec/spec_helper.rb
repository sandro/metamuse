require 'spec'
begin; require 'rubygems'; rescue LoadError; end
require 'fake_web'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'metamuse'

def web_fixture(filename)
  File.join(File.dirname(__FILE__), %W[web_fixtures #{filename}])
end
FakeWeb.allow_net_connect = false

