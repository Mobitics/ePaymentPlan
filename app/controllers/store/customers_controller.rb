class Store::CustomersController < ApplicationController
  before_filter :authorized_store

  def index
    @payment_plans = @store.payment_plans
    @customers = @payment_plans.collect {|payment_plan| payment_plan.user}
  end

  def show
    @customer = User.find params[:id]
  end
end
