class Store::StoresController < ApplicationController
  before_filter :authorized_store
  layout "store"
  def index
  	@payment_plans=@store.payment_plans.order("created_at DESC").limit(5)
  end
  def ecommerce_instructions
  end  
  def complete_ecommerce_instructions
  	@store.first_step=true
  	@store.save 
  	redirect_to "/store"
  end
end
