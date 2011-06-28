Epaymentplans::Application.routes.draw do

  mount Resque::Server => "/resque"

  devise_for :users, :controllers => { :sessions => "sessions" }

  match "test/order/purchase" => "orders#edit"
  # match "/order/purchase" => "orders#edit"
  match "/order/purchase" => "payment_plans#step1"
  match "/order/purchase/step2" => "payment_plans#step2"
  # match "/order/confirmation" => "orders#confirmation"
  match "/order/confirmation" => "payment_plans#confirmation"

  resources :payment_plans, :only => [:create]
  # resources :orders
  # resources :plans
  
  # resources :users do 
  #   resources :payment_profiles do
  #     resources :transactions
  #   end
  # end
  
  namespace :store do
    root :to => "stores#index"
    # resources :orders
    resources :plans
    resources :payment_plans, :only => [:index, :show]
    resources :customers, :only => [:index, :show]
    resources :settings, :only => [:index]
    resources :authorize_nets
  end
  
  root :to => 'site#home'

  match "/test" => "site#test"
end
