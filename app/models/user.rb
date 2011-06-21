require 'active_merchant'
class User < ActiveRecord::Base
  include ActiveMerchant::Utils
  ROLES = [:user, :merchant]

  attr_accessor :first_name, :last_name, :company, :phone, :country, :city, :address1, :address2, :state, :zip
  attr_accessor :billing_address, :shipping_address

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  validates :email, :presence => true, :uniqueness => true, :format => {:with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i} 

  has_many :plans, :foreign_key => :merchant_id, :dependent => :destroy
  has_many :payment_profiles, :dependent => :destroy
  has_and_belongs_to_many :roles
  
  def role?(role_sym)
    roles.any? { |r| r.title.underscore.to_sym == role_sym }
  end

  def create
    if super and create_cim_profile
      return true
    else
      p "*"*100
      p self.errors
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

  private
  
  def create_cim_profile
    @gateway = get_payment_gateway

    @user = {:profile => user_profile}

    response = @gateway.create_customer_profile(@user)
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
    if not self.customer_cim_id
      return false
    end
    @gateway = get_payment_gateway

    response = @gateway.update_customer_profile(:profile => user_profile.merge({
        :customer_profile_id => self.customer_cim_id
      }))

    if response.success?
      return true
    end
    return false
  end

  def delete_cim_profile
    @gateway = get_payment_gateway

    response = @gateway.delete_customer_profile(:customer_profile_id => self.customer_cim_id)

    if response.success?
      return true
    end
    return false
  end

  def user_profile
    return {:merchant_customer_id => self.id, :email => self.email, :description => self.email}
  end
end
