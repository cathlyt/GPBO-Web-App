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
  resources :sessions
  resources :users
  resources :customers
  # get 'users/new', to: 'users#new', as: :signup
  # get 'user/edit', to: 'users#edit', as: :edit_current_user
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout


  resources :addresses
  resources :items
  

  

end
