# frozen_string_literal: true

module Api
  module V1
    module Users
      class RenameName
        def self.apply(data)
          data.each do |user|
            user["fullname"] = user["name"]
            user.delete("name")
          end
        end
      end
    end
  end
end
