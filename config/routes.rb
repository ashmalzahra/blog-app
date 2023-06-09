Rails.application.routes.draw do
  devise_for :users

  post :auth, to: 'authentication#create'

  resources :users, only: [] do
    resources :posts, only: [:index] do
      resources :comments, only: [:index, :create]
    end
  end

  resources :users, only: [:index, :show] do
    resources :posts, except: [:update, :edit] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end

  root 'users#index'
end
