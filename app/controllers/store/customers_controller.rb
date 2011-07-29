class Store::CustomersController < ApplicationController
  before_filter :authorized_store
  layout "store"
  def index
    @payment_plans = @store.payment_plans
    @customers = @payment_plans.collect {|payment_plan| payment_plan.customer}
  end

  def show
    @customer = Customer.find params[:id]
  end
end
