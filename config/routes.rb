Rails.application.routes.draw do
  root 'products#index'

  resources :products, only: [:index]
  get '/products/:path', to: 'products#show', as: 'product'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      resources :orders, only: [:create]
      resources :sessions, only: [:create]
      post '/update-user', to: 'users#update'
    end
  end

  get '/login' => 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  get '/:slug', to: 'users#show', as: 'user'
end
