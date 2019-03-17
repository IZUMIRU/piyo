Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root to: 'tweets#top'
  resources :tweets, only: [:top, :show, :new, :create]

  get 'terms_of_service' => 'application#terms_of_service'
  get 'privacy_policy'   => 'application#privacy_policy'
end
