# frozen_string_literal: true

module Api
  module V1
    module Request
      module Users
        class SplitName
          def self.apply(params)
            safe_params = params.dup

            if safe_params.dig("user", "name")
              first_name, last_name = safe_params["user"]["name"].split(" ", 2)
              safe_params["user"]["first_name"] = first_name
              safe_params["user"]["last_name"]  = last_name
              safe_params["user"].delete("name")
            end

            safe_params
          end
        end
      end
    end
  end
end
