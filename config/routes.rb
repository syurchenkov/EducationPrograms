Rails.application.routes.draw do

  get '/login',     to: 'sessions#new'

  post '/login',    to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:index, :show, :new, :create] do 
    member do 
      post '/add_ep', to: 'users#add_ep'
    end
  end
  resources :education_programs
  resources :groups do 
    member do 
      post '/add_ep', to: 'groups#add_ep'
    end
  end
  resources :user_groups, only: [:create, :destroy]
end
