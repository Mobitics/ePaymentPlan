class ApplicationController < ActionController::Base
  #http_basic_authenticate_with :name => "darth", :password => "vader"
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || user_path
  end

  def user_path
    current_user.store? ? store_root_path : root_path
  end

  def authorized_store
    unless current_user && current_user.store?
      flash[:notice] = "Access Denied"
      redirect_to root_path
    else
      @store = current_user.store
    end
  end
end