Rails.application.routes.draw do
  root "games#index"

  resources :games
  resources :genres
  resources :platforms
  # resources :abouts
  # resources :contact
  get 'about/index'
  get 'contact/index'
  # get 'platforms/index'
  # get 'platforms/show'
  # get 'genres/index'
  # get 'genres/show'
  # get 'games/index'
  # get 'games/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
