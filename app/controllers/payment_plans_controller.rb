class PaymentPlansController < ApplicationController
  def new
    @plans = Plan.all
    @payment_plan = PaymentPlan.new
    
    # This is temporal and for testing purposes. Must be replaced by real received attributes
    # @amount = params[:total_amount] 
    @amount = 200
  end

end
