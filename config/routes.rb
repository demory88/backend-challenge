Rails.application.routes.draw do
  devise_for :users

  authenticated do
    root to: 'users#index', as: :authenticated
  end

  root to: 'pages#index'

  resources :users
  post 'make_friends', to: 'users#make_friends', :as => 'make_friends'
end
