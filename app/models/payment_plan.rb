class PaymentPlan < ActiveRecord::Base
  attr_accessor :plan_id, :num
  
  attr_readonly :amount, :shipping, :tax, :notify_url, :return_url, :cancel_return_url, :num

  belongs_to :payment_profile
  has_many :payments, :dependent => :destroy

  def create
    return true if super and create_first_payment
    self.destroy if self.id
    false
  end
  
  def amount_to_pay
    payment = self.amount.to_f / self.payments_count.to_f
    interests = payment * (self.interest.to_f / 100.to_f)
    (payment + interests).finite? ? "%.2f" % (payment + interests) : nil
  end

  def make_payment
    
  end

  private

  # Este metodo puede ser utilizado por make_payment con el fin de reutilizar codigo
  # Se renombra y se le da la estructura para poder reutilizarlo
  def create_first_payment
    payment = self.payments.build({'payment' => self.amount_to_pay})
    unless payment.save
      payment.errors.full_messages.each do |errmsg|
        errors.add(:payment, errmsg)
      end
      return false
    end
    true
  end
end
