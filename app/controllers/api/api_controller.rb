# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    before_action :api_version

    include ActionPolicy::Controller
    authorize :user, through: :current_user

    verify_authorized except: :index

    protected

    def api_version
      return unless request.headers["API-Version"]&.match(%r{application/vnd.acme.v(?<version>\d+(?<minor>\.\d*)?)\+json})

      Current.api_version = Regexp.last_match[:version].to_f
    end
  end
end
