
Rails::Application.routes.draw do

  resources :workitems
  resources :tasks
  resources :processes
  resources :forms
  resources :definitions do
      member do
        get 'launch' 
      end
  end
  # ruote-kit
  #
  match '/_ruote' => RuoteKit::Application
  match '/_ruote/*path' => RuoteKit::Application

  # login / logout
  #
  resources :sessions
  match 'login' => 'sessions#new'
  match 'logout' => 'sessions#destroy'

  # /
  #
  root :to => 'tasks#index'
  
  match ':controller/:action/:id'
  match ':controller/:action'
  match 'tasks/*path/:id' => 'tasks#show'
end

