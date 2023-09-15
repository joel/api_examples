# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  resources :users

  post "/login", to: "authentication#create"

  # constraints subdomain: "api" do
  namespace :api do
    namespace :v2 do
      resources :users, only: :index
    end
    namespace :v1 do
      resources :users, only: %i[index create]
      resources :projects
    end
  end
  # end
end
