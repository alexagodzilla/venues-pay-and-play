Rails.application.routes.draw do
  devise_for :users
  root to: "venues#index"
  get "profile", to: "pages#profile", as: :profile

  resources :venues do
    resources :bookings, only: %i[new create]
  end

  resources :bookings, only: %i[index show edit update destroy] do
    resources :reviews, only: %i[create]
  end

  resources :reviews, only: %i[destroy]
end
