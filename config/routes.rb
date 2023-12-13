Rails.application.routes.draw do
  devise_for :users
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
  resources :users, only: [ :index, :show ] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:new, :create]
    end
  end

  root "users#index"

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
