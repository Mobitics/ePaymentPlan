class Store::TransactionsController < ApplicationController
  before_filter :authorized_store

  def index
    @payment_plan = PaymentPlan.find(params[:payment_plan_id])
    @payment = Payment.find(params[:payment_id])
    @transactions = @payment.transactions

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactions }
    end
  end
end
