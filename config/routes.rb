Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root to: 'notifications#top'
  get  'notifications/set'    => 'notifications#set'
  post 'notifications/set'    => 'notifications#save'
  get  'notifications/finish' => 'notifications#finish'
end
