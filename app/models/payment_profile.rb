require 'active_merchant'
class PaymentProfile < ActiveRecord::Base
  include ActiveMerchant::Billing
  include ActiveMerchant::Utils
  
  belongs_to :customer
  has_many :payment_plans
  has_many :transactions, :dependent => :destroy

  attr_accessor :address
  attr_accessor :credit_card

  validates_presence_of :customer_id, :credit_card, :address

  def create
    if super and create_payment_profile
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

  def matches?(params)
    return false unless params
    params.symbolize_keys!
    return false unless params[:address] && params[:credit_card]
    params[:address] = params[:address].to_hash.symbolize_keys!
    params[:credit_card] = params[:credit_card].to_hash.symbolize_keys!

    @gateway = customer.payment_gateway
    profile = {
      :customer_profile_id => self.customer.customer_cim_id,
      :customer_payment_profile_id => self.payment_cim_id
    }
    response = @gateway.get_customer_payment_profile(profile)
    if response.success?
      Rails.logger.info "="*80
      Rails.logger.info response.inspect
      Rails.logger.info "="*80
      Rails.logger.info params.inspect
      Rails.logger.info "="*80

      cc_info = response.params['payment_profile']['payment']['credit_card']
      bill_info = response.params['payment_profile']['bill_to']

      matches =
        bill_info['address'].eql?(params[:address][:address1]) &&
        bill_info['city'].eql?(   params[:address][:city]) &&
        bill_info['state'].eql?(  params[:address][:state]) &&
        bill_info['zip'].eql?(    params[:address][:zip]) &&
        bill_info['country'].eql?(params[:address][:country]) &&
        cc_info['card_number'].last(4).eql?(params[:credit_card][:number].to_s.last(4))

      return matches
    end
    return false
  end

  private
  
  def create_payment_profile
    unless self.payment_cim_id.blank?
      return false
    end

    @gateway = customer.payment_gateway

    @profile = {:customer_profile_id => self.customer.customer_cim_id,
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
    self.errors[:base] << response.message
    return false
  end

  def update_payment_profile
    @gateway = customer.payment_gateway

    @profile = {:customer_profile_id => self.customer.customer_cim_id,
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
    @gateway = customer.payment_gateway

    response = @gateway.delete_customer_payment_profile(:customer_profile_id => self.customer.customer_cim_id,
                                                        :customer_payment_profile_id => self.payment_cim_id)
    if response.success?
      return true
    end
    return false
  end
end
