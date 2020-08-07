Rails.application.routes.draw do
  resources :users, only: %i[show create index]
  get '/sign_up', to: 'users#new'
end