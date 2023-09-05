# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { ArUlid.configuration.generator.generate_id }
    name { FFaker::Name.unique.name }
    email { FFaker::Internet.unique.email }
    username { FFaker::Internet.unique.user_name }
    password { FFaker::Internet.password }
    password_confirmation { password }
  end
end
