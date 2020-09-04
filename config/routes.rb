Rails.application.routes.draw do
  root to: 'places#index'
  get '/home', to: 'pages#home'
  devise_for :users do
  end

  # menu rotes
  get '/VamosJuntas', to: 'pages#together', as: :together
  get '/ReportarExperiencia', to: 'pages#report', as: :report
  get '/Comunidade', to: 'pages#community', as: :community
  get '/Empresa', to: 'pages#company', as: :company

  resource :users, only: :show

  resources :angels, except: :index

  # Temporary route for testing - those won/t be nested
  resources :reviews, only: %i[show] do
    resources :responses, only: %i[new create destroy]
  end

  # Temporary route to reviews index - discuss if it should be nested or even exist
  resources :reviews, only: %i[index edit update]
  get 'reviews/:id/disable', to: 'reviews#disable', as: :disable_review
  get 'reviews/:id/satisfy', to: 'reviews#satisfy', as: :satisfy_review
  # patch 'reviews/:id', to: 'reviews#disabled' -> will use update to change

  resources :places, except: %i[destroy show]

  # Temporary route for testing - those will be nested in Places
  resources :places, only: :show do
    resources :reviews, only: %i[new create]
  end

end
