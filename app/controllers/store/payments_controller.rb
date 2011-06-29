class Store::PaymentsController < ApplicationController
  before_filter :authorized_store

  def index
    @payment_plan = PaymentPlan.find(params[:payment_plan_id])
    @payments = @payment_plan.payments

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payments }
    end
  end
end
