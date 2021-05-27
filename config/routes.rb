Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resources :sessions, only: [:create, :destroy, :new]
  resources :questions, except: [:show, :new, :index]
  resources :hashtags, only: [:show]

  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/show' => 'users#show'
end
