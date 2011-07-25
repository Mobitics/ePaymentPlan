class PaymentPlansController < ApplicationController
  layout "checkout"

  def step1
    @user = User.find_by_email(params[:order].delete(:account))
    # Error if a user with provided email is not found: STORE DOES NOT EXIST => @user.blank?
    @store = @user.store
    @plans = @store.plans
    customer = @store.customers.find_or_create_by_email(params[:order][:email].downcase)
    @customer = build_customer(params[:order], customer)
    
    @payment_plan = PaymentPlan.new(params[:order].merge(:order_id => params[:order].delete(:num), :store_id => @store.id))
    @payment_profile = PaymentProfile.new
    @customer.send(:create_cim_profile) unless @customer.customer_cim_id?
  end

  def step2
    @user = User.find_by_email(params[:user][:email])
    @store = @user.store
    @plans = @store.plans
    customer = @store.customers.find_or_create_by_email(params[:customer][:email].downcase)
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
    @user = User.find_by_email(params[:user][:email])
    @store = @user.store
    @plans = @store.plans
    customer = @store.customers.find_by_email(params[:customer][:email].downcase)
    @customer = build_customer(params[:customer], customer)
    @payment_plan = PaymentPlan.new(params[:payment_plan])
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
    @payment_profile = @customer.has_payment_profile_with?(params[:payment_profile])
    unless @payment_profile
      @payment_profile = @customer.payment_profiles.build params[:payment_profile]
      render :action => "step1" and return unless @payment_profile.save
    end
    @payment_plan.payment_profile_id = @payment_profile.id
    if @payment_plan.save
      @payment_plan.notify_store
      redirect_to @payment_plan.return_url
    else
      render :action => "step1" and return
    end
  end

  def confirmation
    Rails.logger.info(params.inspect)
    Rails.logger.info("Transaction id: #{params[:transaction_id]}")
    Rails.logger.info("Transaction id: #{params['transaction_id']}")
    Rails.logger.info(Transaction.last.inspect)
    transaction = Transaction.find(params[:transaction_id])
    if transaction # Need to verify all parameters received to match same as sent in notify
      Rails.logger.info("Transaction was found. Rendering text: AUTHORISED")
      render :text => "AUTHORISED"
    else
      Rails.logger.info("Transaction was not found. Rendering text: DECLINED")
      render :text => "DECLINED"
    end
  end

  private

  def build_customer(params = {}, customer = nil)
    attributes = params[:billing_address].nil? ? params : params[:billing_address].dup.merge!({:email => params.delete(:email)})
    customer = Customer.new unless customer
    customer.email            = attributes.delete(:email).downcase
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
