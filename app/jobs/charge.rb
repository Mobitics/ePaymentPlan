class Charge
  @queue = :charge

  def self.perform(payment_profile_id)
    profile = PaymentProfile.find(payment_profile_id)
    profile.make_payment
  end
end

