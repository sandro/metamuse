$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'metamuse'
require 'spec'
require 'spec/autorun'
require 'rr'
Spec::Runner.configure do |config|
  config.mock_with RR::Adapters::Rspec
end

def web_fixture(filename)
  File.join(File.dirname(__FILE__), %W[web_fixtures #{filename}])
end

def fake(args, strategy = :stub)
  raise "fake expects a hash, not #{args}" unless args.is_a?(Hash)
  object = Object.new
  args.each do |method_name, return_value|
    send(strategy, object).__send__(method_name).returns(return_value) # stub(object).method.returns(value)
  end
  object
end
