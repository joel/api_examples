# frozen_string_literal: true

class ApiVersion
  DEFAULT_VERSION = 1
  API_REGEXP = %r{application/vnd.acme.v(?<version>\d+(?<minor>\.\d*)?)\+json}

  def initialize(version)
    @version = version
    @default_version = (@version == DEFAULT_VERSION)
  end

  # Check if an API version will respond to a request
  #
  # == Choose API version
  #
  # - The default API version will respond to the request if no header is given.
  # - The API version 1 will respond to request asking for version 1.
  # - The API version 1 will respond to request asking for version 2,
  #   if the API version 2 endpoint does not exist.
  # - The API version 1 will not respond to request asking for version 0.
  #
  # @param request [ActionDispatch::Request]
  #   the request should have an `Accept` header including the API number asked.
  #   For the version 1: `application/x-api-v1+json`
  #
  # @return [Boolean]
  def matches?(request)
    json_request?(request) && find_version(request)
  end

  private

  def json_request?(request)
    request.headers["Accept"].include?("application/json")
  end

  def find_version(request)
    return @default_version if request.headers["API-Version"].blank?

    match = request.headers["API-Version"].match(API_REGEXP)

    return false unless match

    match[:version].to_f >= @version
  end
end
