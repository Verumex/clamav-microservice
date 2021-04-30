# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Only define Ruby version once (i.e. for Heroku)
version_file = File.join(File.dirname(__FILE__), '.ruby-version')
ruby File.read(version_file).strip

gem 'clamby'
gem 'hanami-api', '~> 0.2.0'
gem 'rack', '~> 2.2.0'
gem 'webrick', '~> 1.7.0'

group :production do
  gem 'nakayoshi_fork'
end

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'bundler-audit', require: false
  gem 'rack-test'
  gem 'rspec'
end
