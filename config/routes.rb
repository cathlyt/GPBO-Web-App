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
  resources :users, except:[:show,:destroy]
  # get 'users', to: 'users#index', as: :users
  # post 'users', to: 'users#create', as: :new_user
  # get 'users/:id/edit', to: 'users#edit', as: :edit_user
  # patch 'users/:id', to: 'users#update', as: :user
  
  resources :sessions

  # customers
  resources :customers

  # categories
  resources :categories, except:[:show,:destroy]
  # get 'categories', to: 'categories#index', as: :categories
  # post 'categories', to: 'categories#create', as: :new_category
  # get 'categories/:id/edit', to: 'categories#edit', as: :edit_category
  # patch 'categories/:id', to: 'categories#update', as: :category

  # item_prices
  post 'item_prices', to: 'item_prices#create', as: :item_prices
  get 'item_prices', to: 'item_prices#new', as: :new_item_price

  # orders
  resources :orders
  # get 'orders', to: 'orders#index', as: :orders
  # get 'orders/:id', to: 'orders#show', as: :order
  # post 'orders', to: 'orders#create', as: :new_order

  # cart
  get 'cart', to: 'cart#show', as: :view_cart
  get 'cart/:id/add', to: 'cart#add', as: :add_item
  get 'cart/:id/remove', to: 'cart#remove', as: :remove_item
  get 'cart/empty', to:'cart#empty', as: :empty_cart
  get 'cart/checkout', to: 'cart#checkout', as: :checkout

  # home
  get 'home/search', to:'home#search', as: :search
  get 'home/contact', to:'home#contact', as: :contact
  get 'home/about', to:'home#about', as: :about
  get 'home/privacy', to:'home#privacy', as: :privacy


  
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout


  get 'addresses', to: 'addresses#index', as: :addresses
  get 'addresses/:id', to: 'addresses#show', as: :address
  post 'addresses', to: 'addresses#create', as: :new_address
  get 'addresses/:id/edit', to: 'addresses#edit', as: :edit_address
  patch 'addresses/:id', to: 'addresses#update', as: :update_address
  resources :items
  patch 'items/:id/toggle_active', to: 'items#toggle_active', as: :toggle_active
  patch 'items/:id/toggle_feature', to: 'items#toggle_feature', as: :toggle_feature

  root 'home#index'
  

  

end
