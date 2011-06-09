class Payment < ActiveRecord::Base
  AUTHORISED = "Authorised"
  DECLINED = "Declined"
  PENDING = "Pending"

  belongs_to :payment_plan
  has_many :transactions

  validates_associated :payment_plan
  validates_presence_of :payment
  
  def create
    transaction = create_transaction
    if transaction and super
      if transaction.authorized?
        transaction.update_attribute(:payment_id, self.id)
        self.update_attribute(:status, AUTHORISED)
        return true
      else
        errors.add(:transaction, "was not authorized")
        transaction.destroy
        self.destroy
      end
    end
    false
  end

  private

  def create_transaction
    transaction = self.payment_plan.payment_profile.transactions.build({'amount' => self.payment})
    return transaction if transaction.save
    transaction.errors.full_messages.each do |errmsg|
      errors.add(:transaction, errmsg)
    end
    false
  end
end
