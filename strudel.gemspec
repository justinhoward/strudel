# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
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

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rubocop'
end
