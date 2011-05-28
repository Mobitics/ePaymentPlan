class Order < ActiveRecord::Base
  attr_readonly :amount, :shipping, :tax, :notify_url, :return_url, :cancel_return_url, :num, :account
  after_save :notify_store
  
  def notify_store
    url = URI.parse(notify_url)
    request = Net::HTTP::Post.new(url.path)
    request['Content-Type'] = "application/x-www-form-urlencoded" 
    request.set_form_data({:security_key=>"akjsndk777777", :transaction_id => 123444,
                                        :order_id => num , :received_at => created_at, 
                                        :status => "completed", :test => 'test'}, ';')

    response = Net::HTTP.new(url.host, url.port).start {|http| http.request(request) }
  end
end
