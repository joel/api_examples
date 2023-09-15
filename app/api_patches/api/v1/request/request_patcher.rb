# frozen_string_literal: true

require "api/v1/request/users/split_name"
require "api/v1/request/users/rename_name"

module Api
  module V1
    module Request
      class RequestPatcher
        attr_reader :params, :api_version, :endpoint

        VERSIONS = %w[
          2023-09-15
          2023-09-01
          2023-08-15
          2023-08-01
        ].freeze

        STRATEGIES = {
          users: {
            "2023-09-01" => Users::SplitName,
            "2023-08-01" => Users::RenameName
            # Add other strategies for the users endpoint.
          }
          # Add other endpoints here.
        }.freeze

        def initialize(params, api_version, endpoint)
          @params      = params.dup
          @api_version = api_version
          @endpoint    = endpoint
        end

        def apply
          return @params unless api_version && STRATEGIES[endpoint]

          requested_version_index = VERSIONS.index(api_version)
          patches_to_apply        = VERSIONS[0..requested_version_index]

          patches_to_apply.reverse_each do |version|
            strategy = STRATEGIES[endpoint][version]
            next unless strategy

            @params = strategy.apply(@params)
          end

          @params
        end
      end
    end
  end
end
