Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resource :users, only: :show

  #Temporary route for testing - those will be nested in Places
  resources :reviews, only: %i[index new]
  #Temporary route for testing - those won/t be nested
  resources :reviews, only: %i[show]
    resources :responses, only: %i[new create destroy]

  resources :places, only: %i[index]
end
