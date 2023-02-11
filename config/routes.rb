Rails.application.routes.draw do
  devise_for :users
  root to: "venues#index"
  resources :venues do
    resources :bookings, only: %i[new create]
  end
  resources :bookings, only: %i[index show edit update] do
    resources :reviews, only: %i[create edit update]
  end
  resources :reviews, only: %i[destroy]
end
