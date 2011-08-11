require 'active_merchant'

class Customer < ActiveRecord::Base
  include ActiveMerchant::Utils

  attr_accessor :company, :phone, :country, :city, :address1, :address2, :state, :zip
  attr_accessor :billing_address, :shipping_address,:create_at

  belongs_to :store
  has_many :payment_profiles, :dependent => :destroy
  has_many :payment_plans, :through => :payment_profiles

  validates :email, :presence => true, :uniqueness => {:scope => :store_id}, :format => {:with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i} 
  validates_associated :store

  def full_name
    "#{first_name} #{last_name}"
  end

  def active_orders
    self.payment_plans.where(:active => true)
  end

  def active_orders?
    !self.active_orders.empty?
  end

  def status_color
    if(payment_plans.count>0)
      return payment_plans.last.status_color	
    end
  end

  def create
    if super and create_cim_profile
      return true
    else
      self.destroy if self.id
      return false
    end
  end

  def update
    if super and update_cim_profile
      return true
    end
    return false
  end

  def destroy
    if delete_cim_profile and super
      return true
    end
    return false
  end

  def has_payment_profile_with?(params)
    self.payment_profiles.each do |payment_profile|
      return payment_profile if payment_profile.matches?(params.dup.to_hash)
    end
    return nil
  end

  def payment_gateway
    return get_payment_gateway(store.authorize_net.api_login_id, store.authorize_net.transaction_key, store.authorize_net.test_mode) unless store.authorize_net.blank?
    get_payment_gateway
  end

  private

  def create_cim_profile
    @gateway = payment_gateway

    response = @gateway.create_customer_profile({:profile => user_profile})
    if response.success? and response.authorization
      self.update_attribute(:customer_cim_id, response.authorization)
      return true
    end
    # if /A duplicate record with ID (\d+) already exists./.match(response.message)
    #   update_attributes({:customer_cim_id => $1})
    #   return true
    # end
    self.errors[:base] << response.message
    return false
  end

  def update_cim_profile
    return false unless self.customer_cim_id

    @gateway = payment_gateway
    response = @gateway.update_customer_profile(
    :profile => user_profile.merge({:customer_profile_id => self.customer_cim_id})
    )
    !!response.success?
  end

  def delete_cim_profile
    @gateway = payment_gateway
    response = @gateway.delete_customer_profile(:customer_profile_id => self.customer_cim_id)
    !!response.success?
  end

  def user_profile
    return {:merchant_customer_id => self.id, :email => self.email, :description => self.email}
  end
end
