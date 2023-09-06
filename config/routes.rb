# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  resources :users

  post "/login", to: "authentication#create"

  # constraints subdomain: "api" do
  namespace :api do
    scope module: :v2, constraints: ApiVersion.new(2) do
      resources :users, only: :index
    end
    scope module: :v1, constraints: ApiVersion.new(1) do
      resources :users, only: :index
    end
  end
  # end
end
