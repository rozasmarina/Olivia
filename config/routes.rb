Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users

  #Temporary route for testing
  resources :reviews, only: %i[index]
end
