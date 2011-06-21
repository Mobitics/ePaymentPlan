Epaymentplans::Application.routes.draw do

  get "merchants/index"

  mount Resque::Server => "/resque"

  devise_for :users, :controllers => { :sessions => "sessions" }

  # The priority is based upon order of creation:
  # first created -> highest priority.
  match "test/order/purchase" => "orders#edit"
  # match "/order/purchase" => "orders#edit"
  match "/order/purchase" => "payment_plans#step1"
  match "/order/purchase/step2" => "payment_plans#step2"
  # match "/order/confirmation" => "orders#confirmation"
  match "/order/confirmation" => "payment_plans#confirmation"
  resources :payment_plans, :only => [:create]
  resources :orders
  resources :plans
  
  resources :users do 
    resources :payment_profiles do
      resources :transactions
    end
  end
  
  match "merchant" => "merchant#index"
  namespace :merchant do
    resources :plans, :orders, :payment_plans
  end
  
  root :to => 'site#home'

  match "/test" => "site#test"

end
