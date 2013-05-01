module Hyperfeed
  include Hyperfeed::ResourceBuilder

  def search(url, query)
    rss = self.get(url)
    result = retrieve_resources_list(rss, url, {})

    return unless result.resultado.any?

    search = result.resultado.map do |item|
      item if item.values.map(&:to_s).join(" ").include? query
    end

  end
end
