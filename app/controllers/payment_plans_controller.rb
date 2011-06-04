class PaymentPlansController < ApplicationController
  layout "checkout"

  def step1
    @user = get_user(params[:order])
    @payment_plan = PaymentPlan.new(params[:order])
    @plans = Plan.all
  end

  def step2
    @user = get_user(params[:user])
    @payment_plan = PaymentPlan.new(params[:payment_plan])
    @payment_profile = PaymentProfile.new
    @plans = Plan.all
  end

  def create
    flash[:notice] = "Feature in progress"
    redirect_to root_path
    # @user = User.find_or_create_by_email(params[:user][:email])
    # @payment_profile = @user.payment_profiles.build params[:payment_profile]
    # if @payment_profile.save
    #   @payment_plan = PaymentPlan.new(params[:payment_plan])
    #   if @payment_plan.save
    #     
    #   end
    # end
  end

  private

  def get_user(params = {})
    attributes = params[:billing_address].nil? ? params : params[:billing_address].dup
    user = User.new
    user.email            = attributes.delete(:email)
    user.first_name       = attributes.delete(:first_name)
    user.last_name        = attributes.delete(:last_name)
    user.phone            = attributes.delete(:phone)
    user.country          = attributes.delete(:country)
    user.city             = attributes.delete(:city)
    user.address1         = attributes.delete(:address1)
    user.address2         = attributes.delete(:address2)
    user.state            = attributes.delete(:state)
    user.zip              = attributes.delete(:zip)
    user.billing_address  = attributes.delete(:billing_address)
    user.shipping_address = attributes.delete(:shipping_address)
    user
  end
end
