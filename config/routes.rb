require 'resque/server'

Brubeck::Application.routes.draw do
  resources :examples

  devise_for :users

  resources :spaces, :properties, :traits, except: [:delete]
  resources :theorems, only: [:index, :show]

  get 'search', to: 'formulae#search'

  authenticate :user, lambda { |u| u.admin? } do
    mount Resque::Server.new, at: '/resque', as: 'resque'
  end

  root to: 'application#root'
end
