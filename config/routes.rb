Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root to: 'notifications#top'
  get 'notifications/set'  => 'notifications#set'
  resources :notifications,  only: [:create, :update]

  get 'reports/start'  => 'reports#start'
  resources :reports,  only: [:show, :new, :create]

  get 'images/ogp.png', to: 'images#ogp'
end
