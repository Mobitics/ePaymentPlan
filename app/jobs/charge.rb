class Charge
  @queue = :charge

  def self.perform(payment_plan_id)
    plan = PaymentPlan.find(payment_plan_id)
    plan.make_payment
  end
end

