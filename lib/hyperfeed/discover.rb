require"hyperfeed/resource"

module Hyperfeed
  class Discover

    include Hyperfeed::ResourceBuilder

    def initialize(feed)
      @feed = feed
    end

    def hyperfeed
      if @feed.url =~ /resource_id=([0-9]+)/
        resource = get_resource(@feed, $1.to_i)
      else
        resource = retrieve_resources_list(@feed, {})
      end
      Hyperfeed::Resource.new(resource)
    end

  end
end
