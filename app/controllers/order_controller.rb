class OrderController < ApplicationController
  def new
    @order = Order.new(params[:order_info])
  end
  
  def create
  end
end