Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks'  }

  resources :users, only: [:index, :show, :edit, :update]

  resources :friend_requests, only: [:index, :create ] do
    member do
      post 'accept'
      delete 'cancel'
      delete 'decline'
    end
  end

  resources :friend_ships, only: [:index, :destroy]


  resources :posts do
    resources :comments, module: :posts
    resources :likes, module: :posts
  end

  resources :comments do
    resources :comments, module: :comments
    resources :likes, module: :comments
  end

  # Defines the root path route ("/")
   root "posts#index"
end
