Rails.application.routes.draw do
  devise_for :users
  root to: "venues#index"
  resources :venues do
    resources :booking, only: [:new, :create, :update] do
      resources :review, only: [:new, :create]
    end
  end
end
