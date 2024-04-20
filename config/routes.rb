Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :buffets, only: [:show, :new, :create, :edit, :update] 
end
