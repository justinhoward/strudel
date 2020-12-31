# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'strudel/version'

Gem::Specification.new do |spec|
  spec.name = 'strudel'
  spec.version = Strudel.version
  spec.authors = ['Justin Howard']
  spec.email = ['jmhoward0@gmail.com']

  spec.summary = 'A tiny dependency injection container'
  spec.homepage = 'https://github.com/justinhoward/strudel'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(spec)/})
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec', '~> 3.4'
  # 0.81 is the last rubocop version with Ruby 2.3 support
  spec.add_development_dependency 'rubocop', '0.81.0'
  spec.add_development_dependency 'rubocop-rspec', '1.38.1'
end
