class PaymentPlan < ActiveRecord::Base
  attr_accessor :plan_id

  attr_readonly :amount, :shipping, :tax, :notify_url, :return_url, :cancel_return_url, :num, :account

  belongs_to :store
  belongs_to :payment_profile

  has_one :customer, :through => :payment_profile
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

    if payments_pending?
      payment.errors.full_messages.each do |errmsg|
        errors.add(:payment, errmsg)
      end
    else
      errors.add(:payments, "have been completed.")
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
      :item_id        => self.order_id,
      :received_at    => transaction.created_at,
      :status         => "completed",
      :gross          => "%.2f" % self.amount.to_f,
      :currency       => "USD"
    }
    params.merge!({:test => 'test'}) if Rails.env.staging?
    ssl_post(self.notify_url, params)
    Rails.logger.info response.body
    Rails.logger.info "Termine ePaymentPlans: Order#notify_store"
  end

  def ssl_post(url, params)
    uri = URI.parse(url)
    request = Net::HTTP::Post.new(uri.path)
    # request['Content-Length'] = "#{payload.size}"
    # request['User-Agent'] = "Active Merchant -- http://home.leetsoft.com/am"
    # request['Content-Type'] = "application/x-www-form-urlencoded"
    request.form_data = params
    http = Net::HTTP.new(uri.host, uri.port)
    http.verify_mode  = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl      = true
    http.request(request)
  end
end
