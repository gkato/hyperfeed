# Hyperfeed

An adapter to plug feeds content on  hypermedia engines

## Installation

Add this line to your application's Gemfile:

    gem 'hyperfeed'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hyperfeed

## Usage

``` ruby
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
                :type=>"application/json"}}, 
                {:id=>"http://contigo.abril.com.br/noticias.rss?resource...
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
