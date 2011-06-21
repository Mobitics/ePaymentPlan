class ApplicationController < ActionController::Base
  #http_basic_authenticate_with :name => "darth", :password => "vader"
  #protect_from_forgery
  
  def user_merchant?
    @user = current_user
    response = @user.role? :merchant unless @user.blank?
    unless response
      flash[:error] = "Access Denied"
      redirect_to root_path
    end
  end

end
