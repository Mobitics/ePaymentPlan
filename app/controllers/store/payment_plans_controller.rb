class Store::PaymentPlansController < ApplicationController
  before_filter :authorized_store

  def index
    @payment_plans = @store.payment_plans

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payment_plans }
    end
  end

  def show
    @payment_plan = @store.payment_plans.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment_plan }
    end
  end
end
