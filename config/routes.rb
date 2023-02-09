Rails.application.routes.draw do
  devise_for :users
  root to: "venues#index"
  resources :venues do
    resources :booking, only: [:new, :create, :update]
    resources :review, only: [:create]
  end
end
