Rails.application.routes.draw do
  get 'venues/index'
  get 'venues/show'
  devise_for :users
  root to: "venues#index"
end
