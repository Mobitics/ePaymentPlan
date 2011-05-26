require 'active_merchant'
class PaymentProfile < ActiveRecord::Base
  include ActiveMerchant::Billing
  include ActiveMerchant::Utils
  
  belongs_to :user

  attr_accessor :address
  attr_accessor :credit_card

  validates_presence_of :user_id, :credit_card, :address

  def create
    if super and create_payment_profile
      user.update_attributes({:payment_profile_id => self.id})
      return true
    else
      if self.id
        self.destroy
      end
      return false
    end
  end

  def update
    if super and update_payment_profile
      return true
    end
    return false
  end

  def destroy
    if delete_payment_profile and super
      return true
    end
    return false
  end

  private
  
  def create_payment_profile
    if not self.payment_cim_id
      return false
    end
    @gateway = get_payment_gateway

    @profile = {:customer_profile_id => self.user.customer_cim_id,
                :payment_profile => {:bill_to => self.address,
                                     :payment => {:credit_card => CreditCard.new(self.credit_card)}
                                     }
                }
    response = @gateway.create_customer_payment_profile(@profile)
    if response.success? and response.params['customer_payment_profile_id']
      update_attributes({:payment_cim_id => response.params['customer_payment_profile_id']})
      self.address = {}
      self.credit_card = {}
      return true
    end
    return false
  end

  def update_payment_profile
    @gateway = get_payment_gateway

    @profile = {:customer_profile_id => self.user.customer_cim_id,
                :payment_profile => {:customer_payment_profile_id => self.payment_cim_id,
                                     :bill_to => self.address,
                                     :payment => {:credit_card => CreditCard.new(self.credit_card)}
                                     }
                }
    response = @gateway.update_customer_payment_profile(@profile)
    if response.success?
      self.address = {}
      self.credit_card = {}
      return true
    end
    return false
  end

  def delete_payment_profile
    @gateway = get_payment_gateway

    response = @gateway.delete_customer_payment_profile(:customer_profile_id => self.user.customer_cim_id,
                                                        :customer_payment_profile_id => self.payment_cim_id)
    if response.success?
      return true
    end
    return false
  end
end
