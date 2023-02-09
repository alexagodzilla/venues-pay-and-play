Rails.application.routes.draw do
  devise_for :users
  root to: "venues#index"
  resources :venues do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:index, :show, :edit, :update] do
    resources :reviews, only: [:create]
  end
end
