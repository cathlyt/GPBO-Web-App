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

  # customers
  get 'customers', to: 'customers#index', as: :customers
  post 'customers', to: 'customers#create', as: :new_customer
  get 'customers/:id', to: 'customers#show', as: :customer
  get 'customers/:id/edit', to: 'customers#edit', as: :edit_customer
  patch 'customers/:id', to: 'customers#update', as: :update_customer

  # categories
  get 'categories', to: 'categories#index', as: :categories
  post 'categories', to: 'categories#create', as: :new_category
  get 'categories/:id/edit', to: 'categories#edit', as: :edit_category
  patch 'categories/:id', to: 'categories#update', as: :category

  
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout


  # resources :addresses
  get 'addresses', to: 'addresses#index', as: :addresses
  get 'addresses/:id', to: 'addresses#show', as: :address
  post 'addresses', to: 'addresses#create', as: :new_address
  get 'addresses/:id/edit', to: 'addresses#edit', as: :edit_address
  patch 'addresses/:id', to: 'addresses#update', as: :update_address
  resources :items

  root 'home#index'
  

  

end
