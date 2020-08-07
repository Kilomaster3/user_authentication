Rails.application.routes.draw do
  resources :users
  get '/sign_up', to: 'users#new'
end