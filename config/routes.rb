Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users 
  # Defines the root path route ("/")
   root "users#index"
end
