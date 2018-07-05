lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'micropub/endpoint/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = ['>= 2.4', '< 2.6']

  spec.name          = 'micropub-endpoint'
  spec.version       = Micropub::Endpoint::VERSION
  spec.authors       = ['Jason Garber']
  spec.email         = ['jason@sixtwothree.org']

  spec.summary       = 'Discover a URL’s Micropub endpoint.'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/jgarber623/micropub-endpoint-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(bin|spec)/}) }

  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16', '>= 1.16.2'
  spec.add_development_dependency 'rake', '~> 12.3', '>= 12.3.1'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'rubocop', '~> 0.57.2'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.27'
  spec.add_development_dependency 'simplecov', '~> 0.16.1'
  spec.add_development_dependency 'simplecov-console', '~> 0.4.2'
  spec.add_development_dependency 'webmock', '~> 3.4', '>= 3.4.2'

  spec.add_runtime_dependency 'absolutely', '~> 1.0'
  spec.add_runtime_dependency 'addressable', '~> 2.5', '>= 2.5.2'
  spec.add_runtime_dependency 'http', '~> 3.3'
  spec.add_runtime_dependency 'nokogiri', '~> 1.8', '>= 1.8.4'
end
