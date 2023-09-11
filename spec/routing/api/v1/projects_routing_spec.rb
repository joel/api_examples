# frozen_string_literal: true

require "rails_helper"

module Api
  module V1
    RSpec.describe ProjectsController do
      before do
        allow_any_instance_of(ApiVersion).to receive(:matches?).and_return(true)
      end

      describe "routing" do
        it "routes to #index" do
          expect(get: "/api/projects").to route_to("api/v1/projects#index")
        end

        it "routes to #show" do
          expect(get: "/api/projects/1").to route_to("api/v1/projects#show", id: "1")
        end

        it "routes to #create" do
          expect(post: "/api/projects").to route_to("api/v1/projects#create")
        end

        it "routes to #update via PUT" do
          expect(put: "/api/projects/1").to route_to("api/v1/projects#update", id: "1")
        end

        it "routes to #update via PATCH" do
          expect(patch: "/api/projects/1").to route_to("api/v1/projects#update", id: "1")
        end

        it "routes to #destroy" do
          expect(delete: "/api/projects/1").to route_to("api/v1/projects#destroy", id: "1")
        end
      end
    end
  end
end
