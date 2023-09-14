# frozen_string_literal: true

module Api
  module V1
    module Users
      class CollapseName
        def self.apply(data)
          data.each do |user|
            user["name"] = "#{user['first_name']} #{user['last_name']}"
            user.delete("first_name")
            user.delete("last_name")
          end
        end
      end
    end
  end
end
