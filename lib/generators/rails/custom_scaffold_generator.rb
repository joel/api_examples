# lib/generators/rails/custom_scaffold_generator.rb

require 'rails/generators/rails/scaffold/scaffold_generator'

module Rails
  module Generators
    class CustomScaffoldGenerator < ScaffoldGenerator
      source_root File.expand_path('../templates', __FILE__)

      # Override invoke_all to call our custom methods
      def invoke_all
        super # This runs the default scaffold generation
        invoke_custom_generators
      end

      # Our custom method to run other generators
      def invoke_custom_generators
        # Add calls to your other generators here
        generate "action_policy:policy", name, *attributes
        # ... add more if needed
      end
    end
  end
end
