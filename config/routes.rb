Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  
  resources :users, only: :show

  resources :angels, only: [:new, :create]

  #Temporary route for testing - those will be nested in Places
  resources :reviews, only: %i[index new create]
  #Temporary route for testing - those won/t be nested
  resources :reviews, only: %i[show]

  resources :places, only: %i[index]
end
