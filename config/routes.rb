Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users do
    resources :places, only: %i[new create]
  end

  resources :users
  resources :places, only: %i[index show]
end
