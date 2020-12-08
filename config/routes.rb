Rails.application.routes.draw do
  devise_for :users

  authenticated do
    root to: 'users#home', as: :authenticated
  end

  root to: 'pages#index'
end
