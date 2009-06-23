HTTParty::Request.class_eval do
  class << self
    attr_accessor :debug
  end
  self.debug = true

  def perform_with_debug
    if self.class.debug
      puts "HTTParty making #{http_method::METHOD} request to:"
      puts uri
    end
    perform_without_debug
  end

  alias_method :perform_without_debug, :perform
  alias_method :perform, :perform_with_debug
end
