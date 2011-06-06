class Payment < ActiveRecord::Base
  belongs_to :payment_plan
  has_many :transactions

  validates_associated :payment_plan
  validates_presence_of :payment
  
  def create
    transaction = create_transaction
    if transaction and super
      if transaction.authorized?
        transaction.update_attribute(:payment_id, self.id)
        return true
      else
        errors.add(:transaction, "was not authorized")
        transaction.destroy
        self.destroy
      end
    end
    false
  end

  after_save :notify_store

  def notify_store
    #url = URI.parse(notify_url)
    #request = Net::HTTP::Post.new(url.path)
    #request['Content-Type'] = "application/x-www-form-urlencoded" 
    #request.set_form_data({:security_key=>"akjsndk777777", :transaction_id => 123444,
    #                                    :order_id => num , :received_at => created_at, 
    #                                    :status => "completed", :test => 'test'}, ';')

    #response = Net::HTTP.new(url.host, url.port).start {|http| http.request(request) }
    Rails.logger.info "Llegue a ePaymentPlans: Order#notify_store"
    # response = Net::HTTP.post_form(URI.parse(notify_url), 
    #                                {:security_key=>"akjsndk777777", :transaction_id => 123444,
    #                                 :order_id => num , :received_at => created_at, 
    #                                 :status => "completed", :test => 'test'})
    Rails.logger.info "Termine ePaymentPlans: Order#notify_store"
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
