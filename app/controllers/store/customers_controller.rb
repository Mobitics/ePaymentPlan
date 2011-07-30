class Store::CustomersController < ApplicationController
  before_filter :authorized_store

  layout "store"

  def index
    @customers = @store.customers(:include => :payment_plans)
  end

  def show
    @customer = Customer.find params[:id]
  end
end
