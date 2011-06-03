class PaymentPlansController < ApplicationController
  layout "checkout"

  def new
    @plans = Plan.all
    @payment_plan = PaymentPlan.new(params[:order])
  end

  def create
    @payment_plan = PaymentPlan.new(params[:order])
    if @payment_plan.save
      redirect_to @payment_plan.return_url
    else
      flash[:error] = @payment_plan.errors.full_messages
      render :action => 'new'
    end
  end
end
