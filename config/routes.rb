Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root to: 'tweets#top'
  resources :tweets, only: [:top, :show, :new, :create]
end
