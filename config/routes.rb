Rails.application.routes.draw do
  root 'welcome#index'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create', as: 'register'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  # resources :merchants do
  #   resources :items, only: [:index, :new, :create, :update]
  # end

  get '/merchants/:merchant_id/items', to: 'items#index', as: 'merchant_items'
  post '/merchants/:merchant_id/items', to: 'items#create'
  get '/merchants/:merchant_id/items/new', to: 'items#new'
  patch '/merchants/:merchant_id/items/:id', to: 'items#update'
  # post '/merchants/:merchant_id/items/:id', to: 'items#update'

  get '/merchants', to: 'merchants#index'
  post '/merchants', to: 'merchants#create'
  get '/merchants/new', to: 'merchants#new'
  get 'merchants/:id/edit', to: 'merchants#edit'
  get 'merchants/:id', to: 'merchants#show'
  patch 'merchants/:id', to: 'merchants#update'
  delete 'merchants/:id', to: 'merchants#destroy'
  #
  # resources :items, only: [:index, :show] do
  #   resources :reviews, only: [:new, :create]
  # end
  post '/items/:item_id/reviews', to: 'reviews#create', as: 'item_reviews'
  get '/items/:item_id/reviews/new', to: 'reviews#new', as: 'new_item_review'

  get '/items', to: 'items#index', as: 'items'
  get '/items/:id', to: 'items#show', as: 'item'

  # resources :reviews, only: [:edit, :update, :destroy]
  get '/reviews/:id/edit', to: 'reviews#edit', as: 'edit_review'
  patch '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy', as: 'review'

  get '/cart', to: 'cart#show', as: 'cart'
	post '/cart/:item_id', to: 'cart#add_item', as: 'add_to_cart'
  delete '/cart', to: 'cart#empty', as: 'empty_cart'
  patch '/cart/:change/:item_id', to: 'cart#update_quantity', as: 'update_cart'
  delete '/cart/:item_id', to: 'cart#remove_item', as: 'remove_item'

  get '/register/new', to: 'users#new', as: 'new_user'

  # resources :users, only: [:create, :show, :edit, :update] do
  # 	resources :orders, only: [:create, :show]
  # end

  post '/users/:user_id/orders', to: 'orders#create', as: 'user_orders'
  get '/users/:user_id/orders/:id', to: 'orders#show', as: 'user_order'
  post '/users', to: 'users#create', as: 'users'
  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  get '/users/id', to: 'users#show', as: 'user'
  patch '/users/:id', to: 'users#update'



  get '/profile', to: 'users#show', as: :profile
  get '/profile/orders', to: 'orders#index', as: :profile_orders
  get '/profile/order/:id', to: 'orders#show', as: :profile_order
  patch '/profile/order/:id', to: 'orders#update', as: :cancel_order
  get '/edit_password', to: 'users#edit_password', as: :edit_password
  patch '/profile', to: 'users#update_password', as: :update_password
  get '/admin', to: 'admin/users#dashboard', as: :admin_dashboard
  get '/merchant', to: 'merchant_admins/users#dashboard', as: :merchant_dashboard

	patch "/merchant_admins/items/:merchant_id/:item_id", to: "merchant_admins/items#activate", as: :activate_items

  namespace :merchant_admins do
    resources :items, only: [:new, :create, :edit, :update, :destroy]
		resources :users
  end

  namespace :merchant_admins do
    resources :items, only: [:update, :new, :create]
    resources :orders, only: [:show, :update]
  end
  # post 'merchant_admins/items', to: 'merchant_admins/items#create'




  patch '/admin/orders/:id', to: 'admin/orders#update', as: :ship_order

  namespace :admin do
    resources :users
  end


	get '/merchant/items', to: 'merchant_admins/items#index', as: :only_merchants_items

  get '/admin/merchants/:id', to: 'admin/merchants#dashboard', as: :admin_merchant_dashboard
  patch '/admin/merchant/:id/disable', to: 'admin/merchants#disable', as: :admin_merchant_disable
  patch '/admin/merchant/:id/enable', to: 'admin/merchants#enable', as: :admin_merchant_enable
end
