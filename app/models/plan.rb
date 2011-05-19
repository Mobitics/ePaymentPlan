class Plan < ActiveRecord::Base
  validates_presence_of :payments_count, :interest, :late_fee
  validates_presence_of :min_price, :max_price, :if => :by_price
  #validates_presence_of :product_id
  
  def by_price
    self.plan_type.eql? "by_price"
  end

end
