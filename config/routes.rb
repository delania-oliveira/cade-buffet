Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :buffets, only: [:show, :new, :create, :edit, :update] do 
    get 'search', on: :collection
  end
  resources :event_types, only: [:show, :new, :create, :edit, :update] do
    resources :base_prices, only: [:new, :create]
    resources :orders, only: [:new, :create]
  end
  resources :base_prices, only: [:show, :edit, :update]
  resources :orders, only: [:index, :show, :update] do
    member do
      post :canceled, :confirmed
    end
  end
  
  namespace :api do
    namespace :v1 do
      resources :buffets, only: [:show, :index] do
        collection do 
          get :search
        end
        resources :event_types, only: [:index] do
          resources :orders do
            collection do 
              post :check_availability
            end
          end
        end
      end
    end
  end
end
