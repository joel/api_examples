# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController
      # GET /users
      def index
        authorized_collection = User.all

        render json: UserSerializer.new(authorized_collection, is_collection: true).serializable_hash
      end
    end
  end
end
