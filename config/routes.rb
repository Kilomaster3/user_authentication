Rails.application.routes.draw do
  root 'static_pages#home'
  resources :users, only: %i[show create index]
  resource :sessions, only: %i[create destroy]
  get '/sign_up', to: 'users#new'
  get '/login',   to: 'sessions#new'
  get '/profile', to: 'sessions#new'
  post '/profile', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end