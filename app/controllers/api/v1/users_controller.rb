# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController
      def index
        @users = User.all

        users_data = @users.as_json(only: %w[id first_name last_name email])

        render api_versioned_json: users_data
      end
    end
  end
end
