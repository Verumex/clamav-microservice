# frozen_string_literal: true

require 'rack'
require_relative 'config/application'

run Application.new
