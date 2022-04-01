Rails.application.routes.draw do
  # API routing
  scope module: 'api', defaults: {format: 'json'} do
    namespace :v1 do
      # Only need two routes for the API
      get 'orders', to: 'orders#index'
      get 'customers/:id', to: 'customers#show'
    end
  end

  get 'home', to: 'home#index', as: :home

  # users
  get 'users', to: 'users#index', as: :users
  post 'users', to: 'users#create', as: :new_user
  get 'users/:id/edit', to: 'users#edit', as: :edit_user
  patch 'users/:id', to: 'users#update', as: :user
  
  resources :sessions
  # resources :users
  resources :customers

  
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout


  resources :addresses
  resources :items
  

  

end
