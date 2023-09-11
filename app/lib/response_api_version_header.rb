# frozen_string_literal: true

# lib/custom_header_middleware.rb

class ResponseApiVersionHeader
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    headers["X-Acme-Api-Version"] = Current.api_version

    [status, headers, body]
  end
end
