# frozen_string_literal: true

module Generators
  class GeneratedField
    DEFAULT_TYPES = %w[
      integer
      string
      text
      time
    ].freeze
    private_constant :DEFAULT_TYPES

    DEFAULT_REQUIREMENTS = %w[
      required
      optional
    ].freeze
    private_constant :DEFAULT_REQUIREMENTS

    attr_accessor :name, :type, :requirement, :options

    class << self
      def parse(field)
        name, type, requirement, raw_options = field.split(":", 4)

        field_options = raw_options ? eval(raw_options) : {}

        raise Error, "Could not generate field '#{name}' with unknown type '#{type}'." if invalid_type?(type)

        raise Error, "Could not generate field '#{name}' with unknown requirement '#{requirement}'." if invalid_requirement?(requirement)

        new(name, type, requirement, field_options)
      end

      def invalid_type?(type)
        DEFAULT_TYPES.exclude?(type.to_s)
      end

      def invalid_requirement?(requirement)
        DEFAULT_REQUIREMENTS.exclude?(requirement.to_s)
      end
    end

    def initialize(name, type = nil, requirement = nil, options = {})
      @name           = name
      @type           = type || :string
      @requirement    = requirement || :optional
      @options        = options
    end
  end
end
