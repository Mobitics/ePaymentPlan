class PaymentPlansController < ApplicationController
  layout "checkout"

  def step1
    @user = User.find_by_email(params[:order].delete(:account))
    @store = @user.store
    @plans = @store.plans
    @customer = build_customer(params[:order])
    @payment_plan = PaymentPlan.new(params[:order].merge(:order_id => params[:order].delete(:num)))
  end

  def step2
    @user = User.find_by_email(params[:user][:email])
    @store = @user.store
    @plans = @store.plans
    customer = Customer.find_or_create_by_email(params[:customer][:email])
    @customer = build_customer(params[:customer], customer)
    @payment_plan = PaymentPlan.new(params[:payment_plan].merge(:store_id => @store.id))
    @payment_profile = PaymentProfile.new
    @plan = Plan.find_by_id(@payment_plan.plan_id)
    if @plan
      @payment_plan.interest = @plan.interest
      @payment_plan.late_fee = @plan.late_fee
      @payment_plan.includes_shipping = @plan.includes_shipping
      @payment_plan.includes_tax = @plan.includes_tax
      @payment_plan.payments_count = @plan.payments_count
      @payment_plan.frequency = @plan.frequency
    else
      flash[:error] = "Please select a valid payment plan from the list."
      render :action => "step1" and return
    end
    unless @customer.customer_cim_id?
      unless @customer.send(:create_cim_profile)
        render :action => "step1" and return
      end
    end
    render :action => "step1" and return unless @customer.valid?
  end

  def create
    customer = Customer.find_by_email(params[:customer][:email])
    @customer = build_customer(params[:customer], customer)
    @payment_plan = PaymentPlan.new(params[:payment_plan])
    @payment_profile = @customer.has_payment_profile_with?(params[:payment_profile])
    unless @payment_profile
      @payment_profile = @customer.payment_profiles.build params[:payment_profile]
      render :action => "step2" and return unless @payment_profile.save
    end
    @payment_plan.payment_profile_id = @payment_profile.id
    if @payment_plan.save
      redirect_to @payment_plan.return_url
    else
      render :action => "step2" and return
    end
  end

  def confirmation
    Rails.logger.info(params.inspect)
    transaction = Transaction.find_by_auth_code(params[:security_key])
    if transaction
     render :text => "AUTHORISED"
    else
     render :text => "DECLINED"
    end
  end

  private

  def build_customer(params = {}, customer = nil)
    attributes = params[:billing_address].nil? ? params : params[:billing_address].dup.merge!({:email => params.delete(:email)})
    customer = Customer.new unless customer
    customer.email            = attributes.delete(:email)
    customer.first_name       = attributes.delete(:first_name)
    customer.last_name        = attributes.delete(:last_name)
    customer.company          = attributes.delete(:company)
    customer.phone            = attributes.delete(:phone)
    customer.country          = attributes.delete(:country)
    customer.city             = attributes.delete(:city)
    customer.address1         = attributes.delete(:address1)
    customer.address2         = attributes.delete(:address2)
    customer.state            = attributes.delete(:state)
    customer.zip              = attributes.delete(:zip)
    customer.billing_address  = attributes.delete(:billing_address)
    customer.shipping_address = attributes.delete(:shipping_address)
    customer
  end
end
