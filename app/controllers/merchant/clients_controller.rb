class Merchant::ClientsController < ApplicationController
  def index
    @payment_plans = PaymentPlan.all
    @clients = @payment_plans.collect {|payment_plan| payment_plan.user}
  end

  def show
    @client = User.find params[:id]
  end

end
