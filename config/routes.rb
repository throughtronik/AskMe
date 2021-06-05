Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resource :session, only: [:create, :destroy, :new]
  resources :questions, except: [:show, :new, :index]
  resources :hashtags, only: [:show]

  get '/show' => 'users#show'
end
