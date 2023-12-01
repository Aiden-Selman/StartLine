Rails.application.routes.draw do
  get 'platforms/index'
  get 'platforms/show'
  get 'genres/index'
  get 'genres/show'
  get 'games/index'
  get 'games/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
