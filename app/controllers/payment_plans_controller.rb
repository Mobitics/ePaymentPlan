class PaymentPlansController < ApplicationController
  def new
    @plans = Plan.all
  end

end
