Rails.application.routes.draw do

  get '/login',     to: 'sessions#new'

  post '/login',    to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:index, :show, :new, :create]
  resources :education_programs
  resources :groups
end
