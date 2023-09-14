# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    before_action :set_api_version

    include ActionPolicy::Controller
    authorize :user, through: :current_user

    verify_authorized except: :index

    protected

    def set_api_version
      return unless request.headers["API-Version"]&.match(/\d{4}-\d{2}-\d{2}/)

      Current.api_version = request.headers["API-Version"]
      Current.user.update(api_version: request.headers["API-Version"]) if Current.user&.api_version.nil?
    end

    def api_version
      Current.api_version
    end
  end
end
