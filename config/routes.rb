Rails.application.routes.draw do
  root to: 'tops#index'
  get '/auth/:provider/callback' => 'sessions#create'
end
