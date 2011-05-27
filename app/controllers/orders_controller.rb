class OrdersController < ApplicationController
  def edit
    @order = Order.new(params[:order])
    if @order.save
      flash[:notice] = "Order Succesfully created"
    end
  end
  
  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
      redirect_to @order.return_url
    else
      flash[:error] = @order.errors.full_messages
      render :action => 'edit'
    end
  end
end