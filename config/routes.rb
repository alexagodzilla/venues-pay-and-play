Rails.application.routes.draw do
  devise_for :users
  root to: "venues#index"
  resources :venues do
    resources :booking, only: [:new, :create]
  end

  resources :booking, only: [:show, :edit, :update] do
    resources :review, only: [:create]
  end
end
