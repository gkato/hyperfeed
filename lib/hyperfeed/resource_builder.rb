module Hyperfeed
  module ResourceBuilder

    def get_resource(feed, index)
      item = feed.content.xpath("//item")[index]
      {
        :id => generate_id(feed.url, index),
        :title =>  item.xpath("title").inner_text.strip,
        :data => item.xpath("pubDate").inner_text,
        :descricao => item.xpath("description").inner_text.strip,
        :midias => get_media(item),
        :link => {
          :href => item.xpath("link").inner_text,
          :rel => "materia",
          :type => "text/html"
        }
      }
    end

    def get_media(item)
      media = ""
      unless item.xpath("enclosure").nil?
        media = {
          :url => item.xpath("enclosure").attr("url").inner_text,
          :type => item.xpath("enclosure").attr("type").inner_text
        }
      end
    end

    def retrieve_resources_list(feed, options={})
      total = feed.content.xpath("//item").size
      per_page = options[:per_page] || 10
      page =  options[:page] || 1
      results = build_results(feed)

      resource = {:per_page => per_page,
                  :current_page => page,
                  :total_pages => total/per_page,
                  :total_results => total,
                  :result => results
      }
    end

    def generate_id(url, index)
      char = url.include?("?") ? "&" : "?"
      "#{url}#{char}resource_id=#{index}"
    end

    def build_results(feed)
      results = []
      feed.content.xpath("//item").each_with_index do |item, index|
        id = generate_id(feed.url, index)
        results << {
          :id => id,
          :date => item.xpath("pubDate").inner_text,
          :title => item.xpath("title").inner_text.strip,
          :source => item.xpath("source").inner_text,
          :resource_type => "feed",
          :link => {
            :href => id,
            :rel => "feed",
            :type => "application/json"
          }
        }
      end
      results
    end

  end
end

