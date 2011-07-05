class Charge
  @queue = :charge

  def self.perform(payment_plan_id)
    puts "Performing job.."
    plan = PaymentPlan.find(payment_plan_id)
    puts "Payment Plan: #{plan.inspect}"
    payment = plan.make_payment
    puts "Payment Result: #{payment.inspect}"
    puts "Job performed."
  end
end

