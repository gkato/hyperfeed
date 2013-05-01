module Hyperfeed
  class Feed

    attr_accessor :url, :content

    def initialize(url, content)
      self.url = url
      self.content = content
    end
  end
end
