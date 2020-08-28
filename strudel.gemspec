# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'strudel/version'

Gem::Specification.new do |spec|
  spec.name = 'strudel'
  spec.version = Strudel::VERSION
  spec.authors = ['Justin Howard']
  spec.email = ['jmhoward0@gmail.com']

  spec.summary = 'A tiny dependency injection container'
  spec.homepage = 'https://github.com/justinhoward/strudel'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(spec)/})
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'redcarpet', '~> 3.4'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'rubocop', '~> 0.61'
  spec.add_development_dependency 'simplecov', '~> 0.11'
  spec.add_development_dependency 'yard', '>= 0.9.11'
end
