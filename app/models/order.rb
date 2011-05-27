class Order < ActiveRecord::Base
  attr_readonly :amount, :shipping, :tax, :notify_url, :return_url, :cancel_return_url, :num, :account
  after_save :notify_store
  
  def notify_store
    request = Net::HTTP::Post.new(notify_url)
    request['Content-Type'] = "application/x-www-form-urlencoded" 

    http = Net::HTTP.new(notify_url)
    response = http.request(request, {:security_key=>"akjsndk777777", :transaction_id => 123444,
                                      :order_id => num , :received_at => created_at, 
                                      :status => "completed"})
  end
end
