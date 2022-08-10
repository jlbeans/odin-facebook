Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users

  resources :friend_requests, only: [:index, :create, :destroy ]
  resources :friend_ships, only: [:index, :create, :destroy]

  resources :posts do
    resources :comments, module: :posts
  end

  resources :comments do
    resources :comments, module: :comments
  end
  # Defines the root path route ("/")
   root "posts#index"
end
