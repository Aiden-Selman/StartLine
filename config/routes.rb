Rails.application.routes.draw do
  devise_for :users

  # Defines the root path route ("/")
  root "home#index"

  # Games Routes
  resources :games

  # Cart Routes
  resources :cart, only: %i[create destroy]

  # Genres Routes
  resources :genres

  # Platforms Routes
  resources :platforms

  # About Route
  get "about", to: "about#index", as: "about"

  # Contact Route
  get "contact", to: "contact#index", as: "contact"
  # resources :contact

  # Search Route
  get "search/", to: "games#search", as: "search"

  # Checkout routes
  # scope '/checkout' do
  #   get '/', to: 'checkout#index', as: 'checkout'
  #   post 'create', to: 'checkout#create', as: 'checkout_create'
  #   get 'success', to: 'checkout#success', as: 'checkout_success'
  #   get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  # end
  resources :checkout

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
