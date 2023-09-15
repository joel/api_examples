# frozen_string_literal: true

class ApiRequestPatcher
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    # Check if it's an API request
    if api_request?(request)
      api_version    = request.get_header("HTTP_API_VERSION")
      endpoint       = extract_endpoint(request.path_info)
      json_params    = env["rack.input"].read

      env["rack.input"].rewind

      params = json_params.present? ? JSON.parse(env["rack.input"].read) : {}

      # Manipulate or monitor the parameters as needed
      patcher        = Api::V1::Request::RequestPatcher.new(params, api_version, endpoint)
      patched_params = patcher.apply

      # If you change the parameters and want them to affect the body
      # you'd have to reset the body and update the CONTENT_LENGTH header
      env["rack.input"]     = StringIO.new(patched_params.to_json)
      env["CONTENT_LENGTH"] = patched_params.to_json.bytesize.to_s

      # Update the env with the patched params
      env["rack.request.form_hash"]  = patched_params
      env["rack.request.form_input"] = request.body
    end

    @app.call(env)
  end

  private

  def api_request?(request)
    # This is a simple check. Adjust it according to your application's requirements.
    request.path_info.start_with?("/api/")
  end

  def extract_endpoint(path_info)
    # Assuming path_info looks like "/api/v1/users/..."
    path_info.split("/")[3].to_sym
  end
end
