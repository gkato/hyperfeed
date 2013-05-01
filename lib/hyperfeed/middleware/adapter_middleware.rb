require "hyperfeed/feed"

module Hyperfeed
  class AdapterMiddleware

    def initialize(app)
      @app = app
    end

    def call(env)
      code, headers, body = @app.call(env)
      url = env.uri.to_s
      content = Nokogiri::XML(body)

      feed = Hyperfeed::Feed.new(url, content)

      discover = Hyperfeed::Discover.new(feed)
      HttpMonkey::Client::Response.inject_with(:hyperfeed, discover.hyperfeed)

      [code, headers, body]
    end

  end
end

