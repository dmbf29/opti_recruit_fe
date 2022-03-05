Rails.application.routes.draw do
  devise_for :users
  root to: 'players#index'
  resources :players, only: [:index, :show] do
    collection do
      get :search
    end
  end
  resources :teams, only: [] do
    collection do
      get :search
    end
  end
end
