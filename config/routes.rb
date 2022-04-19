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

  # sessions
  resources :sessions

  # customers
  resources :customers

  # categories
  resources :categories, except:[:show,:destroy]

  # item_prices
  post 'item_prices', to: 'item_prices#create', as: :item_prices
  get 'item_prices', to: 'item_prices#new', as: :new_item_price

  # orders
  resources :orders

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

  resources :addresses,  except:[:destroy]


  resources :items
  patch 'items/:id/toggle_active', to: 'items#toggle_active', as: :toggle_active
  patch 'items/:id/toggle_feature', to: 'items#toggle_feature', as: :toggle_feature

  root 'home#index'
  

  

end
