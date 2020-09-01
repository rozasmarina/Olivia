Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users

  resources :angels, only: [:new, :create]
end
