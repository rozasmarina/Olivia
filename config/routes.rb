Rails.application.routes.draw do
  root to: 'places#index'

  devise_for :users do
  end

  resource :users, only: :show

  resources :angels, only: [:new, :create, :show, :edit, :update, :destroy]

  # Temporary route for testing - those will be nested in Places
  resources :places, only: :show do
    resources :reviews, only: %i[new, create]
  end
  # Temporary route to reviews index - discuss if it should be nested or even exist
  resources :reviews, only: :index
  # Temporary route for testing - those won/t be nested
  resources :reviews, only: %i[show] do
    resources :responses, only: %i[new create destroy]
  end
  
  resources :places, except: %i[destroy, show]
end
