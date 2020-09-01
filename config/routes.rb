Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users

  #Temporary route for testing - those will be nested in Places
  resources :reviews, only: %i[index new create]
  #Temporary route for testing - those won/t be nested
  resources :reviews, only: %i[show]
end
