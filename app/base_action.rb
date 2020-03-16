# frozen_string_literal: true

class BaseAction
  private

  def response(body = '', status: 200, headers: {})
    if body.is_a? Hash
      body = body.to_json
      headers['Content-Type'] = 'application/json'
    end

    [status, headers, [body]]
  end
end
