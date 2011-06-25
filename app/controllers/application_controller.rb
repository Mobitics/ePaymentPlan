class ApplicationController < ActionController::Base
  #http_basic_authenticate_with :name => "darth", :password => "vader"
  #protect_from_forgery
  
  def after_sign_in_path_for(resource)
    merchant = user_merchant?
    welcome_path = merchant ? merchant_path : root_path
    stored_location_for(resource) || welcome_path
  end
  
  def user_merchant?
    @user = current_user
    p @user
    response = @user.role? :merchant unless @user.blank?
    response
  end
  
  def merchant_required
    merchant = user_merchant?
    unless merchant
      flash[:notice] = "Access Denied"
      redirect_to root_path
    end
  end

end
