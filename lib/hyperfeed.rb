require "hyperfeed/version"
require "http_monkey"
require "nokogiri"
require "json"

require "hyperfeed/resource_builder"
require "hyperfeed/discover"
require "hyperfeed/middleware/adapter_middleware"

class HttpMonkey::Client::Response
  attr_accessor :hyperfeed

  @@injections = {}
  def self.inject_with(attribute, value)
    @@injections[attribute] = value
  end

  def initialize(code, headers, body)
    super
    self.headers = HttpObjects::HeadersHash.new(headers)
    after_initialize
  end

  protected

  def after_initialize
    @@injections.each do |attribute, value|
      send("#{attribute}=", value)
    end
  end

end

Hyperfeed::Client = HttpMonkey.build do
  middlewares.use Hyperfeed::AdapterMiddleware
end
