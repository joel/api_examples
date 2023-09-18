# frozen_string_literal: true

# config/api_version.rb

module ApiVersion
  VERSIONS = %w[
    2023-09-15
    2023-09-01
    2023-08-15
    2023-08-01
  ].freeze

  def self.current_version
    VERSIONS.first
  end
end
