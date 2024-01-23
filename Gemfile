# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in strudel.gemspec
gemspec

not_jruby = %i[ruby mingw x64_mingw].freeze

gem 'bundler'
gem 'byebug', platforms: not_jruby
gem 'irb'
gem 'redcarpet', '~> 3.6', platforms: not_jruby
gem 'yard', '~> 0.9.34', platforms: not_jruby

if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.7')
  gem 'rubocop', '~> 1.60.1'
  gem 'rubocop-rspec', '~> 2.26.1'
  gem 'simplecov', '~> 0.22.0'
  gem 'simplecov-cobertura', '~> 2.1'
end
