require 'resque/server'

Brubeck::Application.routes.draw do
  devise_for :users

  resources :spaces, :properties
  resources :traits, :theorems, except: [:delete]

  get 'unproven', to: 'application#unproven'

  get 'search', to: 'formulae#search'

  authenticate :user, lambda { |u| u.admin? } do
    mount Resque::Server.new, at: '/resque', as: 'resque'
  end

  root to: 'application#root'
end
