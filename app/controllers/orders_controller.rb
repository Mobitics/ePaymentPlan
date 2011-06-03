class OrdersController < ApplicationController

  # {
  #   "utf8"=>"✓",
  #   "authenticity_token"=>"pTiuFvFkm5d7unlGA7+hUpknP3MOD3Nwn7N855wW60s=",
  #   "commit"=>"Make Payment",
  #   "order"=>{
  #     "num"=>"1000",
  #     "amount"=>"50.0",
  #     "first_name"=>"Cody",
  #     "last_name"=>"Fauser",
  #     "email"=>"codyfauser@gmail.com",
  #     "phone"=>"(555)555-5555",
  #     "country"=>"CA",
  #     "city"=>"Ottawa",
  #     "address1"=>"21 Snowy Brook Lane",
  #     "address2"=>"Apt. 36",
  #     "state"=>"ON",
  #     "zip"=>"K1J1E5",
  #     "shipping"=>"0.00",
  #     "tax"=>"0.00",
  #     "notify_url"=>"http://tiendafy.heroku.com/site/notify",
  #     "return_url"=>"http://tiendafy.heroku.com/site/done",
  #     "cancel_return_url"=>"http://mystore.com"
  #   }
  # }

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

  def confirmation
    Rails.logger.info(params.inspect)
    if params[:security_key] == "akjsndk777777"
     render :text => "AUTHORISED"
    else
     render :text => "DECLINED"
    end
  end
end