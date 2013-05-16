require 'digest/md5'

module Hyperfeed
  module ResourceBuilder

    def get_resource(feed, id)
      item = feed.content.xpath("//item").find { |i| generate_id(i) == id }

      collect_fields(item).extend(Methodize)
    end

    def get_media(item)
      media = {
        :url => item.attr("url").strip,
        :type => item.attr("type").strip,
      }
      item.children.reject{ |x| x.name == "text" }.each do |node|
        media[node.name.to_sym] = node.inner_text.strip
      end
      media
    end

    def retrieve_resources_list(feed, options={})
      total = feed.content.xpath("//item").size

      per_page = (options[:per_page] || 10).to_i
      page =  (options[:page] || 1).to_i

      results = build_results(feed).each_slice(per_page).to_a

      total_pages = results.size
      results = results[page-1]

      resource = {:per_page => per_page,
                  :current_page => page,
                  :total_pages => total_pages,
                  :total_results => total,
                  :result => results
      }.extend(Methodize)
    end

    def generate_id(item)
      link = (item.xpath("link") || item.xpath("guid")).inner_text
      Digest::MD5.hexdigest(link)
    end

    def collect_fields(item)
      resource = {:id => generate_id(item)}
      item.children.reject{ |x| x.name == "text" }.each do |node|
        if node.name == "enclosure"
          resource[:enclosure] ||= []
          resource[:enclosure] << get_media(node)
        else
          resource[node.name.downcase.to_sym] = node.inner_text.strip
        end
      end
      resource
    end

    def build_results(feed)
      results = []
      feed.content.xpath("//item").each do |item|
        id = generate_id(item)
        results << collect_fields(item)
      end
      results
    end

  end
end

