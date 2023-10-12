# frozen_string_literal: true

# Sanitizes, coerces and type-checks input data

module <%= plural_name.capitalize %>
  module <%= verb.capitalize %>
    class Schema < Dry::Schema::Params

      COMMON_FIELDS = proc do
        config.types = TypeContainer

        # Common fields
      end
    end
  end
end
