# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController
      # GET /users
      def index
        @users = User.all

        users_data = @users.as_json(only: %w[id first_name last_name email])

        render api_versioned_json: users_data
      end

      # POST /users
      def create
        @user = User.new(user_params)
        authorize! @user

        if @user.save
          render json: @user, status: :created, location: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :username, :password_digest)
      end
    end
  end
end
