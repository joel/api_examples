# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController do
  let(:valid_attributes) do
    build(:user).attributes.except("id", "updated_at", "created_at")
  end

  let(:invalid_attributes) do
    valid_attributes.except("first_name")
  end

  let(:valid_session) { {} }

  let(:user) { create(:user) }

  let(:valid_headers) do
    {
      "Authorization" => "Bearer #{JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, 'HS256')}"
    }
  end

  before do
    request.headers["Authorization"] = valid_headers["Authorization"]
  end

  describe "GET #index" do
    it "returns a success response" do
      User.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      user = User.create! valid_attributes
      get :show, params: { id: user.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect do
          post :create, params: { user: valid_attributes }, session: valid_session
        end.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post :create, params: { user: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.location).to eq(user_url(User.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new user" do
        post :create, params: { user: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        build(:user).attributes.except("id", "updated_at", "created_at")
      end

      it "updates the requested user" do
        user = User.create! valid_attributes

        expect do
          put :update, params: { id: user.to_param, user: new_attributes }, session: valid_session
        end.to change { user.reload.first_name }.from(user.first_name).to(new_attributes["first_name"])
      end

      it "renders a JSON response with the user" do
        user = User.create! valid_attributes
        put :update, params: { id: user.to_param, user: new_attributes }, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the user" do
        user, another_user = create_list(:user, 2)
        invalid_attributes = { email: another_user.email }
        put :update, params: { id: user.to_param, user: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect do
        delete :destroy, params: { id: user.to_param }, session: valid_session
      end.to change(User, :count).by(-1)
    end
  end
end
