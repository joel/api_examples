require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe <%= class_name %>, <%= type_metatag(:model) %> do
  context "with validations" do
    it "is valid with valid attributes" do
      expect(build(:<%= singular_table_name %>)).to be_valid
    end
  end
end
<% end -%>
