Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users
  resources :friend_requests, only: [:create, :destroy, :update]
  # Defines the root path route ("/")
   root "users#index"
end
