Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
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
