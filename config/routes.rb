Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resources :session, only: [:create, :destroy, :new]
  resources :questions, except: [:show, :new, :index]
  resources :hashtags, only: [:show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/show' => 'users#show'
end
