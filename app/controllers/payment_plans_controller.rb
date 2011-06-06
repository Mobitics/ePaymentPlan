class PaymentPlansController < ApplicationController
  layout "checkout"

  def step1
    @user = get_user(params[:order])
    @payment_plan = PaymentPlan.new(params[:order])
    @plans = Plan.all
  end

  def step2
    user = User.find_or_create_by_email(params[:user][:email], {:password => "111111"})
    @user = get_user(params[:user], user)
    @payment_plan = PaymentPlan.new(params[:payment_plan])
    @payment_profile = PaymentProfile.new
    @plan = Plan.find_by_id(@payment_plan.plan_id)
    @plans = Plan.all
    if @plan
      @payment_plan.interest = @plan.interest
      @payment_plan.late_fee = @plan.late_fee
      @payment_plan.includes_shipping = @plan.includes_shipping
      @payment_plan.includes_tax = @plan.includes_tax
      @payment_plan.payments_count = @plan.payments_count
    else
      flash[:error] = "Please select a valid payment plan from the list."
      render :action => "step1" and return
    end
    unless @user.customer_cim_id?
      unless @user.send(:create_cim_profile)
        render :action => "step1" and return
      end
    end
    render :action => "step1" and return unless @user.valid?
  end

  def create
    user = User.find_by_email(params[:user][:email])
    @user = get_user(params[:user], user)
    @payment_plan = PaymentPlan.new(params[:payment_plan])
    @payment_profile = @user.has_payment_profile_with?(params[:payment_profile])
    unless @payment_profile
      @payment_profile = @user.payment_profiles.build params[:payment_profile]
      render :action => "step2" and return unless @payment_profile.save
    end
    @payment_plan.payment_profile_id = @payment_profile.id
    if @payment_plan.save
      redirect_to @payment_plan.return_url
    else
      render :action => "step2" and return
    end
  end

  private

  def get_user(params = {}, user = nil)
    attributes = params[:billing_address].nil? ? params : params[:billing_address].dup.merge!({:email => params.delete(:email)})
    user = User.new unless user
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
