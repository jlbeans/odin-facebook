Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users
  resources :friend_requests, only: [:index, :create, :destroy ]
  resources :friend_ships, only: [:index, :create, :destroy]
  # Defines the root path route ("/")
   root "users#index"
end
