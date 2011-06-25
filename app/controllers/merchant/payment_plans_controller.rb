class Merchant::PaymentPlansController < ApplicationController
  before_filter :merchant_required
  def index
    @payment_plans = PaymentPlan.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payment_plans }
    end
  end

  def show
    @payment_plan = PaymentPlan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment_plan }
    end
  end

end
