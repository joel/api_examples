require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe "/<%= name.underscore.pluralize %>", <%= type_metatag(:request) %> do
  let(:user)  { create(:user) }
  let(:token) { JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, 'HS256') }

  let(:valid_headers) do
    {
      "Authorization" => "Bearer #{token}",
      "Content-Type" => "application/json",
      "Accept" => "application/x-api-v2+json"
    }
  end

  let(:valid_attributes) {
    attributes_for(:<%= singular_table_name %>)
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
    # valid_attributes.merge({ name: "" })
  }

  context "with <%= singular_table_name %>" do
    let(:id) { SecureRandom.uuid }
    let(:<%= singular_table_name %>) { create(:<%= singular_table_name %>, id:) }

    before { <%= singular_table_name %> }

    describe "GET /index" do
      subject(:api_call) do
        get <%= index_helper %>_url, headers: valid_headers, as: :json
      end

      it "renders a successful response" do
        api_call
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      subject(:api_call) do
        get <%= show_helper %>, headers: valid_headers, as: :json
      end

      it "renders a successful response" do
        api_call
        expect(response).to be_successful
      end
    end

    describe "PATCH /update" do
      subject(:api_call) do
        patch <%= show_helper %>, params: attributes, headers: valid_headers, as: :json
      end

      let(:new_attributes) {
        {
          name: "New Name"
        }
      }

      context "with valid parameters" do
        let(:attributes) { new_attributes }

        it "updates the requested <%= singular_table_name %>" do
          expect {
            api_call
          }.to change {
            <%= file_name %>.reload.name
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
        delete <%= show_helper %>, headers: valid_headers, as: :json
      end

      it "destroys the requested <%= singular_table_name %>" do
        expect {
          api_call
        }.to change(<%= class_name %>, :count).by(-1)
      end
    end

  end

  context "without <%= singular_table_name %>" do
    describe "POST /create" do
      subject(:api_call) do
        post <%= index_helper %>_url, params: { <%= singular_table_name %>: attributes }, headers: valid_headers, as: :json
      end

      context "with valid parameters" do
        let(:attributes) { valid_attributes }

        it "creates a new <%= class_name %>" do
          expect {
            api_call
          }.to change(<%= class_name %>, :count).by(1)
        end
      end

      context "with invalid parameters" do
        let(:attributes) { invalid_attributes }

        it "does not create a new <%= class_name %>" do
          expect {
            api_call
          }.to change(<%= class_name %>, :count).by(0)
        end

        it "renders a response with 422 status (i.e. to display the 'new' template)" do
          api_call
          expect(response).to have_http_status(:unprocessable_entity)
        end

      end
    end
  end
end
<% end -%>
