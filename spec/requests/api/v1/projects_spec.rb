# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/api/v1/projects" do
  let(:user)  { create(:user) }
  let(:token) { JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, "HS256") }

  let(:valid_headers) do
    {
      "Authorization" => "Bearer #{token}",
      "Accept" => "application/json",
      "API-Version" => "2023-09-13"
    }
  end

  let(:valid_attributes) do
    attributes_for(:project)
  end

  let(:invalid_attributes) do
    valid_attributes.merge({ name: "" })
  end

  context "with project" do
    let(:id) { SecureRandom.uuid }
    let(:project) { create(:project, id:, user:) }

    before { project }

    describe "GET /index" do
      subject(:api_call) do
        get api_v1_projects_url, headers: valid_headers, as: :json
      end

      it "renders a successful response" do
        api_call
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      subject(:api_call) do
        get api_v1_project_url(project), headers: valid_headers, as: :json
      end

      it "renders a successful response" do
        api_call
        expect(response).to be_successful
      end
    end

    describe "PATCH /update" do
      subject(:api_call) do
        patch api_v1_project_url(project), params: attributes, headers: valid_headers, as: :json
      end

      let(:new_attributes) do
        {
          name: "New Name"
        }
      end

      context "with valid parameters" do
        let(:attributes) { new_attributes }

        it "updates the requested project" do
          expect do
            api_call
          end.to change {
            project.reload.name
          }.to(new_attributes[:name])
        end

        it "renders a JSON response with the new project" do
          api_call
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to match(a_string_including("application/json; charset=utf-8"))
        end
      end

      context "with invalid parameters" do
        let(:attributes) { invalid_attributes }

        it "renders a response with 422 status (i.e. to display the 'edit' template)" do
          api_call
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe "DELETE /destroy" do
      subject(:api_call) do
        delete api_v1_project_url(project), headers: valid_headers, as: :json
      end

      it "destroys the requested project" do
        expect do
          api_call
        end.to change(Project, :count).by(-1)
      end
    end
  end

  context "without project" do
    describe "POST /create" do
      subject(:api_call) do
        post api_v1_projects_url, params: { project: attributes }, headers: valid_headers, as: :json
      end

      context "with valid parameters" do
        let(:attributes) { valid_attributes }

        it "creates a new Project" do
          expect do
            api_call
          end.to change(Project, :count).by(1)
        end
      end

      context "with invalid parameters" do
        let(:attributes) { invalid_attributes }

        it "does not create a new Project" do
          expect do
            api_call
          end.not_to change(Project, :count)
        end

        it "renders a response with 422 status (i.e. to display the 'new' template)" do
          api_call
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
