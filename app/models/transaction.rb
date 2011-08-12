require 'active_merchant'
class Transaction < ActiveRecord::Base
  include ActiveMerchant::Billing
  include ActiveMerchant::Utils
  
  belongs_to :payment_profile
  belongs_to :payment
  
  attr_accessor :amount
  
  validates_presence_of :amount

  def create
    if super and process
      return true
    else
      if self.id
        self.destroy
      end
      return false
    end
  end

  def process
    @gateway = self.payment_profile.customer.payment_gateway
    response = @gateway.create_customer_profile_transaction({
      :transaction => {
        :type => :auth_capture,
        :amount => self.amount.to_s,
        :customer_profile_id => self.payment_profile.customer.customer_cim_id,
        :customer_payment_profile_id => self.payment_profile.payment_cim_id
        }
      })
    if response.success?
      self.update_attributes({
        :auth_code        => response.params['direct_response']['approval_code'],
        :confirmation_id  => response.params['direct_response']['transaction_id']
      })
      return true
    else 
      self.update_attributes({:error => !response.success?,
                         :error_code => response.params['messages']['message']['code'],
                         :error_message => response.params['messages']['message']['text']})
      self.errors[:base] << response.message                          
      return false
    end
  end

  def authorized?
    self.confirmation_id?
  end
end
