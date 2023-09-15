# frozen_string_literal: true

require "api/v1/response/users/collapse_name"
require "api/v1/response/users/rename_name"

module Api
  module V1
    module Response
      class ResponsePatcher
        VERSIONS = %w[
          2023-09-15
          2023-09-01
          2023-08-15
          2023-08-01
        ].freeze

        STRATEGIES = {
          users: {
            "2023-09-01" => Users::CollapseName,
            "2023-08-01" => Users::RenameName
            # Add other strategies for users endpoint.
          }
          # Add other endpoints here.
        }.freeze

        def initialize(data, api_version, endpoint)
          @data        = data.dup
          @api_version = api_version
          @endpoint    = endpoint
        end

        def apply
          requested_version_index = VERSIONS.index(api_version)
          patches_to_apply        = VERSIONS[0..requested_version_index]

          patches_to_apply.each do |version|
            strategy = STRATEGIES[endpoint][version]
            next unless strategy

            @data = strategy.apply(data)
          end

          data
        end

        private

        attr_reader :data, :api_version, :endpoint
      end
    end
  end
end
