# frozen_string_literal: true

require 'webrick'
require_relative 'boot'

load_paths = %w[app services].freeze
load_paths.each do |path|
  Dir["#{File.dirname(__FILE__)}/../#{path}/**/*.rb"].each do |file|
    require File.expand_path(file)
  end
end

class Application < Hanami::API
  # For a service health check
  get '/' do
    status 200
  end

  post '/scan', to: Scanner.new
end
