# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hyperfeed/version'

Gem::Specification.new do |gem|
  gem.name          = "hyperfeed"
  gem.version       = Hyperfeed::VERSION
  gem.authors       = ["Guilherme Kato"]
  gem.email         = ["guilherme.kato@abril.com.br"]
  gem.description   = %q{An adapter to plug feeds content on hypermedia engines}
  gem.summary       = %q{An adapter to plug feeds content on hypermedia engines}
  gem.homepage      = "https://github.com/gkato/hyperfeed"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "http_monkey", "~> 0.0"
  gem.add_dependency "nokogiri", "~> 1.5"
  gem.add_dependency 'methodize'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'fakeweb'
end
