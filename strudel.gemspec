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

  rubydoc = 'https://www.rubydoc.info/gems'
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/master/CHANGELOG.md"
  spec.metadata['documentation_uri'] = "#{rubydoc}/#{spec.name}/#{spec.version}"

  spec.files = Dir['lib/**/*.rb', '*.md', '*.txt', '.yardopts']
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.3'

  spec.add_development_dependency 'rspec', '~> 3.12'
end
