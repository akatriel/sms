Rails.application.routes.draw do
  root 'home#index'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/logout' => 'session#destroy'
  resources :users
  resources :messages, only: [:new, :create]
  resources :stocks
  post '/setAsset' => 'assets#setAsset'
  post '/setPayload' => 'assets#setPayload'

end
