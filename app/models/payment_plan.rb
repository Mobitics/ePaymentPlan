class PaymentPlan < ActiveRecord::Base
  attr_accessor :customer, :num, :plan_id
  
  attr_readonly :amount, :shipping, :tax, :notify_url, :return_url, :cancel_return_url, :num, :account

  #     "num"=>"1000",
  #     "amount"=>"50.0",
  #     "first_name"=>"Cody",
  #     "last_name"=>"Fauser",
  #     "email"=>"codyfauser@gmail.com",
  #     "phone"=>"(555)555-5555",
  #     "country"=>"CA",
  #     "city"=>"Ottawa",
  #     "address1"=>"21 Snowy Brook Lane",
  #     "address2"=>"Apt. 36",
  #     "state"=>"ON",
  #     "zip"=>"K1J1E5",
  #     "shipping"=>"0.00",
  #     "tax"=>"0.00",
  #     "notify_url"=>"http://tiendafy.heroku.com/site/notify",
  #     "return_url"=>"http://tiendafy.heroku.com/site/done",
  #     "cancel_return_url"=>"http://mystore.com"

  # t.integer :order_id
  # t.float :amount
  # t.float :shipping
  # t.float :tax
  # t.float :interest
  # t.float :late_fee
  # t.boolean :includes_shipping
  # t.boolean :includes_tax
  # t.integer :payments_count
  # t.integer :payment_profile_id
  # 
  # t.string :notify_url
  # t.string :return_url
  # t.string :cancel_return_url


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
    response = Net::HTTP.post_form(URI.parse(notify_url), 
                                   {:security_key=>"akjsndk777777", :transaction_id => 123444,
                                    :order_id => num , :received_at => created_at, 
                                    :status => "completed", :test => 'test'})
    Rails.logger.info "Termine ePaymentPlans: Order#notify_store"
  end
end
