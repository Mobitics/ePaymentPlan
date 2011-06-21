class PaymentPlan < ActiveRecord::Base
  attr_accessor :plan_id, :num, :account

  attr_readonly :amount, :shipping, :tax, :notify_url, :return_url, :cancel_return_url, :num, :account

  belongs_to :payment_profile
  has_many :payments, :dependent => :destroy

  def create
    notify_store and return true if super and create_first_payment
    self.destroy if self.id
    false
  end

  def amount_to_pay
    payment = self.amount.to_f / self.payments_count.to_f
    interests = payment * (self.interest.to_f / 100.to_f)
    (payment + interests).finite? ? "%.2f" % (payment + interests) : nil
  end

  def make_payment
    payment = self.payments.build({'payment' => self.amount_to_pay})
    return true if payments_pending? && payment.save

    payment.errors.full_messages.each do |errmsg|
      errors.add(:payment, errmsg)
    end
    false
  end

  def payments_pending?
    self.payments.count < self.payments_count
  end

  private

  # Este metodo puede ser utilizado por make_payment con el fin de reutilizar codigo
  # Se renombra y se le da la estructura para poder reutilizarlo
  def create_first_payment
    make_payment
  end

  def notify_store
    #url = URI.parse(notify_url)
    #request = Net::HTTP::Post.new(url.path)
    #request['Content-Type'] = "application/x-www-form-urlencoded" 
    #request.set_form_data({:security_key=>"akjsndk777777", :transaction_id => 123444,
    #                                    :order_id => num , :received_at => created_at, 
    #                                    :status => "completed", :test => 'test'}, ';')

    #response = Net::HTTP.new(url.host, url.port).start {|http| http.request(request) }
    Rails.logger.info "Llegue a ePaymentPlans: Order#notify_store"
    transaction = self.payments.first.transactions.last
    params = {
      :security_key   => transaction.auth_code,
      :transaction_id => transaction.id,
      :order_id       => self.order_id,
      :received_at    => transaction.created_at,
      :status         => "completed",
      :gross          => "%.2f" % self.amount.to_f
    }
    params.merge!({:test => 'test'}) if Rails.env.staging?
    response = Net::HTTP.post_form(URI.parse(self.notify_url), params)
    Rails.logger.info "Termine ePaymentPlans: Order#notify_store"
  end
end
