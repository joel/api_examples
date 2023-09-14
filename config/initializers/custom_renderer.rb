# frozen_string_literal: true

# config/initializers/custom_renderer.rb

require_relative "../../app/api_versions/api/v1/version_patcher"

ActionController::Renderers.add :api_versioned_json do |json, options|
  json = json.to_json(options) unless json.is_a?(String)

  versioned_data = apply_patches(JSON.parse(json))

  self.content_type ||= Mime[:json]
  self.response_body = versioned_data.to_json
end

def apply_patches(data)
  endpoint = controller_name.to_sym
  patcher = Api::V1::VersionPatcher.new(data, api_version, endpoint)
  patcher.apply
end
