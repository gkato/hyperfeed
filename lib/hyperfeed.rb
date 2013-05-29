require "hyperfeed/version"
require "http_monkey"
require "nokogiri"

require "hyperfeed/resource_builder"
require "ostruct"
require 'methodize'

class Hyperfeed::Client
  include Hyperfeed::ResourceBuilder

  attr_accessor :code, :body

  def initialize(url, options)
    @options = options

    response = HttpMonkey.at(url).get
    self.code = response.code
    self.body = response.body
    raise "Error: #{response.code} - #{response.body}" unless response.code == 200

    content = Nokogiri::XML(response.body)
    @feed = OpenStruct.new(:url => url, :content => content)
  end

  def self.at(url, options = {})
    new(url, options)
  end

  def get(id = nil)
    return retrieve_resources_list(@feed, @options) unless id
    get_resource(@feed, id)
  end
end
