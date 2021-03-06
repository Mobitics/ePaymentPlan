Epaymentplans::Application.routes.draw do

  mount Resque::Server => "/resque"

  devise_for :users, :controllers => { :sessions => "sessions" }

  match "test/order/purchase" => "orders#edit"
  # match "/order/purchase" => "orders#edit"
  
  match "/order/purchase" => "payment_plans#step1"
  match "/order/show_contract" => "payment_plans#show_contract"
  # match "/order/purchase/step2" => "payment_plans#step2"
  
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
    resources :payment_plans, :only => [:index, :show] do
      resources :payments, :only => [:index] do
        resources :transactions, :only => [:index]
      end
    end
    resources :customers, :only => [:index, :show]
    resources :settings, :only => [:index]
    resources :authorize_nets
    resources :stores do
	member do
    	get 'ecommerce_instructions','complete_ecommerce_instructions'
  	end
	end
  end
  resources :users, :only => [:edit, :show,:update]
  root :to => 'site#home'

  match "/test" => "site#test"
end
