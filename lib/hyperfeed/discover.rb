module Hyperfeed
  class Discover

    include Hyperfeed::ResourceBuilder

    def initialize(url, rss)
      @url = url
      @rss = rss
    end

    def hyperfeed
      if @url =~ /resource_id=([0-9]+)/
        hyperfeed = get_resource(@rss, @url, $1.to_i)
      else
        hyperfeed = retrieve_resources_list(@rss, @url, {})
      end
    end

  end
end
