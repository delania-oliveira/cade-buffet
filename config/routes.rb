Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :buffets, only: [:show, :new, :create, :edit, :update] 
  resources :event_types, only: [:show, :new, :create, :edit, :update] do
    resources :base_prices, only: [:new, :create]
  end
  resources :base_prices, only: [:show, :edit, :update]
end
