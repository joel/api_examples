require "rails_helper"

<% module_namespacing do -%>
RSpec.describe <%= controller_class_name %>Controller, <%= type_metatag(:routing) %> do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/<%= ns_table_name %>").to route_to("<%= ns_table_name %>#index")
    end

    it "routes to #show" do
      expect(get: "/<%= ns_table_name %>/1").to route_to("<%= ns_table_name %>#show", id: "#{SecureRandom.uuid}}")
    end

    it "routes to #create" do
      expect(post: "/<%= ns_table_name %>").to route_to("<%= ns_table_name %>#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/<%= ns_table_name %>/1").to route_to("<%= ns_table_name %>#update", id: "#{SecureRandom.uuid}")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/<%= ns_table_name %>/1").to route_to("<%= ns_table_name %>#update", id: "#{SecureRandom.uuid}")
    end

    it "routes to #destroy" do
      expect(delete: "/<%= ns_table_name %>/1").to route_to("<%= ns_table_name %>#destroy", id: "#{SecureRandom.uuid}")
    end
  end
end
<% end -%>
