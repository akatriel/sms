Rails.application.routes.draw do
  root 'home#index'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/logout' => 'session#destroy'
  resources :users
  resources :messages, only: [:new, :create]
  resources :stocks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
