class PaymentProfilesController < ApplicationController
  
  def index
    @user = User.find params[:user_id]
    @payment_profiles = @user.payment_profiles
  end
  
  def new
    @user = User.find params[:user_id]
    @payment_profile = PaymentProfile.new
  end
  
  def create
    @user = User.find params[:user_id]
    p params[:payment_profile]
    @payment_profile = @user.payment_profiles.build params[:payment_profile]
    p @payment_profile
    if @payment_profile.save
      redirect_to user_payment_profiles_path(@user)
    else
      render :new
    end
  end
  
  def show
    @user = User.find params[:user_id]
    @payment_profile = @user.payment_profiles.find params[:id]
  end
end
