Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root to: 'tops#index'
  # Twitterログイン後のリダイレクト先変更
  get '/notifications/new', to: 'notifications#new', as: :user_root
end
