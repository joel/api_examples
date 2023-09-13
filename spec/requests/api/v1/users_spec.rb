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
        "API-Version" => "2023-09-13"
      }
    end

    before { user }

    context "with user" do
      describe "GET /index" do
        subject(:api_call) { get api_v1_users_url, headers: valid_headers, as: :json }

        it "sets the API version on the first call" do
          expect do
            api_call
          end.to change {
            user.reload.api_version
          }.from(nil).to("2023-09-13")

          expect do
            api_call
          end.not_to(change do
            user.reload.api_version
          end)
        end

        it "renders a successful response" do
          api_call
          expect(response).to be_successful
        end

        it "renders a valid JSON" do
          api_call
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

        it "renders Response Header API Version" do
          api_call
          expect(response.headers["X-Acme-Api-Version"]).to be("2023-09-13")
        end
      end
    end
  end
end
