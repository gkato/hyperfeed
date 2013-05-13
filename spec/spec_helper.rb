# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'rspec'
require 'hyperfeed'
require 'fakeweb'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
RSpec.configure do |config|
  def fixture(name)
    File.read("#{File.dirname(__FILE__)}/fixtures/#{name}")
  end

  def register_uri(method, uri, options = {})
    options.merge!(:content_type => "application/xml") unless options[:content_type].nil?
    FakeWeb.register_uri(method, uri, options)
  end
end
