module Hyperfeed
  class AdapterMiddleware

    def initialize(app)
      @app = app
    end

    def call(env)
      code, headers, body = @app.call(env)

      url = env.uri.to_s
      rss = Nokogiri::XML(body)

      discover = Hyperfeed::Discover.new(url, rss)
      HttpMonkey::Client::Response.inject_with(:hyperfeed, discover.hyperfeed)

      [code, headers, body]
    end

  end
end

