module Hyperfeed
  module ResourceBuilder

    def get_resource(rss, url, index)
      item = rss.xpath("//item")[index]
      {
        :id => generate_id(url, index),
        :title =>  item.xpath("title").inner_text.strip,
        :midias => get_media(item),
        :data => item.xpath("pubDate").inner_text,
        :descricao => item.xpath("description").inner_text.strip,
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

    def retrieve_resources_list(rss, url, options={})
      total = rss.xpath("//item").size
      per_page = options[:per_page] || 10
      page =  options[:page] || 1
      results = build_results(rss, url)

      resource = {:itens_por_pagina => per_page,
                  :pagina_atual => page,
                  :paginas_totais => total/per_page,
                  :total_resultado => total,
                  :resultado => results
      }
    end

    def generate_id(url, index)
      char = url.include?("?") ? "&" : "?"
      "#{url}#{char}resource_id=#{index}"
    end

    def build_results(rss, url)
      results = []
      rss.xpath("//item").each_with_index do |item, index|
        id = generate_id(url, index)
        results << {
          :id => id,
          :data => item.xpath("pubDate").inner_text,
          :titulo => item.xpath("title").inner_text.strip,
          :marca => item.xpath("source").inner_text,
          :descricao => item.xpath("description").inner_text.strip,
          :tipo_recurso => "feed",
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

