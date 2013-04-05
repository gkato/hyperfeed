# Hyperfeed

An adapter to plug feeds content on  hypermedia engines

THIS A PROOF OF CONCEPT, SO COWBOY MODE IS ON!

## Installation

Add this line to your application's Gemfile:

    gem 'hyperfeed'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hyperfeed

## Usage


``` ruby
  #For content lists:

  response = Hyperfeed::Client.at("http://contigo.abril.com.br/noticias.rss").get
  puts response.hyperfeed.inspect

  {:itens_por_pagina=>10,
   :pagina_atual=>1,
   :paginas_totais=>1,
   :total_resultado=>10,
   :resultado=>[{:id=>"http://contigo.abril.com.br/noticias.rss?resource_id=0",
                :data=>"2013-04-04 12:38:00 -0300",
                :titulo=>"Sabrina Sato, Rodrigo Faro e Thiago Martins se encontram em evento, em São Paulo",
                :marca=>"Contigo",
                :descricao=>"<p>\n\tUm time de estrelas se reuniu na ma...",
                :tipo_recurso=>"feed", :link=>{:href=>"http://contigo.abril.com.br/noticias.rss?resource_id=0",
                :rel=>"feed",
                :type=>"application/json"}}]}



  #For a content

  response = Hyperfeed::Client.at("http://contigo.abril.com.br/noticias.rss?resource_id=7").get
  puts response.hyperfeed.inspect

  {:id=>"http://contigo.abril.com.br/noticias.rss?resource_id=7&resource_id=7",
   :title=>"Ticiane Pinheiro vira boneca e mostra foto no Twitter",
    :midia=>{:url=>"http://contigo.abril.com.br/resources/files/image/2013/4/132091110-ticiane-pinheiro-m.jpg?1365085327",
             :type=>"image/jpeg"},
    :data=>"2013-04-04 11:20:00 -0300",
    :descricao=>"<p>\n\t<a href=\"/famosos/ticiane-pinheiro/apresentadora/\">Ticiane Pinheiro</a> ganhou um presente na man...",
    :rel=>"materia",
    :type=>"text/html"}}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
