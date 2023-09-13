# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/api/v1/users" do
  before { travel_to Date.new(2004, 11, 24) }

  context "with an authenticated user" do
    let(:user) do
      create(
        :user,
        id: "01H7YRXCXK0M10W3RC045GW001",
        name: "John",
        email: "teressa@mullerbuckridge.us",
        username: "dia.hyatt"
      )
    end

    let(:valid_headers) do
      {
        "Authorization" => "Bearer #{JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, 'HS256')}",
        "Accept" => "application/json",
        "API-Version" => "application/vnd.acme.v1+json"
      }
    end

    context "with user" do
      describe "GET /index" do
        before { get api_v1_users_url, headers: valid_headers, as: :json }

        it "renders a successful response" do
          expect(response).to be_successful
        end

        it "renders a valid JSON" do
          expect(JSON.parse(response.body)).to eql( # rubocop:disable Rails/ResponseParsedBody
            [
              {
                "id" => "01H7YRXCXK0M10W3RC045GW001",
                "name" => "John",
                "email" => "teressa@mullerbuckridge.us"
              }
            ]
          )
        end

        it "renders Response Header API Versio" do
          expect(response.headers["X-Acme-Api-Version"]).to be(1.0)
        end
      end
    end
  end
end
