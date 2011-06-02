require 'active_merchant'
class User < ActiveRecord::Base
  include ActiveMerchant::Utils
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :payment_profiles, :dependent => :destroy

  def create
    if super and create_cim_profile
      return true
    else
      if self.id
        self.destroy
      end
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

  private
  
  def create_cim_profile
    @gateway = get_payment_gateway

    @user = {:profile => user_profile}

    response = @gateway.create_customer_profile(@user)
    if response.success? and response.authorization
      update_attributes({:customer_cim_id => response.authorization})
      return true
    end
    self.errors.add_to_base response.params['messages']['message']['text']
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
