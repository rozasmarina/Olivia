Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users do
  end

  resources :users
  resources :places, only: %i[index show new create]
end
