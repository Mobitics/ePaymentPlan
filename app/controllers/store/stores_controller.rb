class Store::StoresController < ApplicationController
  before_filter :authorized_store
  layout "store"
  def index
  	@payment_plans=@store.payment_plans.order("created_at DESC").limit(5)
  end
end
