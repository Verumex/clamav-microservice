# frozen_string_literal: true

class Scanner < BaseAction
  def call(env)
    return response(status: 401) unless BasicAuthenticator.call(env)

    request = Rack::Request.new(env)
    return response(status: 422) if request[:file].nil?

    safe_flag = Clamby.safe?(request[:file][:tempfile].path)
    response({ safe: safe_flag }, **{})
  end
end
