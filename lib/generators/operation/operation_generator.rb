# frozen_string_literal: true

require "generators/generated_field"

class OperationGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def initialize(args, *options)
    super

    parse_fields!
  end

  argument :verb, type: :string, default: "create", desc: "CRUD verb"
  argument :fields, type: :array, default: [], banner: "field:type:requirement"

  class_option :component, type: :string, desc: "Component type"

  attr_accessor :parsed_fields

  def validate_verb_argument
    return if %w[create update delete].include?(verb)

    raise Thor::Error, "Invalid verb: '#{verb}'. It should be either 'create', 'update' or 'delete'."
  end

  def generate_files
    root_file_path = "app/operations/"
    root_file_path = "components/#{options[:component]}/" if options[:component]

    template "base/schema.rb", "#{root_file_path}/operations/#{plural_name}/base/schema.rb"
    template "schema.rb", "#{root_file_path}/operations/#{plural_name}/#{verb}/schema.rb"
  end

  private

  # Convert fields array into GeneratedField objects.
  def parse_fields!
    self.parsed_fields = fields.map do |field|
      Generators::GeneratedField.parse(field)
    end
  end
end
