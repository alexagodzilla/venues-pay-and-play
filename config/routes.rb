Rails.application.routes.draw do
  devise_for :users
  root to: "venues#index"
  resources :venues
  # get "/venues/:id", to: "venues#new"
  # post "/venues/:id", to:
end


# devise_for :users
# root to: "venues#index"
# resources :venues do
# resources :booking, only: [:create, :update]
# resources :review, only: [:create]
# end
