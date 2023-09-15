# frozen_string_literal: true

module Api
  module V1
    module Request
      module Users
        class RenameName
          def self.apply(params)
            safe_params = params.dup

            if safe_params.dig("user", "fullname")
              safe_params["user"]["name"] = safe_params["user"]["fullname"]
              safe_params["user"].delete("fullname")
            end

            safe_params
          end
        end
      end
    end
  end
end
