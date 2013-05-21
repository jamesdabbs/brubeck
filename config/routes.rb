require 'resque/server'

Brubeck::Application.routes.draw do
  devise_for :users

  resources :spaces do
    get :related
    get :proofs
  end

  resources :properties do
    get :related
  end
  
  resources :traits, except: [:delete] do
    get :related
    collection { get :available }
  end
  
  resources :theorems, except: [:delete] do
    get :related
  end

  resources :users, only: [:show]

  get 'unproven', to: 'application#unproven'

  get 'search',  to: 'formulae#search'
  get 'suggest', to: 'formulae#suggest'

  authenticate :user, lambda { |u| u.admin? } do
    mount Resque::Server.new, at: '/resque', as: 'resque'
  end

  get 'help', to: 'application#help'
  root to: 'application#root'
end
