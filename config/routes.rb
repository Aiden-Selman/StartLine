Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "games#index"

  # Games Routes
  resources :games

  # Genres Routes
  resources :genres

  # Platforms Routes
  resources :platforms

  # About Route
  get "about", to: "about#index", as: "about"

  # Contact Route
  get "contact/", to: "contact#index", as: "contact"

  # Search Route
  get "search/", to: "games#search", as: "search"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
