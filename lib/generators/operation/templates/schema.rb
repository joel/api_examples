# frozen_string_literal: true

# Sanitizes, coerces and type-checks input data

module <%= plural_name.capitalize %>
  module <%= verb.capitalize %>
    Schema = Dry::Schema.Params do
      instance_exec(&Base::Schema::COMMON_FIELDS)

      <%- @parsed_fields.each do |field| -%>
      <%= field.requirement %>(:<%= field.name %>).filled(:<%= field.type %>)
      <%- end -%>
    end
  end
end