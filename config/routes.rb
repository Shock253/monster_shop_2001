Rails.application.routes.draw do
  # welcome
  root 'welcome#index'

  # merchants
  resources :merchants do
    # merchant items
    resources :items, only: %i[index new create], controller: :merchant_items
  end

  # items
  resources :items, except: %i[new create] do
    # item_reviews
    resources :reviews, only: %i[new create]
  end

  # item_reviews
  resources :reviews, only: %i[edit update destroy]

  # cart
  post '/cart/:item_id', to: 'cart#add_item'
  get '/cart', to: 'cart#show'
  delete '/cart', to: 'cart#empty'
  delete '/cart/:item_id', to: 'cart#remove_item'
  patch '/cart/:item_id', to: 'cart#add_or_sub'

  # orders
  resources :orders, only: %i[new create show update]

  # register
  get '/register', to: 'register#new'
  post '/register', to: 'register#create'

  # login
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'

  # logout
  delete '/logout', to: 'session#destroy'

  # password_reset
  resource :password, only: %i[edit update]

  namespace :profile, resources: :profile do
    resources :orders, only: %i[index show update]
    get '/', to: 'dashboard#show'
    get '/edit', to: 'dashboard#edit'
    patch '/', to: 'dashboard#update'
  end

  # admin_user
  namespace :admin do
    get '/', to: 'dashboard#show'
    resources :merchants, only: %i[index show update]
    resources :users, only: %i[index show]
  end

  # merchant_user
  namespace :merchant do
    get '/', to: 'dashboard#show'
    get '/orders/:id', to: 'orders#show'
    resources :items, except: %i[show]
    resources :item_orders, only: %i[update]
  end
end
