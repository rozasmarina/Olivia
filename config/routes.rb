Rails.application.routes.draw do
  mount Notifications::Engine => "/notifications"
  root to: 'pages#home'
  get '/near_me', to: 'pages#near_me', as: "near_me"
  get '/top_places', to: 'pages#top_places', as: "top_places"
  post 'users/update_position', to: 'users#update_position', as: :update_position

  devise_for :users do
  end

  # menu routes
  get '/together', to: 'pages#together', as: :together
  get '/community', to: 'pages#community', as: :community
  get '/ollivia', to: 'pages#ollivia', as: :ollivia
  get '/emergency', to: 'pages#emergency', as: :emergency
  get '/intro', to: 'pages#intro', as: :intro

  # Messages
  # get '/send_message', to: 'twilio#send_message', as: :send_message
  get '/message_angels', to: 'twilio#message_angels', as: :message_angels
  get '/message_near_users', to: 'twilio#message_near_users', as: :message_near_users
  get '/message_authorities', to: 'twilio#message_authorities', as: :message_authorities
  get '/demo_notification', to: 'twilio#demo_notification', as: :demo_notification
  

  resource :users, only: :show
  patch 'users/message_update', to: 'users#update_messages', as: :message_update

  resources :angels, except: %i[index show]

  resources :reviews, only: %i[show] do
    resources :responses, only: %i[new create destroy]
  end

  resources :reviews, only: %i[edit update]
  get 'reviews/:id/disable', to: 'reviews#disable', as: :disable_review
  get 'reviews/:id/satisfy', to: 'reviews#satisfy', as: :satisfy_review
  # patch 'reviews/:id', to: 'reviews#disabled' -> will use update to change

  # Route to add owner to places
  patch 'places/add_owner', to: 'places#add_owner', as: :add_owner

  resources :places, except: %i[destroy show]

  resources :places, only: :show do
    resources :reviews, only: %i[new create]
  end

  # Redirect to home when the route does not exist
  # get '*path' => redirect('/')
end
