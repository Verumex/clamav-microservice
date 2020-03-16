# frozen_string_literal: true

module BasicAuthenticator
  def self.call(env)
    auth = Rack::Auth::Basic::Request.new(env)
    return false unless auth.provided?

    auth&.credentials == [ENV.fetch('API_USERNAME'), ENV.fetch('API_PASSWORD')]
  end
end
