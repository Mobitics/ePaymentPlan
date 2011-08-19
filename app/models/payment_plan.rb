class PaymentPlan < ActiveRecord::Base
  

  attr_readonly :amount, :shipping, :tax, :notify_url, :return_url, :cancel_return_url, :num, :account,:first_payment_rate

  belongs_to :store
  belongs_to :payment_profile
  belongs_to :plan

  has_one :customer, :through => :payment_profile
  has_many :payments, :dependent => :destroy

  # after_create :notify_store

  # before_create :validate_payment_inactive
  # 
  # def validate_payment_inactive
  #   errors.add(:customer, "This customer have a active plan")  if customer.active_orders? 
  # end

  def create
    return true if super and create_first_payment
    self.destroy if self.id
    false
  end

  def amount_to_pay
    payment = self.amount.to_f / self.payments_count.to_f
    if first_payment_rate!=0
  		payment = (amount.to_f- (amount.to_f*first_payment_rate.to_f / 100.to_f))/ (self.payments_count.to_f-1)
 		if payments.count==0
 			payment = amount.to_f* (first_payment_rate.to_f / 100.to_f)
 		end 	
  	end
    
    payment = payment / (1.0 - (self.interest.to_f / 100.to_f))
    payment.finite? ? "%.2f" % payment : nil
  end

  def make_payment
    payment = self.payments.build({'payment' => self.amount_to_pay})
    if payments_pending? && payment.save
      if payments_pending?
      	setup_next_payment 
      else
      	self.update_attribute(:active,false)
      end
      return true
    end

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
  
  def update_time
  	self.update_attribute(:updated_at,Time.now)
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
    response = ssl_post(self.notify_url, params)
    Rails.logger.info "Termine ePaymentPlans: Order#notify_store"
  end
  
  def status_color
  	if payments.count>0
  		return "green" if(payments.last.status==Payment::AUTHORISED)
  		return "yellow" if(payments.last.status==Payment::DECLINED and payment_plans.last.payments.last.transactions.count<=3)
  	    return "red" if(payments.last.status==Payment::DECLINED)
  	end
  end
  
  def self.recent
    table = PaymentPlan.arel_table
    conditions = table[:updated_at].gteq(Date.today.beginning_of_day).and(table[:updated_at].lteq(Date.today.end_of_day))
    self.where(conditions).order("updated_at DESC")
  end
  
  def interest_amount
  	return self.amount/(1-(self.interest/100.0))
  end
  def owed
  	return (interest_amount - self.payments.sum(:payment))
  end

  private

  def setup_next_payment
    frequencies = {"monthly" => 1.month, "weekly" => 1.week, "daily" => 1.day, "hourly" => 1.hour}
    Resque.enqueue_in(frequencies[self.frequency], Charge, self.id)
  end

  # Este metodo puede ser utilizado por make_payment con el fin de reutilizar codigo
  # Se renombra y se le da la estructura para poder reutilizarlo
  def create_first_payment
    make_payment
  end

  def ssl_post(url, params)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    headers = {
    'Content-Type' => 'application/x-www-form-urlencoded'
    }
    data = params.to_query
    resp = http.post(uri.path, data, headers)

    # uri = URI.parse(url)
    # request = Net::HTTP::Post.new(uri.path)
    # # request['Content-Length'] = "#{payload.size}"
    # # request['User-Agent'] = "Active Merchant -- http://home.leetsoft.com/am"
    # # request['Content-Type'] = "application/x-www-form-urlencoded"
    # request.form_data = params
    # http = Net::HTTP.new(uri.host, uri.port)
    # http.verify_mode  = OpenSSL::SSL::VERIFY_NONE
    # http.use_ssl      = true
    # http.request(request)
  end
end
